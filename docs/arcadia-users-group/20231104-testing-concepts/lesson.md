Everyone tests their software to some extent, if only by running it and trying it out.
Most programmers do a certain amount of exploratory testing, which involves running through various functional paths in your code and seeing if they work.

Systematic testing, however, is a different matter.
Systematic testing simply cannot be done properly without a certain (large!) amount of automation, because every change to the software means that the software needs to be tested all over again.

This lesson introduces automated testing concepts and shows how to use built-in Python constructs to start writing tests.

While this lesson uses Python, almost all programming languages have robust packages dedicated to testing. 

## An introduction to testing concepts

There are many ways to test software, such as:

- Assertions
- Exceptions
- Unit Tests
- Regresson Tests
- Integration Tests

*Exceptions and Assertions*: While writing code, `exceptions` and `assertions` can be added to sound an alarm as runtime problems come up. 
These kinds of tests, are embedded in the software iteself and handle, as their name implies, exceptional cases rather than the norm. 

*Unit Tests*: Unit tests investigate the behavior of units of code (such as functions, classes, or data structures).
By validating each software unit across the valid range of its input and output parameters, tracking down unexpected behavior that may appear when the units are combined is made vastly simpler.

*Integration Tests*: Integration tests check that various pieces of the software work together as expected. 

*Regression Tests*: Regression tests defend against new bugs, or regressions, which might appear due to new software and updates.

While each of these types of tests has a different definition, in practice there isn't a firm delineation between each type.

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
An exception be used to trigger additional error messages or an alternative behavior. 
Rather than immediately halting code execution, the exception can be 'caught' upstream with a try-except block.
When wrapped in a try-except block, the exception can be intercepted before it reaches global scope and halts execution.

To add information or replace the message before it is passed upstream, the try-catch block can be used to catch-and-reraise the exception:

```
def mean(num_list):
    try:
        return sum(num_list)/len(num_list)
    except ZeroDivisionError as detail :
        msg = "The algebraic mean of an empty list is undefined. Please provide a list of numbers."
        raise ZeroDivisionError(detail.__str__() + "\n" +  msg)
```

Alternatively, the exception can be handled apropriately for the use case.
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
    except TypeError as detail :
        msg = "The algebraic mean of an non-numerical list is undefined.\
               Please provide a list of numbers."
        raise TypeError(detail.__str__() + "\n" +  msg)
```

Exceptions have the advantage of being simple to include and when accompanied by useful help message, can be helpful to the user.
However, not all behaviors can or should be found with runtime exceptions.
Most behaviors should be validated with unit tests.

## Unit tests

Unit tests are so called because they exercise the functionality of the code by interrogating individual functions and methods.
Functions and methods can often be considered the atomic units of software but what is considered to be the smallest code _unit_ is subjective.
Implementing unit tests often has the effect of encouraging both the code and the tests to be as small, well-defined, and modular as possible.
In Python, unit tests typically take the form of test functions that call and make assertions about methods and functions in the code base.
Using a test framework makes running tests streamlined.
For now, we'll write some tests for the mean function and simply run them individually to see whether they fail.
In the next session, we'll use a test framework to collect and run them.

Unit tests are typically made of three pieces, some set-up, a number of assertions, and some tear-down. 
Set-up can be as simple as initializing the input values or as complex as creating and initializing concrete instances of a class.
Ultimately, the test occurs when an assertion is made, comparing the observed and expected values. For example, let us test that our mean function successfully calculates the known value for a simple list.

Before running the next code, save your `mean` function to a file called `mean.py` in the working directory.

You can use this code to save to file:

```
def mean(num_list):
    try:
        return sum(num_list)/len(num_list)
    except ZeroDivisionError :
        return 0
    except TypeError as detail :
        msg = "The algebraic mean of an non-numerical list is undefined.\
               Please provide a list of numbers."
        raise TypeError(detail.__str__() + "\n" +  msg)
```

Now, back in your Jupyter Notebook run the following code:

```
from mean import *

def test_ints():
    num_list = [1, 2, 3, 4, 5]
    obs = mean(num_list)
    exp = 3
    assert obs == exp
