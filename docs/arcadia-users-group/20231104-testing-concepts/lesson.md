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

