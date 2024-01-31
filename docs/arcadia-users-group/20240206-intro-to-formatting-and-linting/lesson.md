# Introduction to code formatting, linting, and style guides
This lesson explains some of the basic conventions around code formatting and style, with an emphasis on Python. It also explains how to use tools to automatically format code and check (or "lint") it for compliance with these style conventions.

The importance of defining a consistent format and style for the code we write arises from two unfortunate realities: code is easier to write than it is to read, but code is read more often than it is written (or rewritten). 

Code is easier to write than read because, when we are writing it, we usually know exactly what we are trying to do and we have the context needed to understand why and how we're doing it. By contrast, neither of these two things are typically true when we are reading code: we often either don't remember or never knew exactly what the author was trying to do when they wrote the code we're reading, and the context necessary to understand the code is invariably also unknown to us or at least not fresh in our minds. 

This means that, when writing code, we need to have a system of rules and guidelines in place to ensure that the code we write is as easy as possible for others (either our future selves or other developers) to read and understand. This is the purpose of code formatting and style conventions.*

*at a higher level, this is also, in part, the purpose of design patterns and application architectures, but that is a topic for a future lesson.


## An introductory example
As an example to help illustrate why code formatting and style are so important, consider the following code:
```python
def qr(a,b,c):
    return -(b-np.sqrt(b**2-4*a*c))/2/a,(-b-np.sqrt(b**2-4*a*c))/2/a
```
It is very hard to read this code, let alone understand what it does.

Now consider the same code written in a more readable style:
```python
def calculate_quadratic_roots(quadratic_coeff, linear_coeff, constant_coeff):

    discriminant_square_root = np.sqrt(
        linear_coeff ** 2 - 4 * quadratic_coeff * constant_coeff
    )

    root_1 = (-linear_coeff + discriminant_square_root) / (2 * quadratic_coeff)
    root_2 = (-linear_coeff - discriminant_square_root) / (2 * quadratic_coeff)

    return root_1, root_2
```
Notice how this code is easier to read and easier to understand (if still somewhat opaque). Notice that there are several kinds of changes in this version. For one, spaces are used around the operators, which generally makes code easier to read; this is a kind of *formatting convention*. In addition, the variable names are much longer and are more descriptive, which make it easier for reader to infer the meaning of the code; this is a kind of *style convention*. 

In this lesson, we'll discuss both formatting and style conventions, as well as tools to automatically format code and check that is complies with our style conventions.

## Lesson setup
We'll create a Python project to demonstrate how to use the tools we'll be discussing.

Create a new conda environment and activate it:
```bash
mamba create -y -n aug-linting-lesson python=3.11
mamba activate aug-linting-lesson
```

Create a new directory for the project:
```bash
mkdir 20240206-aug-linting-lesson
cd 20240206-aug-linting-lesson
```

Finally, create a new file called `main.py`. We'll add code to this file later.


## Formatting conventions
In programming, "formatting" refers to how code is laid out or arranged on the page or screen; for example, how many spaces to use for indentation, where to put spaces around operators, where to use line breaks (and how many), whether to use single or double quotes for strings, and so on. In Python and most other languages, these questions are not settled by the syntax of the language itself, so it is up to each programmer (or project, or team, or organization) to decide for themselves (or itself) how to resolve them. Unfortunately, because most formatting decisions are a matter of personal preference, a wide range of (often strongly-held) opinions about *how* code should be formatted has emerged. 

However, there *is* wide agreement that code should be formatted *consistently*. That is, once a set of formatting rules have been chosen, they should be applied consistently throughout a given codebase. This is because inconsistent formatting makes code significantly harder to read and maintain. More subtly, inconsistent formatting also pollutes the version history of a codebase with unnecessary and superficial changes, making it harder to understand the "real" or substantive changes that were made to the code.

### Example: breaking up long lines
One important formatting convention is that lines of code should not be longer than some maximum length. This is to ensure that code is readable on a wide range of screen sizes. (In Python and many other languages, a maximum line length of 80 or 100 characters is typically chosen.) The tricky part lies in determining *how* to break up lines that are longer than this maximum length; there are many options and no technical reason to prefer one over another.

For example, consider the following code:
```python
def calculate_total_income(gross_wages, taxable_interest, total_dividends, qualified_dividends, other_income):
    total_income = gross_wages + taxable_interest + (total_dividends - qualified_dividends) + other_income
    return total_income
```

