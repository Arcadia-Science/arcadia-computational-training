## Documentation for how the dataset was made

0. We used the environment defined in `make_peptides_ml_dataset.yml` to make the data set below.
1. Download the peptipedia database:  https://drive.google.com/file/d/1x3yHNl8k5teHlBI2FMgl966o51s0T8i_/view?usp=sharing. The link for this database is provided by the [peptipedia GitHub repo](https://github.com/ProteinEngineering-PESB2/Peptipedia2.0).
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

4. Filter to peptides that are at least k in length. MMSeqs2 clustering in step 4 will fail if any of the sequences are below the k-mer length used for clustering.
   ```bash
   seqkit seq --min-len 10 -o peptipedia_minlen10.fasta peptipedia.fasta
   ```

5. Cluster the sequences.
   Using a low identity threshold (10%), this step determines which peptides in the input database have similar sequences.
   We will subsequently use this information to artificially generate a data set where the peptides or their characteristics are predictive of bioactivity labels.
   ```bash
   mmseqs easy-cluster peptipedia_minlen10.fasta mmseqs/peptipedia_minlen10-0.1 tmp --min-seq-id 0.1
   ```

6. Filter to large clusters composed of peptides that all have the same bioactivity prediction and write a TSV file.
   Many of the peptides that end up in clusters have multiple bioactivity predictions (e.g. antimicrobial and therapeutic).
   The script below filters to peptide clusters that all have at least one bioactivity label that is the same.
   It also adds additional metadata (GO, PFAM) from the SQL database to the data.frame of peptide information.
```r
library(tidyverse)
library(janitor)

# The goal of this script is to create a demo machine learning data set from peptides and their metadata.
# It filters peptides in the peptipedia database to clusters of similar peptides
# (30% identity or greater) that all have the same bioactivity label.
# It then joins selected peptides to their metadata


# filter to peptides clusters with many members that have the same bioactivity --------

# read in cluster information from mmseqs2 linclust
clusters <- read_tsv("~/Downloads/backup_peptipedia_29_03_2023/mmseqs/peptipedia_minlen10-0.3_cluster.tsv",
                     col_names = c("rep", "member"))

# read in peptide bioactivity information
peptide_bioactivity <- read_csv('~/Downloads/backup_peptipedia_29_03_2023/peptipedia.csv') %>%
  clean_names()

# filter to clusters that have many members
cluster_sizes <- clusters %>%
  group_by(rep) %>%
  tally() %>%
  arrange(desc(n))

large_clusters <- cluster_sizes %>%
  filter(n > 10)

clusters_filtered <- clusters %>%
  filter(rep %in% large_clusters$rep)

# filter the bioactivity data set to match
peptide_bioactivity_filtered <- peptide_bioactivity %>%
  filter(idpeptide %in% clusters_filtered$member)

peptide_bioactivity_filtered_with_clusters <- left_join(clusters_filtered, peptide_bioactivity_filtered, by = c("member" = "idpeptide"))

# filter to clusters that all have the same bioactivity for at least one bioactivity label
# (e.g. all peptides have a predicted bioactivity of "antimicrobial" in a given cluster)
peptide_bioactivity_filtered_with_clusters_long <- peptide_bioactivity_filtered_with_clusters %>%
  pivot_longer(cols = starts_with("allergen"):last_col(), names_to = "bioactivity", values_to = "value")

# Find clusters where all members have a 1 for any bioactivity
clusters_all_1_any_bioactivity <- peptide_bioactivity_filtered_with_clusters_long %>%
  group_by(rep, bioactivity) %>%
  summarise(all_ones = all(value == 1), .groups = 'drop') %>%
  filter(all_ones) %>%
  distinct(rep, .keep_all = TRUE)

peptide_group_bioactivities <- peptide_bioactivity_filtered_with_clusters %>%
  filter(rep %in% clusters_all_1_any_bioactivity$rep) %>%
  left_join(clusters_all_1_any_bioactivity, by = "rep") %>%
  select(rep, member, member_sequence = sequence, group_bioactivity = bioactivity)

# Record all bioactivity predictions for each peptide by concatenating the bioactivity names
peptide_bioactivities_concatenated <- peptide_bioactivity_filtered_with_clusters_long %>%
  filter(value == 1) %>%
  group_by(member) %>%
  summarise(all_bioactivities = str_c(bioactivity, collapse = ";"), .groups = 'drop')

# Join this back to your original (or relevant) dataset to add the concatenated bioactivities column
final_dataset <- peptide_group_bioactivities %>%
  left_join(peptide_bioactivities_concatenated, by = "member") %>%
  distinct()

# join with other peptide metadata ----------------------------------------

gene_ontology <- read_csv("~/Downloads/backup_peptipedia_29_03_2023/table_public.gene_ontology.csv",
                          col_names = c("peptideid", "go_id", "go_description", "go_category")) %>%
  select(peptideid, go_id)

pfam <- read_csv("~/Downloads/backup_peptipedia_29_03_2023/table_public.pfam.csv",
                 col_names = c("peptideid", "pfam_id", "pfam_name", "pfam_type"))

final_dataset <- final_dataset %>%
  left_join(gene_ontology, by = c("member" = "peptideid")) %>%
  left_join(pfam, by = c("member" = "peptideid")) %>%
  distinct()

final_dataset %>% group_by(group_bioactivity) %>% tally()

write_tsv(final_dataset, "~/Downloads/backup_peptipedia_29_03_2023/peptides_for_ml_tmp.tsv")
```


