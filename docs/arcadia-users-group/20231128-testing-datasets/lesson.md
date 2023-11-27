# Building test data sets

In our previous lesson, we covered different types of tests.
In the unit test section, we used five functions to test that our `mean()` function produced the output that we expected it to.
For each of these functions, we started by defining our test data, `num_list`, a list of numbers for which we wanted to calculate the mean.

These test data were small; each list only had five numbers in it.
The "correct" answer to the test was clear with relatively little human effort (we could take a few seconds to calculate the mean of each list in our own heads).
The creation of each test data set was encoded in the test itself.

Below we discuss strategies for creating test data sets to help maintain some of these desirable qualities in real code bases.

As a running example, similar to the `mean()` function we used in the previous lesson, we'll use `distribution()`, a simple function that returns the distribution of characters in text. This function is intentionally implemented inefficiently, to emulate an expensive function of the type typically found in computational biology workflows, that would require testing.

```python
def distribution(text):
    return { char: text.count(char)/len(text) for char in text.lower() }
```

Let's try it:
```
distribution('testing datasets')
```
```
{'t': 0.25,
 'e': 0.125,
 's': 0.1875,
 'i': 0.0625,
 'n': 0.0625,
 'g': 0.0625,
 ' ': 0.0625,
 'd': 0.0625,
 'a': 0.125}
```

## Test data for functions and scripts

### Creating data within the test itself

As seen in our previous lesson and described above, one strategy is to create test data within the test using built-in functions or data structures.
When possible, this is a great strategy.
These test data are small and self-contained and the correct answer to the test is easy to figure out.
Functions like `[]` (list creation), or `range()` in Python and `c()`, `rep()`, `seq()`, `data.frame()`, and `list()` in R can be used to create test data that are relevant to a function.
Some data-creation functions might be non-deterministic, but setting the seed ensures that the same output are produced each time.

Often, we'll test a combination of "typical" inputs for which we verified the expected outputs, alongside edge cases - empty, very large, or nonsensical inputs. For `distribution()`, a typical in-test set of test cases could include:

```python
DISTRIBUTION_INPUTS_AND_EXPECTED_OUTPUTS = [
    ('', {}),                                    # An empty string should produce an empty output
    ('abcc', {'a': 0.25, 'b': 0.25, 'c': 0.5}),  # Typical short input
    (100, None),                                 # Nonsensical input (wrong type)
    ...
]
```


### Testing image outputs

Often times, a function or a script produces an image output.
Images are trickier to test than some other outputs, but can still be used in unit tests.
If a function produces the image and an image object is produced in your coding environment, you can sometimes check the metadata of the image to make sure it matches expected values.
This includes dimensions, color profiles, or file formats.
These types of tests have the built-in benefit of testing whether the function produces an image successfully on top of confirming attributes about the image.

Even if you check metadata attributes about an image, the image itself might still be different than expected.
If you want to test the output image more thoroughly, you can compare the output produced by a test to a reference image stored in your test data.
Both checksum comparisons and pixel comparisons are useful in this scenario.

We'll modify our function to generate an image -- a histogram of letter counts:

```python
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

def histogram(file_in, file_out):
    with open(file_in) as fi, open(file_out, 'w') as fo:
        counts = distribution(fi.read())
        df = pd.DataFrame(
            list(counts.items()), columns=['Character', 'Count']
        ).sort_values(by='Character')
        sns.barplot(data=df, x='Character', y='Count')
        plt.savefig(file_out)
```

Let's try it:
```
histogram('/usr/share/dict/propernames', '/tmp/propernames.png')
```

<img src="fig/propernames.png" alt="Character frequency in /usr/share/dict/propernames" width="50%"/>

To compare generated images to ground truth, we can use checksums as before, or we can visually compare them. For this, we'll use a Python image processing library which would require installation with `mamba install pillow`.

