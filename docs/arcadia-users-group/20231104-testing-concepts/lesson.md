# Testing concepts and terminology

> Note that this lesson has been modified from [The Carpentries Incubator](https://github.com/carpentries-incubator) lesson on [Python Testing](https://carpentries-incubator.github.io/python-testing/).
> Parts are reproduced in full, but the major changes were included to shorten the lesson to 60 minutes.

Software testing is a critical practice in the development process aimed at ensuring that a program functions as intended and does not break when changes are made.
It encompasses a range of activities designed to evaluate the correctness, performance, and usability among other aspects of a software application.

At its core, software testing seeks to verify that your software does what it is supposed to do, handles various cases gracefully, and remains stable even as changes are introduced over time.
It is the safety net that catches bugs or errors before they reach the end-users, and it's what gives developers the confidence to continue improving their code.

Everyone engages in software testing to some extent, often informally.
This could be as simple as running the software to see what happens, or doing some exploratory testing as new code is written or old code is modified.
Such testing might involve printing or plotting the outputs of your code as you work.

However, informal testing has its limitations.
It's manual, sporadic, and can become unmanageable, especially as the codebase grows and evolves.
This is where systematic testing comes into play.

Systematic testing takes the informal testing behaviors and codifies them, allowing for automation.
This automation enables tests to be run quickly and repeatedly across the entire codebase, ensuring that every part of the software is validated every time a change is made.
Without automation, it's nearly impossible to ensure that a change in one part of the software hasn't introduced a new bug elsewhere.

This lesson introduces the concepts of automated testing and provides guidance on how to utilize Python constructs to start writing tests.
Although we focus on Python, many of the higher-level concepts discussed are applicable to writing tests in other programming languages as well.

<details>
 <summary>Implementing tests in other languages</summary>
 While this lesson uses Python, almost all programming languages have robust (and often loved) packages dedicated to testing. 
 In R, testing is orchestrated with the <a href="https://testthat.r-lib.org/">testthat package</a>.
 The <a href="https://r-pkgs.org">R packages</a> guide has a chapter dedicated to <a href=https://r-pkgs.org/testing-basics.html>testing</a>. 
 Other programming languages, such as Rust, have built-in testing features.
</details>

## Lesson setup

This lesson will take advantage of the skills we've learned in many previous lessons.
We'll use [Jupyter Notebooks](https://training.arcadiascience.com/arcadia-users-group/20221024-jupyter-notebooks/lesson/), [GitHub](https://training.arcadiascience.com/workshops/20220920-intro-to-git-and-github/lesson/), [conda](https://training.arcadiascience.com/arcadia-users-group/20221017-conda/lesson/), and [Python](https://training.arcadiascience.com/arcadia-users-group/20230228-intro-to-python-1/lesson/).
This is more overhead than we typically strive for in a lesson, but we hope that it's a chance to practice these skills to achieve a new goal.
In the future, we may provide a [GitPod](https://www.gitpod.io/) environment for learners to use while working through this lesson, however if possible we would prefer to empower users to start implementing tests on their own computers using their own setup.
 
To start this lesson, we'll begin by creating a conda environment that has the tools we'll need.

```
mamba env create -n augtest jupyter pytest 
conda activate augtest
```

We'll also create a folder to help us stay organized.
```
mkdir 20231114-aug-testing-lesson
cd 20231114-aug-testing-lesson
```

Once our environment is activated, start a Jupyter notebook

```
jupyter notebook
```

Now we can start learning about testing!

## An introduction to testing concepts

There are many ways to test software, such as assertions, exceptions, unit tests, integration tests, and regression tests.

* **Exceptions and assertions**: While writing code, `exceptions` and `assertions` can be added to sound an alarm as runtime problems come up. 
These kinds of tests, are embedded in the software itself and handle, as their name implies, exceptional cases rather than the norm. 
* **Unit tests**: Unit tests investigate the behavior of units of code (such as functions, classes, or data structures).
By validating each software unit across the valid range of its input and output parameters, tracking down unexpected behavior that may appear when the units are combined is made vastly simpler.
Some examples of things a unit test might test include functions, individual Snakemake rules, a process in Nextflow, or a cell in a Jupyter notebook.
* **Integration tests**: Integration tests check that various pieces of the software work together as expected.
Some examples of things an integration test might test include a set of Snakemake rule or Nextflow processes or the execution of an entire Jupyter notebook.
* **Regression tests**: Regression tests defend against new bugs, or regressions, which might appear due to new software and updates. Regression tests can also refer to test for decreases in performance (run time, memory usage, etc.) or in the qualit of some output (the resolution of a rendered graph, accuracy of a set of predictions, etc.).

While each of these types of tests has a different definition, in practice there isn't always a firm delineation between each type.

## Assertions

Assertions are the simplest type of test.
They are used as a tool for bounding acceptable behavior during runtime.
The assert keyword in python has the following behavior:

```
assert True == False
```
```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  AssertionError
```

```
assert True == True
```

```
```

Assertions halt code execution instantly if the comparison is false and do nothing if the comparison is true.
These are therefore a good tool for guarding the function against inappropriate input:

```
def mean(num_list):
    assert len(num_list) != 0
    return sum(num_list)/len(num_list)
```

The advantage of assertions is their ease of use.
They are rarely more than one line of code.
The disadvantage is that assertions halt execution indiscriminately and the helpfulness of the resulting error message is usually quite limited.

## Exceptions

Exceptions are more sophisticated than assertions.
When an error is encountered, an informative exception is 'thrown' or 'raised'.

For example, instead of the assertion in the case before, an exception can be used.

```
def mean(num_list):
    if len(num_list) == 0:
      raise Exception("The algebraic mean of an empty list is undefined. "
                      "Please provide a list of numbers")
    else:
      return sum(num_list)/len(num_list)
```

Once an exception is raised, it will be passed upward in the program scope.
An exception can be used to trigger additional error messages or an alternative behavior. 
Rather than immediately halting code execution, the exception can be 'caught' upstream with a try-except block.
When wrapped in a try-except block, the exception can be intercepted before it reaches global scope and halts execution.

To add information or replace the message before it is passed upstream, the try-catch block can be used to catch-and-reraise the exception:

```
def mean(num_list):
    try:
        return sum(num_list)/len(num_list)
    except ZeroDivisionError as original_error :
        msg = "The algebraic mean of an empty list is undefined. Please provide a list of numbers."
        raise ZeroDivisionError(original_error.__str__() + "\n" +  msg)
```

Alternatively, the exception can be handled appropriately for the use case.
If an alternative behavior is preferred, the exception can be disregarded and a responsive behavior can be implemented like so:

```
def mean(num_list):
    try:
        return sum(num_list)/len(num_list)
    except ZeroDivisionError :
        return 0
```

If a single function might raise more than one type of exception, each can be caught and handled separately.

```
def mean(num_list):
    try:
        return sum(num_list)/len(num_list)
    except ZeroDivisionError :
        return 0
    except TypeError as original_error :
        msg = "The algebraic mean of an non-numerical list is undefined.\
               Please provide a list of numbers."
        raise TypeError(original_error.__str__() + "\n" +  msg)
```

Exceptions have the advantage of being simple to include and when accompanied by useful help message, can be helpful to the user.
However, not all behaviors can or should be found with runtime exceptions.
Most behaviors should be validated with unit tests.

## Unit tests

Unit tests are so called because they test the functionality of the code by interrogating individual functions and methods.
Functions and methods can often be considered the atomic units of software but what is considered to be the smallest code _unit_ is subjective.
Implementing unit tests often has the effect of encouraging both the code and the tests to be as small, well-defined, and modular as possible.
In Python, unit tests typically take the form of test functions that call and make assertions about methods and functions in the code base.
For now, we'll write some tests for the mean function and simply run them individually to see whether they fail.
Later in this lesson, we'll use a test framework to collect and run them.
Using a test framework makes running tests streamlined.

Unit tests are typically made of three pieces, some set-up, a number of assertions, and some tear-down. 
Set-up can be as simple as initializing the input values or as complex as creating and initializing concrete instances of a class.
Ultimately, the test occurs when an assertion is made, comparing the observed and expected values.
For example, let us test that our mean function successfully calculates the known value for a simple list.

Before running the next code, save your `mean` function to a file called `mean.py` in the working directory.

You can use this code to save to file:

```
def mean(num_list):
    try:
        return sum(num_list)/len(num_list)
    except ZeroDivisionError :
        return 0
    except TypeError as original_error :
        msg = "The algebraic mean of an non-numerical list is undefined.\
               Please provide a list of numbers."
        raise TypeError(original_error.__str__() + "\n" +  msg)
```

Now, back in your Jupyter Notebook run the following code:

```
from mean import *

def test_mean_with_ints():
    num_list = [1, 2, 3, 4, 5]
    observed_value = mean(num_list)
    expected_value = 3
    assert observed_value == expected_value
```

The test above:

* sets up the input parameters (the list `[1, 2, 3, 4, 5]`);
* collects the observed result;
* declares the expected result (calculated with our human brain);
* and compares the two with an assertion.

A unit test suite is made up of many tests just like this one.
A single implemented function may be tested in numerous ways.

In a file called `test_mean.py`, implement the following code:

```
from mean import *

def test_mean_with_ints():
    num_list = [1, 2, 3, 4, 5]
    observed_value = mean(num_list)
    expected_value = 3
    assert observed_value == expected_value

def test_mean_with_zero():
    num_list=[0, 2, 4, 6]
    observed_value = mean(num_list)
    expected_value = 3
    assert observed_value == expected_value

def test_mean_with_double():
    # This one will fail in Python 2
    num_list=[1, 2, 3, 4]
    observed_value = mean(num_list)
    expected_value = 2.5
    assert observed_value == expected_value

def test_mean_with_long():
    big = 100000000
    observed_value = mean(range(1,big))
    expected_value = big/2.0
    assert observed_value == expected_value

def test_mean_with_complex():
    # given that complex numbers are an unordered field
    # the arithmetic mean of complex numbers is meaningless
    num_list = [2 + 3j, 3 + 4j, -32 - 2j]
    observed_value = mean(num_list)
    expected_value = NotImplemented
    assert observed_value == expected_value
```

Use Jupyter Notebook to import the `test_mean` package and run each test like this:

```
from test_mean import *

test_mean_with_ints()
test_mean_with_zero()
test_mean_with_double()
test_mean_with_long()
test_mean_with_complex()  ## Please note that this one might fail. You'll get an error message showing which tests failed
```

We just wrote and ran five tests for our `mean()` function~

You may have noticed that several of the tests look very similar to each other -- they introduce an input, call `mean()`, and test its output against an expected value. We'll come back to this later, offering a way to write a single test that applies to multiple inputs.
## Using the test framework `pytest`

We created a suite of tests for our mean function, but it was annoying to run them one at a time.
It would be a lot better if there were some way to run them all at once, just reporting which tests fail and which succeed.

Thankfully, that exists.
Recall our tests:

```
from mean import *

def test_mean_with_ints():
    num_list = [1, 2, 3, 4, 5]
    observed_value = mean(num_list)
    expected_value = 3
    assert observed_value == expected_value

def test_mean_with_zero():
    num_list=[0, 2, 4, 6]
    observed_value = mean(num_list)
    expected_value = 3
    assert observed_value == expected_value

def test_mean_with_double():
    # This one will fail in Python 2
    num_list=[1, 2, 3, 4]
    observed_value = mean(num_list)
    expected_value = 2.5
    assert observed_value == expected_value

def test_mean_with_long():
    big = 100000000
    observed_value = mean(range(1,big))
    expected_value = big/2.0
    assert observed_value == expected_value

def test_mean_with_complex():
    # given that complex numbers are an unordered field
    # the arithmetic mean of complex numbers is meaningless
    num_list = [2 + 3j, 3 + 4j, -32 - 2j]
    observed_value = mean(num_list)
    expected_value = NotImplemented
    assert observed_value == expected_value
```

Once these tests are written in a file called `test_mean.py`, the command `pytest` can be run on the terminal or command line from the directory containing the tests (note that you'll have to use `py.test` for older versions of the `pytest` package):

```
pytest
```

```
collected 5 items

test_mean.py ....F

================================== FAILURES ===================================
________________________________ test_complex _________________________________

    def test_mean_with_complex():
        # given that complex numbers are an unordered field
        # the arithmetic mean of complex numbers is meaningless
        num_list = [2 + 3j, 3 + 4j, -32 - 2j]
        observed_value = mean(num_list)
        expected_value = NotImplemented
>       assert observed_value == expected_value
E       assert (-9+1.6666666666666667j) == NotImplemented

test_mean.py:34: AssertionError
===================== 1 failed, 4 passed in 2.71 seconds ======================
```

In the above case, the pytest package sniffed out the tests in the directory and ran them together to produce a report of the sum of the files and functions matching the regular expression `[Tt]est[-_]*`.

The major benefit a testing framework provides is exactly that, a utility to find and run the tests automatically.
With pytest, this is the command-line tool called `pytest`.
When `pytest` is run, it will search all directories below where it was called, find all of the Python files in these directories whose names start or end with `test`, import them, and run all of the functions and classes whose names start with `test` or `Test`.
This automatic registration of test code saves tons of time and provides a consistent organization framework across Python projects.

When you run `pytest`, it will print a dot (`.`) on the screen for every test that passes, an `F` for every test that fails or where there was an unexpected error.
In rarer situations you may also see an `s` indicating a skipped tests (because the test is not applicable on your system) or a `x` for a known failure (because the developers could not fix it promptly).
After the dots, pytest will print summary information.

**Challenge 1: Altering functions to pass all tests**

Without changing the tests, alter the mean.py file from the previous section until it passes.
When it passes, `pytest` will produce results like the following:

```
pytest
```

```
collected 5 items

test_mean.py .....

========================== 5 passed in 2.68 seconds ===========================
```

<details>
 <summary> Challenge solution </summary>

There are many ways this challenge could be solved.
One way is to check for the presence of complex numbers before calculating the mean.

```
def mean(num_list):
    if any(isinstance(num, complex) for num in num_list):
       return NotImplemented
    else:
        try:
            return sum(num_list)/len(num_list)
        except ZeroDivisionError :
            return 0
        except TypeError as original_error :
            msg = "The algebraic mean of an non-numerical list is undefined.\
                   Please provide a list of numbers."
            raise TypeError(original_error.__str__() + "\n" +  msg)
```

</details>


Note, using `pytest -v` will result in `pytest` listing which tests are executed and whether they pass or not:

```
pytest
```

```
collected 5 items

test_mean.py .....

test_mean.py::test_mean_with_ints PASSED
test_mean.py::test_mean_with_zero PASSED
test_mean.py::test_mean_with_double PASSED
test_mean.py::test_mean_with_long PASSED
test_mean.py::test_mean_with_complex PASSED

========================== 5 passed in 2.57 seconds ===========================
```

As we write more code, we would write more tests, and pytest would produce more dots.

## Integration tests

Integration tests focus on gluing code together or the results of code when multiple functions are used.
See below for an conceptual example of an integration test.

Consider three functions `add_one()`, `multiply_by_two()`, and `add_one_and_multiply_by_two()` as a simplistic example.
Function `add_one()` increments a number by one, `multiply_by_two()` multiplies a number by two, and `add_one_and_multiply_by_two()` composes them as defined below:

```
def add_one(x):
    return x + 1

def multiply_by_two(x):
    return 2 * x

def add_one_and_multiply_by_two(x):
    return multiply_by_two(add_one(x))
```

Functions `add_one()` and `multiply_by_two()` can be unit tested since they perform singular operations.
However, `add_one_and_multiply_by_two()` can't be truly unit tested as it delegates the real work to `add_one()` and `multiply_by_two()`.
Testing `add_one_and_multiply_by_two()` will evaluate the integration of `add_one()` and `multiply_by_two()`.

Integration tests still adhere to the practice of comparing expected outcomes with observed results.
A sample `test_add_one_and_multiply_by_two()` is illustrated below:

```
def test_add_one_and_multiply_by_two():
    expected_value = 6
    observed_value = add_one_and_multiply_by_two(2)
    assert observed_value == expected_value
```

The definition of a code unit is somewhat ambiguous, making the distinction between integration tests and unit tests a bit unclear.
Integration tests can range from extremely simple to highly complex, contrasting with unit tests.
If a function or class merely amalgamates two or more unit-tested code pieces, an integration test is necessary.
If a function introduces new untested behavior, a unit test is needed.

The structure of integration tests closely resembles that of unit tests, comparing expected results with observed values.
However, deriving the expected result or preparing the code for execution can be significantly more complex.
Integration tests are generally more time-consuming due to their extensive nature.
This distinction is helpful to differentiate between straightforward (unit) and more nuanced (integration) test-writing requirements.

## Regression tests

Regression tests refer to past outputs for expected behavior.
The anticipated outcome is based on previous computations for the same inputs.

Regression tests hold the past as "correct."
They notify developers about how and when a codebase has evolved such that it produces different results.
However, they don't provide insights into why the changes occurred.
The discrepancy between current and previous code outputs is termed a regression.

Like integration tests, regression tests are high-level and often encompass the entire code base.
A prevalent regression test strategy extends across multiple code versions.
For instance, an input file for version X of a workflow is processed, and the output file is saved, typically online.
While developing version Y, the test suite automatically fetches the output for version X, processes the same input file for version Y, and contrasts the two output files.
Any significant discrepancies trigger a test failure.
Regression tests can identify failures missed by integration and unit tests.
Each project may adopt a slightly varied approach to regression testing, based on its software requirements.
Testing frameworks aid in constructing regression tests but don’t provide additional sophistication beyond the discussed concepts.

## Continuous integration

Continuous integration makes running tests as easy as possible by integrating the test suite into the development process. 
Every time a change is made to the repository, the continuous integration system builds and checks that code.

Based on the instructions you provide, a continuous integration server can:

- check out new code from a repository
- spin up instances of supported operating systems (i.e. various versions of OSX, Linux, Windows, etc.).
- spin up those instances with different software versions (i.e. python 2.7 and python 3.0)
- run the build and test scripts
- check for errors
- report the results.

Since the first step the server conducts is to check out the code from a repository, we'll need to put our code online to make use of this kind of server.

### Set Up a Mean Git Repository on GitHub

Our `mean.py` `test_mean.py` files can be the contents of a repository on GitHub.

* Go to GitHub and [create a repository](https://github.com/new) called aug-mean. Do this in your own user account and don't add any files to the new repo (no README/LICENSE, etc.).
* Turn the `aug-mean` directory that we've been working in on your computer into a git repository following the "…or create a new repository on the command line" instructions on GitHub:
```
echo "# aug-mean" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:yourusername/aug-mean.git
git push -u origin main
```
* Create a new branch (`git checkout -b yourinitials/init`).
* Use git to `add`, `commit`, and `push` the two files `mean.py` and `test_mean.py` to GitHub.

### GitHub Actions

[GitHub Actions](https://github.com/features/actions) is a continuous integration service provided by GitHub.
It's integrated directly into GitHub repositories and does not require additional accounts or external services.
Note that GitHub Actions usage is free for standard GitHub-hosted runners in public repositories, and for self-hosted runners.
For private repositories, each GitHub account receives a certain amount of free minutes and storage for use with GitHub-hosted runners, depending on the account's plan (see [here](https://docs.github.com/en/actions/learn-github-actions/usage-limits-billing-and-administration) for more information).

To use GitHub Actions, create a directory called `.github` and within it, create another directory called `workflows`.

```
mkdir -p .github/workflows
```

Inside the `workflows` directory, you can create a YAML file (e.g. `ci.yml`) to define your continuous integration process:

```
name: Continuous Integration

on: [push, pull_request]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
        python-version: [3.7, 3.8, 3.9, '3.10', '3.11'] 

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v2
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    - name: Run tests
      run: pytest
```


### Triggering CI

1. Add `.github/workflows/ci.yml` to your repository
2. Commit and push it.
3. Open a pull request with your changes.
4. Check how the CI is going in the PR.

Right now, the CI is failing.
Why is that?
When we set up for today's lesson, we used conda to install pytest.
In the CI workflow, we specified that our dependencies (in this case pytest) should be installed from a `requirements.txt` file.
That `requirements.txt` file is a conventional way to list all of the python packages that we need.
We haven't created that file yet.
Let's go ahead an create it, add it, commit it, and push it.
Since we need pytest, the `requirements.txt` file looks like this:

```
pytest==7.4.3
```

Pushing new changes to our branch automatically re-triggers the CI teststo re-run.
When all of our tests pass, we'll see a big green check mark next stating that "All checks have passed" and a green check next to our commit in our commit history.
If some of your checks don't pass, you can see what went wrong by clicking on the check which will launch the runtime information.