```

The test above: 
- sets up the input parameters (the list `[1, 2, 3, 4, 5]`);
- collects the observed result;
- declares the expected result (calculated with our human brain);
- and compares the two with an assertion.

A unit test suite is made up of many tests just like this one.
A single implemented function may be tested in numerous ways.

In a file called `test_mean.py`, implement the following code:

```
from mean import *

def test_ints():
    num_list = [1, 2, 3, 4, 5]
    obs = mean(num_list)
    exp = 3
    assert obs == exp

def test_zero():
    num_list=[0, 2, 4, 6]
    obs = mean(num_list)
    exp = 3
    assert obs == exp

def test_double():
    # This one will fail in Python 2
    num_list=[1, 2, 3, 4]
    obs = mean(num_list)
    exp = 2.5
    assert obs == exp

def test_long():
    big = 100000000
    obs = mean(range(1,big))
    exp = big/2.0
    assert obs == exp

def test_complex():
    # given that complex numbers are an unordered field
    # the arithmetic mean of complex numbers is meaningless
    num_list = [2 + 3j, 3 + 4j, -32 - 2j]
    obs = mean(num_list)
    exp = NotImplemented
    assert obs == exp
```

Use Jupyter Notebook to import the `test_mean` package and run each test like this:

```
from test_mean import *

test_ints()
test_zero()
test_double()
test_long()
test_complex()  ## Please note that this one might fail. You'll get an error message showing which tests failed
```

## Using the test framework `pytest`

We created a suite of tests for our mean function, but it was annoying to run them one at a time.
It would be a lot better if there were some way to run them all at once, just reporting which tests fail and which succeed.

Thankfully, that exists.
Recall our tests:

```
from mean import *

def test_ints():
    num_list = [1,2,3,4,5]
    obs = mean(num_list)
    exp = 3
    assert obs == exp

def test_zero():
    num_list=[0,2,4,6]
    obs = mean(num_list)
    exp = 3
    assert obs == exp

def test_double():
    # This one will fail in Python 2
    num_list=[1,2,3,4]
    obs = mean(num_list)
    exp = 2.5
    assert obs == exp

def test_long():
    big = 100000000
    obs = mean(range(1,big))
    exp = big/2.0
    assert obs == exp

def test_complex():
    # given that complex numbers are an unordered field
    # the arithmetic mean of complex numbers is meaningless
    num_list = [2 + 3j, 3 + 4j, -32 - 2j]
    obs = mean(num_list)
    exp = NotImplemented
    assert obs == exp
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

    def test_complex():
        # given that complex numbers are an unordered field
        # the arithmetic mean of complex numbers is meaningless
        num_list = [2 + 3j, 3 + 4j, -32 - 2j]
        obs = mean(num_list)
        exp = NotImplemented
>       assert obs == exp
E       assert (-9+1.6666666666666667j) == NotImplemented

test_mean.py:34: AssertionError
===================== 1 failed, 4 passed in 2.71 seconds ======================
```

In the above case, the pytest package 'sniffed-out' the tests in the directory and ran them together to produce a report of the sum of the files and functions matching the regular expression `[Tt]est[-_]*`.

The major benefit a testing framework provides is exactly that, a utility to find and run the tests automatically.
With pytest, this is the command-line tool called `pytest`.
When `pytest` is run, it will search all directories below where it was called, find all of the Python files in these directories whose names start or end with `test`, import them, and run all of the functions and classes whose names start with `test` or `Test`.
This automatic registration of test code saves tons of time and provides a consistent organization framework across Python projects.

When you run `pytest`, it will print a dot (`.`) on the screen for every test that passes, an `F` for every test that fails or where there was an unexpected error.
In rarer situations you may also see an `s` indicating a skipped tests (because the test is not applicable on your system) or a `x` for a known failure (because the developers could not fix it promptly).
After the dots, pytest will print summary information.

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

Using `pytest -v` will result in `pytest` listing which tests are executed and whether they pass or not:

```
py.test
```

```
collected 5 items

test_mean.py .....

test_mean.py::test_ints PASSED
test_mean.py::test_zero PASSED
test_mean.py::test_double PASSED
test_mean.py::test_long PASSED
test_mean.py::test_complex PASSED

========================== 5 passed in 2.57 seconds ===========================
```

As we write more code, we would write more tests, and pytest would produce more dots.
Each passing test is a small, satisfying reward for having written quality scientific software.
Now that you know how to write tests, let's go into what can go wrong.