It is clear that the function definition is too long to fit in one line, so it needs to be broken up. But where should the line breaks go?
One option is to break up the long lines after each comma or operator:
```python
def calculate_total_income(gross_wages, 
                           taxable_interest, 
                           total_dividends, 
                           qualified_dividends, 
                           other_income):
    total_income = (gross_wages
                    + taxable_interest
                    + (total_dividends - qualified_dividends)
                    + other_income)
    return total_income
```

Another option is to use a separate line for each argument and also for the closing parentheses:
```python
def calculate_total_income(
    gross_wages,
    taxable_interest, 
    total_dividends, 
    qualified_dividends, 
    other_income
):
    total_income = (
        gross_wages 
        + taxable_interest 
        + (total_dividends - qualified_dividends) 
        + other_income
    )
    return total_income
```
Although these two versions are syntactically identical and formatted similarly, the formatting rules they obey are quite different. Even worse, a "diff" or line-by-line comparison of the two versions is very hard to read, since almost every line is different in some trivial way. This means that if a programmer both reformatted the code from one format to the other and, at the same time, made a substantive change to it (like renaming one of the arguments of the `calculate_total_income` function), it would be hard to quickly determine which lines were meaningfully changed and which were just reformatted.

### Code formatters enforce formatting conventions
To both eliminate these kinds of formatting ambiguities and to automate the otherwise-tedious process of formatting code by hand, tools to automatically format code have been developed. These tools take files of source code as input and output the same code, but reformatted as necessary according to a pre-specified set of formatting rules.

In Python, the most popular code formatting tool is called `black`. This tool both automatically formats code and imposes its own opinionated set of formatting rules (hence its tagline: "any color you want"). This eliminates the need for developers to make (or argue about) these decisions themselves. Although `black`'s formatting rules can take some getting used to, the benefit of eliminating almost all formatting-related decisions is usually worth the effort of adjusting to its opinions. 


### Setting up `black`
To install `black` in our conda environment, run:
```bash
mamba install -y black
```

Next, let's add some poorly formatted code to our toy project. Add the following code (from our previous example) to `main.py`:
```python
def calculate_total_income(gross_wages, taxable_interest, total_dividends, qualified_dividends, other_income):
    total_income = gross_wages + taxable_interest + (total_dividends - qualified_dividends) + other_income
    return total_income
```
Now, from the command line, run:
```bash
black .
```
This command tells `black` to reformat all the Python files in the current directory (the lone dot in the command is the relative path to the current directory). If you look at `main.py` now, you'll see that the code has been reformatted according to `black`'s rules.

Now, try simplifying the calculation of `total_income` by removing the dividends from the sum, then run `black` again. You should see that, because the `total_income` line is shorter, it can fit on one line, so `black` automatically converts it back to a single line.

There is a succinct overview of `black`'s formatting rules in [its documentation](https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html). While it's good to be familiar with these rules, there is no need to memorize them. Indeed, the purpose of using a formatting tool like `black` is to eliminate the need to manually write your code according to any particular formatting conventions or even to think about formatting at all. 


## Style guides
Although formatting conventions help constrain the very low-level aspects of how code is written, additional rules and conventions are required to ensure that code is both readable and understandable. These conventions are usually expressed in the form of style guides. Style guides define rules, conventions, and guidelines to which all code in a codebase should adhere. They concern both both low-level questions like how to name variables and functions, as well as higher-level considerations like documentation standards and some aspects of how code is organized or structured.

