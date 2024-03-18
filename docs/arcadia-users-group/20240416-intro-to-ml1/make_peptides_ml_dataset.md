## Documentation for how the dataset was made

0. We used the environment defined in `make_peptides_ml_dataset.yml` to make the data set below.
1. Originally, we downloaded the peptipedia database using the following Google Drive link:  https://drive.google.com/file/d/1x3yHNl8k5teHlBI2FMgl966o51s0T8i_/view?usp=sharing. The link for this database is provided by the [peptipedia GitHub repo](https://github.com/ProteinEngineering-PESB2/Peptipedia2.0). For persistence, we uploaded this file to [this OSF repository](https://osf.io/kb7z6/), as well as some of the processed data created by the code below.
2. Unzip the database.
3. The unzipped archive contains three files, `backup_sql.zip`, `peptipedia_csv.zip`, and `peptipedia_fasta.zip`.
   Unzipping `peptipedia_fasta.zip` results in a FASTA file `peptipedia.fasta` that contains all of the peptide sequences from the peptipedia database.
   Unzipping `peptipedia_csv.zip` results in a CSV file `peptipedia.csv` that records the peptide id, peptide sequence, and predicted bioactivity labels.
   Unzipping `backup_sql.zip` results in a postgres SQL dump file `backup_dump.sql`.
   This file contains metadata associated with the peptide sequences.
   To extract the metadata to separate CSV tables, we used the python code:
   ```py
   import re
   
   output_file_prefix = 'table_'
   current_table = None
   output_file = None
   
   with open('backup_dump.sql', 'r') as dump_file:
       for line in dump_file:
           # Check for COPY command start
           if line.startswith('COPY'):
               table_name = line.split()[1]  # Assumes table name is the second word
               current_table = table_name
               output_file = open(f'{output_file_prefix}{current_table}.csv', 'w')
           elif line.startswith('\.'):
               # End of data for the current table
               if output_file:
                   output_file.close()
                   output_file = None
           elif output_file:
               # Convert tab-separated values to comma-separated values
               csv_line = line.replace('\t', ',')
               output_file.write(csv_line)
   ```

   This code extracts the following CSV files:
   ```
   table_public.activity.csv
   table_public.activity_spectral.csv
   table_public.db.csv
   table_public.encoding.csv
   table_public.gene_ontology.csv
   table_public.index.csv
   table_public.patent.csv
   table_public.peptide.csv
   table_public.peptide_has_activity.csv
   table_public.peptide_has_db_has_index.csv
   table_public.peptide_has_go.csv
   table_public.pfam.csv
   ```

4. Filter to peptides that are at least k in length. MMSeqs2 clustering in step 4 will fail if any of the sequences are below the k-mer length used for clustering.
   ```bash
   seqkit seq --min-len 10 -o peptipedia_minlen10.fasta peptipedia.fasta
   ```

