
### Nextflow

Nextflow pipelines, and especially nf-core-style Nextflow workflows, have built-in tools and conventions for running integration tests with the workflow.
These tests are used during development to make sure that the workflow runs correctly on end-to-end on a small dataset.
They test software installation, the execution of each process, and the execution of the workflow as a stitched-together set of processes.
Unlike some other workflow languages, Nextflow doesn't have "dry runs," and instead mostly relies on small test data sets to make sure the workflow is syntactically correct and producing desired outputs (this is a 90% true statement, as there are [stub runs](https://www.nextflow.io/docs/latest/process.html#stub)).

Nextflow tests rely on test profiles.
By convention, a test profile is stored in `conf/test.config` and looks something like:

```
```

```
nextflow run Arcadia-Science/reads2transcriptome -profile test,docker --outdir <OUTDIR>
```


#### Arcadia-Science/test-datasets repository

#### Test configs

### Snakemake

#### Dry Runs