6. Convert the output TSV to a FASTA file that can be used to calculate peptide characteristics (molecular weight, etc).
```bash
cut -f2,3 peptides_for_ml_tmp.tsv | tail -n +2 | seqkit tab2fx > peptides_for_ml.fasta
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
  left_join(peptide_characterization, by = c("member" = "peptide_id")) %>%
  mutate(length = nchar(member_sequence)) %>%
  select(-rep) %>% # remove the mmseqs2 rep column since it shouldn't be used for prediction and is an artifact of dataset creation.
  rename(peptipedia_peptide_id = member, peptide_sequence = member_sequence)

write_tsv(final_dataset, "peptides_ml_dataset.tsv")
```

9. Check that the data set is predictive of the label "group_bioactivity".
```r
library(caret)

set.seed(123)

final_dataset <- read_tsv("petides_ml_dataset.tsv")
final_dataset_filtered <- final_dataset %>%
  select(-peptipedia_peptide_id, -peptide_sequence, -all_bioactivities, -go_id, -pfam_id,
         -pfam_name, -pfam_type)
trainingIndex <- createDataPartition(final_dataset_filtered$group_bioactivity, p = .8, list = FALSE)
trainingData <- final_dataset_filtered[trainingIndex, ]
testData <- final_dataset_filtered[-trainingIndex, ]

control <- trainControl(method="cv", number=10) # 10-fold cross-validation
model <- train(group_bioactivity ~ ., data=trainingData, method="rf", trControl=control)

predictions <- predict(model, newdata=testData)
confusionMatrix(predictions, as.factor(testData$group_bioactivity))
```

The `confusionMatrix()` command prints the following two results to the console.

The model has the following accuracy:
```
Overall Statistics

               Accuracy : 0.9362
                 95% CI : (0.9247, 0.9465)
    No Information Rate : 0.3406
    P-Value [Acc > NIR] : < 2.2e-16

                  Kappa : 0.9197

 Mcnemar's Test P-Value : NA
```

