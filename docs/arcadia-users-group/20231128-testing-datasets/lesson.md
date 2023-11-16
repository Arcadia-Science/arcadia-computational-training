# Building test data sets

In our previous lesson, we covered different types of tests.
In the unit test section, we used five functions to test that our `mean()` function produced the output that we expected it to.
For each of these functions, we started by defining our test data, `num_list`, a list of numbers for which we wanted to calculate the mean.

These test data were small; each list only had five numbers in it.
The "correct" answer to the test was clear with relatively little human effort (we could take a few seconds to calculate the mean of each list in our own heads).
The creation of each test data set was encoded in the test itself.

Below we discuss strategies for creating test data sets to help maintain some of these desirable qualities in real code bases.

## Test data for functions and scripts

### Creating data within the test itself

As seen in our previous lesson and described above, one strategy is to create test data within the test using built-in functions or data structures.
When possible, this is a great strategy.
These test data are small and self-contained and the correct answer to the test is easy to figure out.
Functions like `[]` (list creation), or `range()` in Python and `c()`, `rep()`, `seq()`, `data.frame()`, and `list()` in R can be used to create test data that are relevant to a function.
Some data-creation functions might be non-deterministic, but setting the seed ensures that the same output are produced each time.

### Testing image outputs

Often times, a function or a script produces an image output.
Images are trickier to test than some other outputs, but can still be used in unit tests.
If a function produces the image and an image object is produced in your coding environment, you can sometimes check the metadata of the image to make sure it matches expected values.
This includes dimensions, color profiles, or file formats.
These types of tests have the built-in benefit of testing whether the function produces an image successfully on top of confirming attributes about the image.

Even if you check metadata attributes about an image, the image itself might still be different than expected.
If you want to test the output image more thoroughly, you can compare the output produced by a test to a reference image stored in your test data.
Both checksum comparisons and pixel comparisons are useful in this scenario.

### Match md5sum of output files

Checksums can also be used to compare the results of a function against other types of files.
For example, if you have a function that produces a data frame, you can write that object to a CSV file.
Then, you could compare the output CSV file against a reference CSV file by their checksums.
When using this strategy, it might be necessary to sort your data frame prior to writing a file.

## Test data sets for workflow integration tests

Identifying a small data set that will quickly run through the entire workflow can be tricky.
Below we cover some strategies to help achieve this.

### Subsetting input data

Sometimes, you can subset your data by running `head` or `tail` on your input files, or sub sampling input samples to a lower number, and your workflow will still run.
This is a great option when it works!
Often times, however, this strategy will fail as sub sampling in this manner will cause some tools in your workflow to produce no results, rendering the rest of the workflow unable to run or producing blank, meaningless outputs.
Because it's relatively fast to subset data this way, you can always try this strategy first and see if produces a representative test data set before moving on to other strategies.

### Subset input data by results

One strategy to circumvent this issue is to run the workflow from start to finish on a full data set and then to cleverly subset the results.
For example, if you are writing a workflow that performs genome assembly, you could assemble all reads, map the reads back to your assembly, and extract all of the reads that map to one contiguous sequence.
This would effectively subset the number of reads you're working with but ensure that those reads will still assemble.

### Making databases small

This is true for databases as well.
Many workflows will rely on a database for at least one step -- identifying BLAST hits, performing functional annotation, etc.
The size of the database will often be the driving factor in search times.
When possible, you can generate a small test database as a drop in replacement.
Sometimes, the developers of a tools will have already generated a small test database that you can use (see [this issue](https://github.com/eggnogdb/eggnog-mapper/issues/140) for an example for the [EggNOG ortholog annotation tool](http://eggnog-mapper.embl.de/).
Other times, you can take the same strategy as suggested above: run a full data set through your pipeline, identify a database hit that is in your data, and then subset the database and your input data to retain information relevant only to that hit.

### Parameterization to keep tests lightweight 

You may need to introduce new user-controlled parameters into your workflow to reduce run times or API calls.
For example, if your workflow queries a database or an API and by default returns the top 500 hits, you may need to parameterize this value to reduce the number of returned hits to something much smaller (like 3).
(An alternative in this case would be to select a test data set that only returns a small number of hits because it doesn't have many matches in the database.)
Parameterization can also reduce run time or RAM required to run your pipeline.
For example, the default k-mer length in MMSeq2 clustering uses more RAM than is available for GitHub Actions workflows; [parameterizing this value](https://github.com/Arcadia-Science/reads2transcriptome/blob/a2105ba9616fbdf1e736440ef12c47442a873d18/conf/test.config#L30) reduces the RAM required to run an integration test on workflows that use MMSeqs2.

## Guiding principles for test data set creation

1. **Small data**: Data should be small and run fast. Even for large multi-step workflows or big software libraries, tests shouldn't take more than a few minutes to run. The data itself should be storable in a GitHub repository and should be as small as possible to reliably capture the behavior of the tool or workflow.
2. **Address known bugs**: Create new test each time someone submits an issue identifying a bug in your code. If possible, build and test and use test data from a minimum reproducible example that recreates the behavior of the error.
3. **Representative data**: The test data should be representative of the actual data the software will handle. It should cover a variety of data types, structures, and edge cases to ensure the software behaves as expected in different scenarios.
4. **Deterministic results**: Choose test data that will produce deterministic results, making the tests predictable and repeatable. This is crucial for verifying the accuracy and consistency of the software over time.
5. **Modular and reusable**: When possible, design test data in a modular fashion, making it reusable across different tests. This promotes efficiency and consistency in testing.
6. **Documented**: Document the source and structure of the test data, along with any assumptions or simplifications made. This helps other developers understand the purpose and limitations of the test data.