5. Cluster the sequences.
   The goal of this step is to reduce homology in peptide sequences so that the data set can be split in any way and not have pollution between the train and test sets.
   It uses a threshold of 80% because this has been previously shown to be sufficient for homology reduction in protein sequences ([source](https://academic.oup.com/nar/article/47/8/e43/5314020)).
   ```bash
   mmseqs easy-cluster peptipedia_minlen10.fasta mmseqs/peptipedia_minlen10-0.8 tmp --min-seq-id 0.8
   ```

6. Filter to clusters composed of peptides that all have the same bioactivity prediction and write a TSV file.
   Many of the peptides that end up in clusters have multiple bioactivity predictions (e.g. antimicrobial and therapeutic).
   The script below filters to peptide clusters that all have at least one bioactivity label that is the same.
   It also adds additional metadata (GO, PFAM) from the SQL database to the data.frame of peptide information.
   ```r
   library(tidyverse)
   library(janitor)
   
   # The goal of this script is to create a demo machine learning data set from peptides and their metadata.
   # It filters peptides in the peptipedia database to large clusters of similar peptides
   # (80% identity or greater) that all have the same bioactivity label.
   # It then joins selected peptides to their metadata.
   
   # filter to peptides clusters with many members that have the same bioactivity --------

   # read in cluster information from mmseqs2 linclust
   clusters <- read_tsv("~/Downloads/backup_peptipedia_29_03_2023/mmseqs/peptipedia_minlen10-0.8_cluster.tsv",
                        col_names = c("rep", "member"))
   
   # read in peptide bioactivity information
   peptide_bioactivity <- read_csv('~/Downloads/backup_peptipedia_29_03_2023/peptipedia.csv') %>%
     clean_names()
   
   # make the data set a little bit smaller by filtering to clusters that have > 2 members
   # otherwise, the lines of code to find clusters with all of the same bioactivity takes too long
   cluster_sizes <- clusters %>%
     group_by(rep) %>%
     tally() %>%
     arrange(desc(n))
   
   large_clusters <- cluster_sizes %>%
     filter(n > 2)
   
   clusters_filtered <- clusters %>%
     filter(rep %in% large_clusters$rep)
   
   # filter the bioactivity data set to match
   peptide_bioactivity_filtered <- peptide_bioactivity %>%
     filter(idpeptide %in% clusters_filtered$member)
   
   # filter to clusters that all have the same bioactivity
   # (e.g. all peptides have a predicted bioactivity of "antimicrobial" in a given cluster;
   #  note that most peptides have multiple bioactivity labels.
   #  this code filters to clusters where at least one bioactivity label is the same for all peptides in the cluster.)
   peptide_bioactivity_with_clusters <- left_join(clusters_filtered, peptide_bioactivity_filtered,
                                                  by = c("member" = "idpeptide"))
   
   peptide_bioactivity_with_clusters_long <- peptide_bioactivity_with_clusters %>%
     pivot_longer(cols = starts_with("allergen"):last_col(), names_to = "bioactivity", values_to = "value")
   
   # Find clusters where all members have a 1 for any bioactivity
   clusters_all_1_any_bioactivity <- peptide_bioactivity_with_clusters_long %>%
     group_by(rep, bioactivity) %>%
     summarise(all_ones = all(value == 1), .groups = 'drop') %>%
     filter(all_ones) %>%
     distinct(rep, .keep_all = TRUE)
   
   # filter to those clusters where all members have at least 1 bioactivity the same
   peptide_group_bioactivities <- peptide_bioactivity_with_clusters %>%
     filter(rep %in% clusters_all_1_any_bioactivity$rep) %>%
     left_join(clusters_all_1_any_bioactivity, by = "rep") %>%
     # select only the representative for the cluster so that there can't be pollution between test and train data no matter how it is split;
     # sequences will at most be < 80% similar to any other sequence in the dataset.
     filter(rep == member) %>%
     select(peptipedia_peptide_id = rep, peptide_sequence = sequence, group_bioactivity = bioactivity)

   # remove peptides where there are very few representatives (< 50)
   few_peptides_with_group_bioactivity <- peptide_group_bioactivities %>%
     group_by(group_bioactivity) %>%
     tally() %>%
     filter(n < 50)
   
   peptide_group_bioactivities_filtered <- peptide_group_bioactivities %>%
     filter(!group_bioactivity %in% few_peptides_with_group_bioactivity$group_bioactivity)

   # Record all bioactivity predictions for each peptide by concatenating the bioactivity names
   peptide_bioactivities_concatenated <- peptide_bioactivity_with_clusters_long %>%
     filter(value == 1) %>%
     filter(rep == member) %>%
     select(peptipedia_peptide_id = rep, bioactivity, value) %>%
     group_by(peptipedia_peptide_id) %>%
     summarise(all_bioactivities = str_c(bioactivity, collapse = ";"), .groups = 'drop')


   # Join this back to your original (or relevant) dataset to add the concatenated bioactivities column
   final_dataset <- peptide_group_bioactivities_filtered %>%
     left_join(peptide_bioactivities_concatenated, by = "peptipedia_peptide_id") %>%
     distinct()
   
   # join with other peptide metadata ----------------------------------------
   
   gene_ontology <- read_csv("~/Downloads/backup_peptipedia_29_03_2023/table_public.gene_ontology.csv",
                             col_names = c("peptideid", "go_id", "go_description", "go_category")) %>%
     select(peptideid, go_id)

   pfam <- read_csv("~/Downloads/backup_peptipedia_29_03_2023/table_public.pfam.csv",
                    col_names = c("peptideid", "pfam_id", "pfam_name", "pfam_type"))

   final_dataset <- final_dataset %>%
     left_join(gene_ontology, by = c("peptipedia_peptide_id" = "peptideid")) %>%
     left_join(pfam, by = c("peptipedia_peptide_id" = "peptideid")) %>%
     distinct()

   final_dataset %>% group_by(group_bioactivity) %>% tally() %>% arrange(desc(n)) %>% knitr::kable()

   write_tsv(final_dataset, "~/Downloads/backup_peptipedia_29_03_2023/peptides_for_ml_tmp2.tsv")
   ```


6. Convert the output TSV to a FASTA file that can be used to calculate peptide characteristics (molecular weight, etc).
   ```bash
   cut -f1,2 peptides_for_ml_tmp.tsv | tail -n +2 | seqkit tab2fx > peptides_for_ml.fasta
   ```

7. Calculate peptide characteristics (length, mw, etc.)

   ```bash
   curl https://raw.githubusercontent.com/Arcadia-Science/peptigate/main/scripts/characterize_peptides.py
   python characterize_peptides.py peptides_for_ml.fasta peptides_for_ml_characterized.tsv
   ```

8. Combine peptide metadata with other information

   ```r
   peptide_characterization <- read_tsv("~/Downloads/backup_peptipedia_29_03_2023/peptides_for_ml_characterized.tsv")
   
   final_dataset <- final_dataset %>%
     left_join(peptide_characterization, by = c("peptipedia_peptide_id" = "peptide_id")) %>%
     mutate(length = nchar(peptide_sequence)) %>%
     rename(bioactivity = group_bioactivity)
 
   write_tsv(final_dataset, "peptides_ml_dataset.tsv")
   ```

9. Check that the data set is predictive of the label "group_bioactivity".
   ```r
   library(caret)
   
   set.seed(123)
   
   final_dataset <- read_tsv("peptides_ml_dataset.tsv")
   final_dataset_filtered <- final_dataset %>%
     select(-peptipedia_peptide_id, -peptide_sequence, -all_bioactivities, -go_id, -pfam_id,
           -pfam_name, -pfam_type)
   trainingIndex <- createDataPartition(final_dataset_filtered$bioactivity, p = .8, list = FALSE)
   trainingData <- final_dataset_filtered[trainingIndex, ]
   testData <- final_dataset_filtered[-trainingIndex, ]
   
   control <- trainControl(method="cv", number=10) # 10-fold cross-validation
   model <- train(bioactivity ~ ., data=trainingData, method="rf", trControl=control)
   
   predictions <- predict(model, newdata=testData)
   confusionMatrix(predictions, as.factor(testData$bioactivity))
   ```

   The `confusionMatrix()` command prints the following two results to the console.
   The model has the following accuracy:
   ```
   Overall Statistics
                                          
               Accuracy : 0.6188          
                 95% CI : (0.5805, 0.6559)
    No Information Rate : 0.2496          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.5316          
                                          
   Mcnemar's Test P-Value : NA
   ```

   and with per class performance of:
   ```
                                Reference
   Prediction                 amphibian_defense anti_gram antibacterial_antibiotic antimicrobial growth_factor hormone immunological_activity neurological_activity propeptide signal_peptide therapeutic
   amphibian_defense                        0         0                        0             3             0       0                      0                     0          0              0           0
   anti_gram                                0         0                        0             1             0       0                      0                     0          0              0           0
   antibacterial_antibiotic                 0         0                        0             0             0       0                      0                     0          1              3           0
   antimicrobial                           12         9                        9           119             0       9                      9                     4          3             16          11
   growth_factor                            0         0                        0             0             0       0                      0                     0          0              0           0
   hormone                                  0         0                        0             3             2       8                      1                     4          3              5           3
   immunological_activity                   3         0                        0            10             0       3                     47                     3          1              1           2
   neurological_activity                    0         0                        0             0             0       0                      1                     0          0              1           1
   propeptide                               0         0                        1             9             1       1                      1                     1         59             10           2
   signal_peptide                           1         0                        6             9             9      14                      2                     9         18            120           1
   therapeutic                              1         1                        3            11             0       1                      0                     1          2              0          56


   Statistics by Class:

                        Class: amphibian_defense Class: anti_gram Class: antibacterial_antibiotic Class: antimicrobial Class: growth_factor Class: hormone Class: immunological_activity Class: neurological_activity Class: propeptide Class: signal_peptide Class: therapeutic
   Sensitivity                          0.000000         0.000000                        0.000000               0.7212              0.00000        0.22222                       0.77049                     0.000000           0.67816                0.7692            0.73684
   Specificity                          0.995342         0.998464                        0.993769               0.8347              1.00000        0.96640                       0.96167                     0.995305           0.95470                0.8634            0.96581
   Pos Pred Value                       0.000000         0.000000                        0.000000               0.5920                  NaN        0.27586                       0.67143                     0.000000           0.69412                0.6349            0.73684
   Neg Pred Value                       0.974164         0.984848                        0.971081               0.9000              0.98185        0.95570                       0.97631                     0.966565           0.95139                0.9237            0.96581
   Prevalence                           0.025719         0.015129                        0.028744               0.2496              0.01815        0.05446                       0.09228                     0.033283           0.13162                0.2360            0.11498
   Detection Rate                       0.000000         0.000000                        0.000000               0.1800              0.00000        0.01210                       0.07110                     0.000000           0.08926                0.1815            0.08472
   Detection Prevalence                 0.004539         0.001513                        0.006051               0.3041              0.00000        0.04387                       0.10590                     0.004539           0.12859                0.2859            0.11498
   Balanced Accuracy                    0.497671         0.499232                        0.496885               0.7779              0.50000        0.59431                       0.86608                     0.497653           0.81643                0.8163            0.85133
   ```
   
   Note that the accuracy is low-ish by design.
   We wanted a teaching data set we can demonstrate how to improve performance through tuning or by using different models or analysis techniques.

## Documentation of data set contents

### Column descriptions

* `peptipedia_peptide_id`: peptide id of the peptide in the peptipedia database. All peptides were representative sequences in mmseqs2 clustering (80% threshold).
* `peptide_sequence`: peptide sequence.
* `bioactivity`: bioactivity label for the peptide. This was derived by taking all bioactivity labels for all peptides in a cluster and selecting only clusters where all peptides had at least one label that was assigned to all peptides. We kept the first of such labels and use this as the "bioactivity" label for the peptide.
* `all_bioactivities`: all predicted bioactivities for a given peptide.
* `go_id`: gene ontology ID.
* `pfam_id`: PFAM (protein family) ID.
* `pfam_name`: name of PFAM protein family.
* `pfam_type`: type of PFAM protein family.
* `aliphatic_index`: relative volume occupied by aliphatic side chains (Alanine, Valine, Isoleucine, and Leucine).
* `boman_index`: The potential interaction index proposed by Boman (2003) is an index computed by averaging the solubility values for all residues in a sequence. It can be used to give an overall estimate of the potential of a peptide to bind to membranes or other proteins. A value greater than 2.48 indicates that a protein has high binding potential.
* `charge`: the theoretical net charge of a peptide sequence based on the Henderson-Hasselbach equation. Computed at a pH of 7 with the Lehninger pKscale.
* `hydrophobicity`: average of the hydrophobicity values of each residue using one of the 39 scales from different sources.
* `instability_index`: predicts the stability of a protein based on its dipeptide composition. A protein whose instability index is smaller than 40 is predicted as stable, a value above 40 predicts that the protein may be unstable.
* `isoelectric_point`: the pH at which a particular molecule or surface carries no net electrical charge.
* `molecular_weight`: the sum of the mass of each amino acid in the peptide sequence.
* `pd1_residue_volume`: physical descriptor related to the peptide residue volume.
* `pd2_hydrophilicity`: physical descriptor related to the peptide hydrophilicity.
* `z1_lipophilicity`: Zscale quantifying the lipophilicity of the peptide.
* `z2_steric_bulk_or_polarizability`: Zscale modeling steric properties like steric bulk and polarizability.
* `z3_polarity_or_charge`: Zscale quantifying electronic properties like polarity and charge.
* `z4_electronegativity_etc`: Zscale relating to electronegativity, heat of formation, electrophilicity and hardness.
* `z5_electronegativity_etc`: Zscale relating to electronegativity, heat of formation, electrophilicity and hardness.
* `length`: length in amino acids of the peptide.

## Potential future additions or improvements

1. We could make the data set creation script into a Snakemake workflow to better document how it was generated.
2. We could BLAST each peptide sequence to add more metadata (peptide function, gene name, species/taxonomy, number of hits, etc). This might be helpful especially if we need more character columns.