### PEP8 and Python style guides
Many language have an official style guide. For Python, the official style guide is called [PEP8](https://peps.python.org/pep-0008/#introduction). In addition, Google's [Python style guide](https://google.github.io/styleguide/pyguide.html) is an important extension of PEP8 that defines additional standards, especially around comments and documentation. Most major Python projects follow at least PEP8, and we should strive to follow it at Arcadia as well. This is true no matter the scale of the project; it is a good practice to follow PEP8 even for small scripts and one-off analyses. As projects grow, it is usually wise to start imposing additional style conventions from Google' style guide on top of PEP8.

Many of the conventions defined in PEP8 concern formatting and are automatically enforced by using `black` to format our code. However, PEP8 also includes style conventions that we must follow manually. Here, we'll discuss two important categories of style conventions: naming conventions and documentation conventions.

### Naming conventions
Naming conventions are an important element of code style. They determine how variables, functions, classes, modules, and other objects should be named. In Python, there are some strict rules about how to name each of these things:

- variables, functions, and modules* should be named in `lower_snake_case`.
- class names should be `UpperCamelCase`.
- global variables should be named in `ALL_CAPS_SNAKE_CASE`.
- names should never begin with a number.

*"modules" are the individual python files that are contained with a python project or package; e.g., `main.py` is a module.

In other words, all names should be `lower_snake_case` except for global variables (which should be used sparingly, if at all) and class names. 

Note that *instances* of a class are variables and should be named in `lower_snake_case`, not `UpperCamelCase`. Here is an example:
```python
class ProteinSequence:
    def __init__(self, sequence):
        self.sequence = sequence

protein_sequence = ProteinSequence('MSKGEELFTG')
```

All names should be specific, descriptive, and  unambigious. When in doubt, err on the side of verbosity, and always avoid unecessary abbreviations. Although the meaning of "descriptive" is obviously subjective, there are some general guidelines that all names, no matter how brief, should follow:

- Function names should generally begin with a verb that corresponds to what they do. Functions that return a boolean value should have a name of the form `is_<something>` or `has_<something>`, functions that calculate something `calculate_<something>` or if they modify an object in-place, they should be named either `set_<something>` or `update_<something>`.

- Variable names should not include type information (e.g., `list_of_ints` or `title_str`), since Python is a dynamically typed language and the type of a variable can change at runtime. The same goes for functions (e.g. `calculate_tm_score` instead of `calculate_tm_score_fn`). To express type information, type annotations should be used (this is a topic for a future lesson).

- Where possible, use the plural form of a noun for variables that contain a collection of things (e.g., for a list of proteins, use `proteins` instead of `proteins_list`). 


Here are some examples of good and bad variable names:
```python
# bad (too short, ambiguous)
pids = ['P12345', 'P23456', 'P34567']

# bad (includes type information)
protein_id_list = ['P12345', 'P23456', 'P34567']

# good
protein_ids = ['P12345', 'P23456', 'P34567']
```

```python
# bad (ambiguous and not descriptive)
def calculate(protein1, protein2):
    ...

# bad (not lower_snake_case)
def calculateTMscore(protein1, protein2):
    ...

# good
def calculate_tm_score(protein1, protein2):
    ...
```

```python
# bad (unnecessary abbreviations)
usr_inpt = input('Enter your name: ')

# bad (ambiguous abbreviation)
user_in = input('Enter your name: ')

# good
user_input = input('Enter your name: ')
```


#### Aside about single-letter variable names
Although PEP8 and other style guides do not explicitly forbid the use of single-letter variable names, they are strongly discouraged in most contexts. This is because single-letter variable names are, by definition, not descriptive. They can also be quite literally ambiguous; it is often hard to visually detect the difference between `i`, `j`, `l`, and `1`, for example. Finally, a subtler reason to avoid single-character variable names is that they can make refactoring harder, as it may be more cumbersome to search for and rename single-character variable names than more descriptive ones.

The only exception to this general prohibition should be for variables defined in a very local or narrow scope such as a short `for` loop or in a lambda function. Here are two examples where single-letter variable names is used within a single line (which is as narrow a scope as possible):
```python
# single-letter variable names in a list comprehension
filepaths = ['data_1.txt', 'data_2.txt', 'data_3.csv']
txt_filepaths = [f for f in filepaths if f.endswith('.txt')]

# single-letter variable names in an anonymous lambda function
numbers = [1, 2, 3, 4, 5]
squared_numbers = list(map(lambda x: x**2, numbers))
```
In cases such as these, you may decide that the brevity of this code outweighs the loss of readability. However, even in these cases, it is often possible to use more descriptive variable names without sacrificing much brevity:
```python
txt_filepaths = [filepath for filepath in filepaths if filepath.endswith('.txt')]

squared_numbers = list(map(lambda value: value**2, numbers))
```

Unfortunately, single-letter variable names are a tempting shortcut anad seem to be common in scientific programming. Invariably, however, this comes at the price of readability. 

Consider the following example of iterating over the pixels in a timelapse image:
```python
# create a random timelapse image with 3 timepoints
image = np.random.rand(3, 100, 100)

# iterate over the pixels in the image
N_T, N_X, N_Y = image.shape
for t in range(N_T):
    for x in range(N_X):
        for y in range(N_Y):
            v = image[t, x, y]
            print(f'The pixel intensity at time {t} and position ({x}, {y}) is {v}')
```
Although this code is compact, it is hard to keep track of the many single-character variables, and it will only become harder as the body of the nested for loops grows more complex. In addition, although they are not literally single characters, the names `N_X` and `N_Y` are ambiguous (and also wrongly capitalized). 

This version of the code, with more descriptive variable names, is much clearer:
```python
# create a random timelapse image with 3 timepoints
image = np.random.rand(3, 100, 100)

# iterate over the pixels in the image
num_timepoints, num_rows, num_cols = image.shape
for time_ind in range(num_timepoints):
    for row_ind in range(num_rows):
        for col_ind in range(num_cols):
            intensity = image[time_ind, row_ind, col_ind]
            print(
                f'The pixel intensity at timepoint {time_ind} '
                f'and position ({row_ind}, {col_ind}) is {intensity}'
            )
```

### Documentation conventions
In the context of code style guides, "documentation" refers to human-readable text that is embedded in the source code to explain what the code does and how it works. It is very important to define standards and conventions for documentation because it is a major way--and sometimes the only way--to ensure that code is readily understandable by others. In Python, documentation takes two forms: comments that can appear anywhere in the code and docstrings that accompany modules, classes, and functions.

#### Comments
Comments are human-readable lines of text that can appear anywhere in the source code. In Python, they are denoted by the `#` character. Although they are ignored by the Python interpreter and might seem like an area where "anything goes", it is important to adhere to strict standards of grammar and style when writing comments, since they are often the only way to explain the purpose of a particular line or block of code.

In particular, comments should be complete sentences with proper punctuation. They should be written in full English sentences and should be grammatically correct. Importantly, they should end with periods; this is not only grammatically correct but is also the only way to indicate to the reader that the comment is complete and was not accidentally truncated (or never completely written in the first place). 

Most importantly, comments should generally be used to explain *why* a particular line or block of code is doing what it is doing, not *what* it is doing or *how* it is doing it (usually, this should be apparent from the code itself). 

Here is an example of a good comment that explains *why* a CSV file is loaded with a particular set of parameters:
```python
# We can assume missing values are always represented by the string 'NaN' in the CSV file,
# so the parameter 'na_values' is set to 'NaN'.
df = pd.read_csv('data.csv', na_values='NaN', keep_default_na=False)
```

Here is another example of a good comment that explains a non-obvious implementation detail when computing the nth Fibonacci number:
```python
def calculate_fibonacci(n):
    """
    Calculate the nth Fibonacci number using naive recursion.
    """
    # By definition, the Fibonacci sequence starts with zero and one.
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)
```

#### Things comments should *not* be used for
There are two major ways in which comments are commonly misused. Note that avoiding these misuses is not specific to Python but is a general best practice that applies to all programming languages.

1. As we alluded to above, comments should not be redundant with the code. They should not simply restate what the code is doing and they should not include information that is apparent or readily inferred from the code itself. Here are some examples of such redundant comments:
    ```python
    # find the minimum value and clamp it to 0.
    min_value = max(min(values), 0)

    # get all the .txt files in the input directory.
    filepaths = input_dirpath.glob('*.txt')

    # create the directory if it doesn't already exist.
    if not os.path.exists(dirpath):
        os.mkdir(dirpath)
    ```

1. Comments should *never* be used to temporarily "disable" code by "commenting it out." While this is a common and convenient practice, it leads to various problems over time. Commented-out code is difficult to document, easy to forget about, exempt from formatting and linting checks, and over time will pollute the version history. Instead, there are several clearer and more maintainable approaches to "disabling" code: it can be moved into a conditional block with an appropriate condition, moved to its own file, or moved to its own branch on GitHub. 
    The best approach depends on the nature of the code and the reason it is being disabled; but in general, short blocks of code can often be moved into a conditional block, while longer blocks of code should be moved to their own file or branch. In all cases, always think carefully about whether or not the code in question can in fact simply be deleted; often it can be. In the event that is it needed later on, it can usually be recovered from the commit history of the repo on GitHub.


#### Docstrings
Docstrings (short for "documentation strings") are triple-quoted strings that appear directly after the declaration of a module, class, or function and are used to describe what the module, class, or function does, what its inputs are, and what its outputs are. They are treated in a special way by the Python interpreter; they are accessible at runtime and can be used to automatically generate documentation for a Python codebase. (As an aside, many languages have a similar feature, but the term "docstring" is Python-specific.)

Python itself does not impose any constraints on the structure or contents of docstrings, but there is both [an official Python style guide for docstrings](https://peps.python.org/pep-0257/) and several conventional styles, including the [Google style](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings) and the [Numpy style](https://numpydoc.readthedocs.io/en/latest/format.html#docstring-standard).

In general, both conventions are similar. For functions, both require a docstring to begin with an explanation of what the function does. This explanation should be brief and should not discuss implementation details, but should provide enough information for someone to use the function without reading its implementation. After the summary, both the Google and numpy conventions require that the docstring include a description of each of the inputs and outputs of the function, followed finally by any exceptions it might raise.

As an example, let's revisit the example from the introduction:
```python
def calculate_roots(quadratic_coeff, linear_coeff, constant_coeff):
    discriminant_square_root = np.sqrt(
        linear_coeff ** 2 - 4 * quadratic_coeff * constant_coeff
    )
    root_1 = (-linear_coeff + discriminant_square_root) / (2 * quadratic_coeff)
    root_2 = (-linear_coeff - discriminant_square_root) / (2 * quadratic_coeff)
    return root_1, root_2
```
Although it is possible to infer the purpose of this function from the descriptive variable names, there is still some ambiguity, especially if we lack the mathematical knowledge to interpret the equations in the code. 

Here is the same function with a docstring (in the Google style):
```python
def calculate_roots(quadratic_coeff, linear_coeff, constant_coeff):
    """
    Calculate the real roots of a second order polynomial of the form
    a * x^2 + b * x + c = 0.

    Args:
        quadratic_coeff: The coefficient of the quadratic term, or `a` in the above equation.
        linear_coeff: The coefficient of the linear term, or `b` in the above equation.
        constant_coeff: The constant term, or `c` in the above equation.

    Returns: 
        A tuple containing the two real roots of the polynomial.
    """
    discriminant_square_root = np.sqrt(
        linear_coeff ** 2 - 4 * quadratic_coeff * constant_coeff
    )
    root_1 = (-linear_coeff + discriminant_square_root) / (2 * quadratic_coeff)
    root_2 = (-linear_coeff - discriminant_square_root) / (2 * quadratic_coeff)
    return root_1, root_2
```
This version of the function is both easy to read and easy to understand; the docstring explains exactly what the function does, what its inputs are, and what its outputs are, and the implementation is transparent and easy to follow thanks to the descriptive variable names.


## Linting
"Linting" refers to the analysis of source code to detect syntax errors, potential bugs, and violations of style conventions. Linters are similar to formatters in the sense that they analyze source code and are used to ensure that code adheres to certain standards, but unlike formatters, they typically do not modify the code itself. Instead, linters typically flag issues (or "lint errors") for the developer to fix.

Linters are particularly important for interpreted languages like Python that are dynamically typed and interpreted at runtime, because many errors that would be caught by the compiler in a statically typed language (like C or Java) are not caught until the code is actually run, by which time it may be difficult or time-consuming the fix the error. Linters can catch these kinds of errors at an early stage when they are easy for the developer to fix.

For example, consider the following code:
```python
def show_full_name(first_name, last_name):
    full_name = first_name + last_nam
    print(f'Your full name is {full_name}!')
```
Note that there is a typo in the function: the variable `last_name` is misspelled as `last_nam`. Unfortunately, because Python is interpreted, this mistake will go unnoticed until the code is run and the `show_full_name` function is called. At this point, an error will occur (and the Python process will crash) because the variable `last_nam` is not defined. A linter, by analyzing the source code, can detect this kind of error before the code is ever run (much less shared with others or released) and flag it for the developer to fix.

In Python, one popular linting tool is called `ruff`. Let's try it out. First, install `ruff` in our conda environment:
```bash
mamba install -y ruff
```
Now, copy the function above into `main.py` and run `ruff` from the command line:
```bash
ruff check .
```
You should see an output that looks like this:
```bash
main.py:2:5: F841 Local variable `full_name` is assigned to but never used
main.py:2:30: F821 Undefined name `last_nam`
Found 2 errors.
```
Each line corresponds to one error that `ruff` identified. In this case, the second line corresponds to our typo in the variable `last_name`. The cryptic `F821` is a code that identifies the kind of error that was detected. In this case, `F821` corresponds to the "undefined name" error. The `2:30` indicates that the error was found on line 2 and at column 30. 

Note that `ruff` did not actually *run* our script `main.py` to detect this error. Indeed, even if it had, no error would have occured, since our script does not actually call the `show_full_name` function; it only defines it. Instead, `ruff` detected the error by analyzing the source code itself.

What about the other error that `ruff` found? This error is actually a consequence of our typo; because we misspelled `last_name`, the real variable `full_name`--which is an argument of the `show_full_name` function--is never actually used. This is an example of a style convention that `ruff` checks for; although unused variables won't cause errors when the code is run, it is a common convention that function definitions should only include arguments that are used (or referenced) in the body of the function. This enhances readability by preventing the reader from having to determine and keep track of which arguments are not actually used in the function. Here, `ruff` has detected that the variable `full_name` is never used and flagged it as a style violation.

Now, fix the typo and run `ruff check` again. This time, you should see no output, which means that `ruff` found no errors in the code. 

This does not, unfortunately, mean that our code is perfect. There are *a lot* of style conventions in the world, and `ruff` can check for many of them. For example, notice that our function does not have a docstring, which most style guides require and which we might well want our linter to flag. 

Let's run `ruff` again, but this time we'll enable all of `ruff`'s checks by passing the `--select ALL` flag:
```bash
ruff check --select ALL .
```
You should see a minor avalanche of new errors that looks like this:
```bash
warning: `one-blank-line-before-class` (D203) and `no-blank-line-before-class` (D211) are incompatible. Ignoring `one-blank-line-before-class`.
warning: `multi-line-summary-first-line` (D212) and `multi-line-summary-second-line` (D213) are incompatible. Ignoring `multi-line-summary-second-line`.
main.py:1:1: D100 Missing docstring in public module
main.py:1:5: ANN201 Missing return type annotation for public function `show_full_name`
main.py:1:5: D103 Missing docstring in public function
main.py:1:20: ANN001 Missing type annotation for function argument `first_name`
main.py:1:44: ANN001 Missing type annotation for function argument `last_name`
main.py:3:5: T201 `print` found
Found 8 errors.
```
Notice that, among other issues, `ruff` has now noticed that our function (and indeed the `main.py` module itself) does not have a docstring. As an aside, the `warning` lines at the beginning of the output indicate a problem with our use of `ruff`: we have enabled so many lint rules that some of the rules are actually in conflict with one another, so `ruff` has to choose which ones to enforce. 

In general, choosing the appropriate set of lint rules to enforce is a context- and project-dependent decision. As codebases grow and either become more complex or are developed by multiple people, it often makes sense to enforce increasingly strict and extensive linting rules. For our purposes at Arcadia, using the default rules that `ruff` enforces (i.e., using `ruff check` alone) is a great place to start; this will catch many common typos and bugs that will cause errors at runtime (like undefined and unused variables). 


### When to format and when to lint
The short answer is early and often: because formatters and linters are fast and easy to run, it is best to run them frequently and as early as possible in the development process, when errors are easy to fix. Most IDEs can be configured to run formatters automatically each time a file is saved, and linters are often integrated with IDEs as well (this is how VS Code, for example, displays squiggly red lines under undefined variables).

In addition, formatting and linting are usually run automatically as part of a [continuous integration (CI) pipeline](https://training.arcadiascience.com/arcadia-users-group/20231104-testing-concepts/lesson/#continuous-integration). Briefly, this means that, for example, whenever a PR is opened on GitHub, the same formatting and linting tools that a developer would run locally are run remotely on the code in the PR. This ensures that the code on the `main` branch in the GitHub repo--which is the "final" version of the code that will ultimately be shared with or deployed to users--is properly formatted and passes the project's linting rules, whether or not individual developers took the time to run these tools locally. 


## Beyond formatting and linting: software architecture and design patterns
While formatting, style guides, and linters can constrain many of the details of how code is written and prevent many common kinds of bugs, they do not address larger questions about how code should be structured. For example, when should a class be used instead of a function? When should a large function (or class, or module) be split up into separate components? What kinds of abstractions should be used to represent a particular concept? These questions are, of course, subjective and context-dependent; they require care and experience to answer. However, there are general guidelines and patterns that can help. This is the domain of software architecture and design patterns, which will be the subject of a future AUG lesson.