```python
from PIL import Image, ImageChops

def image_diff(file1, file2, file_out):
    """Compare file1 and file2; if different, store diff to file_out and assert."""
    img1 = Image.open(file1)
    img2 = Image.open(file2)
    diff = ImageChops.difference(img1, img2)
    if diff.getbbox():
        # Diff is the same as an empty image, i.e. `img1` and `img2` are identical.
        return True
    else:
        # Images differ, store a comparison of them.
        ImageChops.blend(img1, diff, alpha=0.5).save(file_out)
        assert False, f"Images differ, comparison in {file_out}"
```

For example, the histograms of the two samples discussed earlier -- the head of `/usr/share/dict/web2a` and a random sample from it - look relatively similar:

<img src="fig/web2a.head.png" alt="Character frequency in the head of /usr/share/dict/web2a" style="width: 50%; float: left;" />
<img src="fig/web2a.rand.png" alt="Character frequency in a random subset of /usr/share/dict/web2a" style="width: 50%; float: right;" />

But applying `image_diff()` highlights areas that have changed:

<div align="center">
    <img src="fig/web2a.diff.png" alt="Visual diff of top and random sampling from inputs" style="width: 50%" />
</div>

## Comparing file outputs

We can directly compare an output file to a "reference" or "golden" output that is accessible to the test.
Checksums can also be used to compare the results of a function against other types of files.
For example, if you have a function that produces a data frame, you can write that object to a CSV file.
Then, you could compare the output CSV file against a reference CSV file by their checksums.
When using this strategy, it might be necessary to sort your data frame prior to writing a file.

An example of comparing checksums within a test (maybe this should be a challenge?)

```python
import hashlib

with open('expected.txt', 'rb') as expected, '/tmp/propernames.txt', 'rb') as actual:
    assert hashlib.md5(expected.read()).hexdigest() == hashlib.md5(actual.read()).hexdigest()
```

### Testing image outputs
...

Checksums can also be used to compare the results of a function against other types of files.
For example, if you have a function that produces a data frame, you can write that object to a CSV file.
Then, you could compare the output CSV file against a reference CSV file by their checksums.
When using this strategy, it might be necessary to sort your data frame prior to writing a file.

## Test data sets for workflow integration tests

Identifying a small data set that will quickly run through the entire workflow can be tricky.
Below we cover some strategies to help achieve this.

### Subsetting input data

Sometimes, typical inputs (say, genomics data or images) are large and result in slow test times. For example, let's try `distribution_in_file` on a larger input (feel free to terminate the cell, if it takes too long):

```python
distribution_in_file('/usr/share/dict/web2a', '/tmp/web2a.txt')
```

Depending on the type of machine, this could take several minutes -- certainly more than we'd like a test to run. In this case, subsetting the data could shorten the test time significantly, while still checking core functionality.

Sometimes, you can subset your data by running `head` or `tail` on your input files, or sub sampling input samples to a lower number, and your workflow will still run.
This is a great option when it works!

For example, let's try taking just the first 1,000 lines of `/usr/share/dict/web2a` as a test file:

```
!head -1000 /usr/share/dict/web2a > /tmp/web2a.head
distribution_in_file('/tmp/web2a.head', '/tmp/web2a.head.txt')
```

Runtime is much faster. Unfortunately, results are significantly different - because the input file is sorted, we're testing words that are more likely to start with letters like 'a', skewing the character distribution. Examining `/tmp/web2a.txt` vs `/tmp/web2a.head.txt`, we see that the letter 'a' appears at a frequency of 6.7% in the former, but 12.1% in the latter.
Often times, simple subsetting strategies like this will fail in even more problematic ways -- subsampling in this manner can cause some tools in your workflow to produce no results, rendering the rest of the workflow unable to run or producing blank, meaningless outputs.

In this case can try sampling random lines from the file, instead of the first lines:

```
!sort -R /usr/share/dict/web2a | head -1000 > /tmp/web2a.rand
distribution_in_file('/tmp/web2a.rand', '/tmp/web2a.rand.txt')
```

The frequency of 'a' is again 6.7%, and the distribution as a whole more similar to the distribution over the full dataset.

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