and with per class performance of:
```
                               Reference
Prediction                       allergen amphibian_defense angiogenic anti_gram anti_hiv antibacterial_antibiotic anticancer antifungal antimicrobial bioactive cell_cell_communication cell_penetrating cell_sensing coagulation_or_anticoagulation defense growth_factor hormone immunological_activity metabolic nematode neurological_activity other_activity propeptide signal_peptide therapeutic toxins
  allergen                              8                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  amphibian_defense                     0                 2          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  angiogenic                            0                 0          2         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  anti_gram                             0                 0          0         4        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  anti_hiv                              0                 0          0         0        4                        0          0          0             1         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  antibacterial_antibiotic              0                 0          0         0        0                       13          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              1           0      0
  anticancer                            0                 0          0         0        0                        0          3          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  antifungal                            0                 0          0         0        0                        0          0          1             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  antimicrobial                         0                 3          0         2        0                        2          0          1           439         0                       0                0            0                              1       0             0       0                      2         2        0                     5              0          1              2           5      1
  bioactive                             0                 0          0         0        0                        0          0          0             0         9                       0                0            0                              0       0             0       1                      0         0        0                     0              0          0              0           0      0
  cell_cell_communication               0                 0          0         0        0                        0          0          0             0         0                       4                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  cell_penetrating                      0                 0          0         0        0                        0          0          0             0         0                       0                5            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  cell_sensing                          0                 0          0         0        0                        0          0          0             0         0                       0                0            4                              0       0             0       0                      0         0        0                     0              0          0              0           0      0
  coagulation_or_anticoagulation        0                 0          0         0        0                        0          0          0             0         0                       0                0            0                             42       0             0       1                      0         0        0                     0              0          0              0           0      0
  defense                               0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       5             0       0                      0         0        0                     0              0          0              0           0      0
  growth_factor                         0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0            31       0                      0         0        0                     0              0          0              2           0      0
  hormone                               0                 0          0         0        0                        0          0          0             2         0                       0                0            0                              0       0             0      80                      0         0        0                     1              0          1              1           1      0
  immunological_activity                0                 0          0         0        1                        0          0          0             1         0                       0                0            0                              0       0             0       0                    155         0        0                     1              0          0              0           0      0
  metabolic                             0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0        16        0                     0              0          0              0           0      0
  nematode                              0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        1                     0              0          0              0           0      0
  neurological_activity                 0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       1                      0         0        0                    31              0          0              0           0      0
  other_activity                        0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              2          0              0           0      0
  propeptide                            0                 0          0         0        0                        0          0          0             0         1                       0                0            0                              0       0             1       1                      0         0        0                     0              0         97              3           2      0
  signal_peptide                        3                 0          0         0        0                        2          0          0             2         0                       0                0            0                              1       0            12       0                      6         0        1                     1              0         26            678          10      0
  therapeutic                           0                 0          0         0        0                        1          0          0             5         1                       0                0            0                              0       0             0       0                      0         0        0                     5              0          0              2         252      0
  toxins                                0                 0          0         0        0                        0          0          0             0         0                       0                0            0                              0       0             0       0                      0         0        0                     0              0          0              0           0      6


Statistics by Class:

                     Class: allergen Class: amphibian_defense Class: angiogenic Class: anti_gram Class: anti_hiv Class: antibacterial_antibiotic Class: anticancer Class: antifungal Class: antimicrobial Class: bioactive Class: cell_cell_communication Class: cell_penetrating Class: cell_sensing Class: coagulation_or_anticoagulation Class: defense Class: growth_factor Class: hormone Class: immunological_activity Class: metabolic Class: nematode Class: neurological_activity Class: other_activity
Sensitivity                 0.727273                0.4000000         1.0000000         0.666667        0.800000                        0.722222          1.000000         0.5000000               0.9756         0.818182                       1.000000                1.000000            1.000000                               0.95455       1.000000              0.70455        0.95238                       0.95092         0.888889       0.5000000                      0.70455             1.0000000
Specificity                 1.000000                1.0000000         1.0000000         1.000000        0.999504                        0.999501          1.000000         1.0000000               0.9828         0.999503                       1.000000                1.000000            1.000000                               0.99949       1.000000              0.99899        0.99691                       0.99839         1.000000       1.0000000                      0.99949             1.0000000
Pos Pred Value              1.000000                1.0000000         1.0000000         1.000000        0.800000                        0.928571          1.000000         1.0000000               0.9421         0.900000                       1.000000                1.000000            1.000000                               0.97674       1.000000              0.93939        0.93023                       0.98101         1.000000       1.0000000                      0.96875             1.0000000
Neg Pred Value              0.998511                0.9985156         1.0000000         0.999009        0.999504                        0.997511          1.000000         0.9995054               0.9929         0.999006                       1.000000                1.000000            1.000000                               0.99899       1.000000              0.99347        0.99793                       0.99571         0.999003       0.9995054                      0.99347             1.0000000
Prevalence                  0.005437                0.0024716         0.0009886         0.002966        0.002472                        0.008898          0.001483         0.0009886               0.2224         0.005437                       0.001977                0.002472            0.001977                               0.02175       0.002472              0.02175        0.04152                       0.08057         0.008898       0.0009886                      0.02175             0.0009886
Detection Rate              0.003955                0.0009886         0.0009886         0.001977        0.001977                        0.006426          0.001483         0.0004943               0.2170         0.004449                       0.001977                0.002472            0.001977                               0.02076       0.002472              0.01532        0.03955                       0.07662         0.007909       0.0004943                      0.01532             0.0009886
Detection Prevalence        0.003955                0.0009886         0.0009886         0.001977        0.002472                        0.006920          0.001483         0.0004943               0.2304         0.004943                       0.001977                0.002472            0.001977                               0.02126       0.002472              0.01631        0.04251                       0.07810         0.007909       0.0004943                      0.01582             0.0009886
Balanced Accuracy           0.863636                0.7000000         1.0000000         0.833333        0.899752                        0.860862          1.000000         0.7500000               0.9792         0.908842                       1.000000                1.000000            1.000000                               0.97702       1.000000              0.85177        0.97464                       0.97465         0.944444       0.7500000                      0.85202             1.0000000
                     Class: propeptide Class: signal_peptide Class: therapeutic Class: toxins
Sensitivity                    0.77600                0.9840             0.9333      0.857143
Specificity                    0.99579                0.9520             0.9920      1.000000
Pos Pred Value                 0.92381                0.9137             0.9474      1.000000
Neg Pred Value                 0.98540                0.9914             0.9898      0.999504
Prevalence                     0.06179                0.3406             0.1335      0.003460
Detection Rate                 0.04795                0.3351             0.1246      0.002966
Detection Prevalence           0.05190                0.3668             0.1315      0.002966
Balanced Accuracy              0.88589                0.9680             0.9627      0.928571
```

## Documentation of data set contents

### Column descriptions

* `peptipedia_peptide_id`: cluster member peptide id.
* `peptide_sequence`: cluster member peptide sequence.
* `group_bioactivity`: bioactivity label that is the same between all peptides in a given cluster.
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

### Notes about the data set

* We artificially generated similarity in peptides with specific bioactivity labels by clustering at 30% identity. The opposite of this should be done in real ML applications -- sequences that are similar in content should be removed so the same signal isn't repeated over and over again and so that there isn't pollution between the training and testing data sets.

## Potential future additions or improvements

1. We could make the data set creation script into a Snakemake workflow to better document how it was generated.
2. We could BLAST each peptide sequence to add more metadata (peptide function, gene name, species/taxonomy, number of hits, etc). This might be helpful especially if we need more character columns.
