# Introduction to Python, Part 1

Follow along in **Binder** by clicking the badge below:  

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Arcadia-Science/arcadia-computational-training/HEAD?labpath=docs%2Farcadia-users-group%2F20230228-intro-to-python-1%2Fplayground.ipynb)

---
## 0. Fundamentals of Python

Python is a popular programming language. It was designed to be easy to read in comparison to other programming languages, so it's a great first programming language to learn. 

**This lesson** covers the following basics of Python, such as:
- variables
- data types
- built-in functions
- creating custom functions
- running Python from the command line

Over the following lessons, we'll cover more basics of Python, including:
- data structures
- loops
- conditional expressions
- packages
- methods
- debugging
- ... and more!

At the end of this workshop series, you'll have enough experience with Python to be able to write your own basic Python scripts. You'll also have enough knowledge of Python to be able to use the OpenTrons API (Application-Program Interface) to control our in-house liquid handling robot, covered in the upcoming Intro to OpenTrons series.

---
### 0.1 Jupyter Notebooks

For the first workshop, we'll work in an interactive computing environment called a Jupyter notebook. To run a "cell" of code in Jupyter, you'll press <kbd>Shift</kbd>+<kbd>Return</kbd> from inside the cell. The result of the cell - the output - will display just below the cell.

You can tell if a cell has successfully executed based on the `[ ]` text to the left of the cell. A cell that is in progress has an asterisk `[*]`, and a cell that has completed has a number `[1]`.

For more on Jupyter notebooks, you can check out this [AUG Lesson](https://training.arcadiascience.com/arcadia-users-group/20221024-jupyter-notebooks/lesson/). 

> **Fun fact!**
>
> The Python programming language is not named for snakes, but instead for Monty Python, a signifier of the idea that the language should be [fun to use](https://en.wikipedia.org/wiki/Python_(programming_language)#Design_philosophy_and_features).  
> Despite this, many Python tools and packages make reference to snakes, such as packages you may have heard us talk about before: [Anaconda](https://www.anaconda.com/products/distribution), [conda](https://docs.conda.io/en/latest/), [mamba](https://mamba.readthedocs.io/en/latest/), [snakemake](https://snakemake.readthedocs.io/en/stable/), etc.

---
### 0.2 Python Version

This lesson is written for Python version 3 and above. You can figure out what version of Python you're running using the cell below. (We'll explain how the cell below works at the end of the lesson.)


```python
!python --version
```

    Python 3.11.0


---
## 1. Variables

Variables in programming languages are containers for assigning values.

Below, we assign the value `1` to the variable `x` and the value `4` to the variable `y`.


```python
x = 1
y = 4
```

When we ask Python to evalute `x + y`, it substitutes the value `1` for `x` and the value `4` for `y`.

Running the cell below returns the output value of the expression `x + y`.


```python
x + y
```




    5



---
## 2. Data types

Variables in Python come in a variety of types, such as:
- `int` or **integer**: whole numbers such as `1`, `2`, `3`, etc.
- `float` or **floating-point number**: numbers including decimals, e.g. `1.03`.
- `str` or **string**: chains of alphanumeric characters flanked by quotation marks, e.g. `"apple"`.  
    Double-quotes are stylistically perferred, but single-quotes also work.  
    If you need to include quotation marks in a string, you can use the other option to "escape" the quotation mark.

Python is able to natively perform certain operations using these datatypes, such as basic addition `+`, subtraction `-`, multiplication `*`, division `/`, etc.


```python
1 + 2 * 3.4 / 5
```




    2.36



Python also has some helpful intuitive operations – for example, you can join two strings together with a `+` operator as follows:


```python
"pine" + "apple"
```




    'pineapple'



Certain operations are not supported by default in Python - for example, you can't add a `str` with an `int`. Running the code below will cause a `TypeError`. Python is quite helpful in explaining errors you might encounter. Read the error message below and see if it makes sense to you.

In general, you should expect to encounter *lots* of these errors, or "bugs", when you start getting into programming.  
**This is totally normal!**   

If you're ever confused about the source of an error, websites such as [StackOverflow](https://stackoverflow.com/) are great places to look for answers.  
One skill in learning to programming is learning what part of an error message to Google.


```python
3 + "5"
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    Cell In[17], line 1
    ----> 1 3 + "5"


    TypeError: unsupported operand type(s) for +: 'int' and 'str'


> **Fun Fact!**
>
> The term "bug" predates modern computers, but there are real examples of actual insects interfering with the function of a computer, such as this ["bug" found at Harvard in 1947](https://education.nationalgeographic.org/resource/worlds-first-computer-bug). 

---
## 3. Using variables

You assign variables in Python using the `variable = value` syntax. You can perform operations on a mix of hard-coded values and variables interchangeably. This is very useful when you expect to use a variable in many different places in your script - Python keeps track of its value so you don't have to.

If you use variable names that correspond to the value the variable holds (think `wind_mph` for wind speed), this can also help make your code more readable for yourself and others.


```python
a = 1
b = 6 + a
c = a * b

a + b + c
```




    15



You can assign a different value to a variable later in your code, which replaces the original value. This can be useful, but it's also important to be careful not to overwrite variables you want to keep!


```python
a = 4

a + b
```




    11



---
## 4. Built-in Python functions

In addition to managing variables and values, Python also provides a variety of [built-in functions](https://docs.python.org/3/library/functions.html).  
A **function** is a block of organized, reusable code that accomplishes a specific task.

Functions are "called" by chaining the function name with parentheses `()`. Parameters of that function can be typed between the parentheses to tell the function what to do.

For example, the `print()` function takes any value and prints it as output.


```python
print("Hello, world!")

print(a + b)
```

    Hello, world!
    11


We can call a function from within another function call. For example, the `type()` function gives the type of a Python value.


```python
print(type(4))
print(type("Hello, world!"))
```

    <class 'int'>
    <class 'str'>


---
## 5. Typecasting

A bit earlier, we tried to evalute the expression `3 + '5'`. This failed because we were trying to add an `int` and a `str`, which isn't natively supported operation with the `+` operand.

If we wanted to actually get the sum of 3 + 5 in this case, but `'5'` is given as a `str`, we can actually **force** `'5'` to be an `int` instead using typecasting, as below:


```python
3 + int("5")
```




    8



You can see that now, instead of throwing a `TypeError`, the expression returns the expected value.  

We typecast in Python by calling our data type as a function, e.g. `str()`, `int()`, `float()`, etc.  
In some cases, you can't cast a value into another type; for example, running the code below throws a `ValueError`.


```python
int("banana")
```


    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    Cell In[24], line 1
    ----> 1 int("banana")


    ValueError: invalid literal for int() with base 10: 'banana'


This example is probably pretty intuitive, as it's hard to imagine how you would turn the string `'banana'` into an integer.  
But there are plenty of cases where typecasting won't work, so be aware that this isn't a perfect solution.

---
## P1. Practice

Let's try some things with basic Python variables!

> ### Practice 1
> What values do `x` and `y` have after each of the following statements?

<details>
    <summary> Practice 1 Answer </summary>
    <code>x</code> = 25, <code>y</code> does not yet exist <br>
    <code>x</code> = 25, <code>y</code> = 6 <br>
    <code>x</code> = 100.0, <code>y</code> = 6 <br>
    <code>x</code> = 100.0, <code>y</code> = 10 <br>
</details>


```python
x = 25
y = 6
x = x * 4.0
y = y + 4
```

> ### Practice 2
>
> What is the expected value of `m` at the end of the cell below?

<details>
    <summary> Practice 2 Answer </summary>
    This is a trick question! You might have expected the cell below to throw a <code>TypeError</code> because we're multiplying an <code>int</code> with a <code>str</code>. But <code>`4 * '15'`</code> is actually a special operation in Python; it's telling Python to repeat the string <code>'15'</code> four times. Therefore, the correct answer is <code>'15151515'</code>
</details>


```python
i = 3
j = "5"
k = i * int(j)

l = 4
m = l * str(k)
```

---
## 6. Defining a custom function

In addition to working with built-in functions, you can also define your own functions in Python. This is one of the most powerful ways to use the language, as it allows you to write one block of code which you can use repeatedly in your scripts.

Let's write our first function, called `hello_world()`.

To define a custom function, you can start by writing `def`, followed by the desired name of your function, and parentheses `()`. Finish the line with a colon `:`.


```python
def hello_world():
    print("Hello world!")
```

When you execute the cell above, nothing prints out. Why?  
The answer is that using the code above, you've only told Python that you're defining a function called `hello_world()`, which itself calls `print()`. To run the function, you have to call it using the parentheses operator, as below.


```python
hello_world()
```

    Hello world!


---
## 7. Indentation and code blocks

You've defined a function above, but how does Python know when the function ends?  
Python uses **indentation** to signify the scope of a function. In the code block below, we define a function, then define a variable, and finally pass the variable to the function.

The line break and lack of indentation after the end of the function's scope tells Python that the function is completed.  
> **Note:**  
> This indentation syntax is uncommon among programming languages – often, languages require specific characters to set the scope of the code.
> For example, in **C** (another programming language), you end every code line with a semicolon `;`.


```python
def hello_name(name):
    return "Hello " + name + "!"

my_name = "Guido"

hello_name(my_name)
```




    'Hello Guido!'



You might notice some differences in the code above to the `hello_world` function we defined previously. Let's go over these differences.

- There is now a variable `name` in the parentheses of the `hello_name` definition.  
    This is how we define **arguments** of functions, or their input parameters. For example, the `print()` function accepts a comma-separated list of values as its arguments. Arguments act as placeholders – in the above example, `name` has no explicit value. But any value or variable placed into `hello_name` gets treated as the `name` variable, which is then kept through the rest of the function.
    
- The function ends with a **`return`** statement instead of a `print()` call.  
    Most Python functions should end with a **`return`** statement. This is the value that the function spits out when it finishes running. If a function lacks a **`return`** statement, it will instead return **`None`**, a special value of the type `NoneType`.
    
An important thing to know is that the output of functions can themselves be assigned to variables, as exemplified below. Combining function calls with variable assignment is a powerful way of using Python functions to modify or generate new variables.


```python
sentence_1 = hello_name(my_name)
sentence_2 = "My name is Python!"

print(sentence_1, sentence_2)
```

    Hello Guido! My name is Python!


---
## 8. Comments

A crucial part of writing good code is being able to understand what it does later.  
For example, consider how mystifying it can be to try to read the code block below.

> Note: the `**` operand is the exponential.


```python
def factor(a, b, c):
    step_one = -1 * b
    step_q = 4 * a * c
    step_two_a = step_one + (b ** 2 - step_q)
    step_two_b = step_one - (b ** 2 - step_q)
    step_p = 2 * a
    step_three_a = step_two_a / step_p
    step_three_b = step_two_b / step_p
    result = step_three_a, step_three_b
    return result

a = 1
b = 7
c = 3

factor(a, b, c)
```




    (15.0, -22.0)



The function above is definitely an example of inefficiently written code, but let's put that aside for now.  
If you ended up writing the function above, it might be helpful to be able to know what the overall goal of the code is, and perhaps what each step is doing.

This is where **comments** come to the rescue. Comments in Python begin on the left with a hash mark (`#`) and are ignored by the Python interpreter. Comments can also be written in blocks demarcated with triple-double-quotes (`"""`). You can even include a comment in the same line as functional code!

Consider the code below with comments - how does the code feel with comments and additional line breaks included?


```python
# Applies the quadratic formula to find the intercepts of a quadratic equation of the format y = ax**2 + bx + c
def factor(a, b, c):
    """  This is a block comment.
    
    The formula is:
    -b +/- sqrt(b**2 - 4ac) / 2a
    """
    
    step_one = -1 * b # evaluates -b
    step_q = 4 * a * c # evaluates 4ac
    
    step_two_a = step_one + (b ** 2 - step_q) # evaluates the numerator with addition
    step_two_b = step_one - (b ** 2 - step_q) # evaluates the numerator with subtraction
    
    step_p = 2 * a # evaluates the denominator
    
    step_three_a = step_two_a / step_p # gets the right intercept
    step_three_b = step_two_b / step_p # gets the left intercept
    result = step_three_a, step_three_b # combines the intercept into a tuple
    
    return result

# Defines a, b, and c 
a = 1
b = 7
c = 3

# Run the actual function, returning result
factor(a, b, c)
```




    (15.0, -22.0)



---
## P2. Practice

Let's try writing some basic Python functions.

> ### Practice 3
> Write a function called `greetings()` that takes two arguments: `greeting` and `name` and returns the string `'Greeting, Name!'`

<details>
<summary> Practice 3 Sample Answer </summary>
    <pre><code><b>def</b> greetings(greeting, name):
    <b>return</b> greeting + ', ' + name + '!'
</code></pre>
</details>



```python
###########################################
# Write your function in the space below. #
## Then run the cell to check your work. ##



###########################################

greeting = "Bonjour"
name = "Jacques"

greetings(greeting, name)
```

    Bonjour, Jacques!


> ### Practice 4
> What happens if you pass the variable `robot_name` below to your `greetings()` function?
>
> How could you modify the function to avoid this error?

<details>
<summary> Practice 4 Sample Answer </summary>
    <pre><code><b>def</b> greetings(greeting, name):
    <b>return</b> greeting + ', ' + str(name) + '!'
</code></pre>
</details>


```python
###############################################
# Write your new function in the space below. #
#### Then run the cell to check your work. ####




###############################################

robot_name = 120

greetings(greeting, robot_name)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    Cell In[34], line 12
          1 ###############################################
          2 # Write your new function in the space below. #
          3 #### Then run the cell to check your work. ####
       (...)
          7 
          8 ###############################################
         10 robot_name = 120
    ---> 12 greetings(greeting, robot_name)


    Cell In[40], line 6, in greetings(greeting, name)
          5 def greetings(greeting, name):
    ----> 6     print(greeting + ", " + name + "!")


    TypeError: can only concatenate str (not "int") to str


---
## 9. Running Python from the command line

In this lesson, we've taken advantage of the interactive computing experience offered by Jupyter notebooks.   
This computing environment is nice because it allows you to link input code to output data more easily.  
However, there are other ways to execute Python code.

For example, you can write Python code into a text file ending with `.py`.  
We've included a script in the lesson folder called `hello_world.py`. Its contents are as follows:
```python
print("Hello world!")
```
You can execute that script using the command line as follows:


```python
!python hello_world.py
```

    Hello world!


The cell above starts with a special Jupyter operator, the exclamation point `!`, which passes code directly to a shell.  
This is the same as using `python hello_world.py` in your command line terminal.  

Code executed through a Python script works just the same as code executed in Jupyter, and comes with some advantages:
- it's the most common way to use Python
- it's easier to compartmentalize code that runs different functions
- it doesn't requires setting up a Jupyter environment, which can be confusing

In general, Jupyter notebooks are a helpful way to write exploratory code, while functions you've finalized and plan to use repeatedly are better off being stored in scripts.

---
### 9.1 Receiving user input with `input()`

The built-in function `input()` prompts the user for input and accepts the response.  
`input()` takes a `str` argument which can be used to describe what the function is trying to get from the user as input.

This is one way to be able to interact with a Python script interactively.  
In the example below, the user is prompted to input a day of the week.


```python
weekday = input("What day of the week is it?")
print("It sounds like it's " + weekday)
```

    What day of the week is it? Wednesday


    It sounds like it's Wednesday


You can use this function to prompt a user for input as part of a Python script.  
Try running the script `hello_name.py` from a Terminal to see how the input function could be used.

The contents of the script are shown below.
```python
name = input("What's your name?")
print("Hello, " + name + "!")
```

---
## P3. Practice
Let's try writing a Python script.

> ### Practice 5.
> Write a Python script in a file called `greetings.py`.  
> The script should prompt the user for a greeting and a name as interactive input, and print  
> `{Greeting}, {Name}!`  

You'll need to test the script using the terminal, in part because Jupyter doesn't reliably allow user input in output blocks.

---
## 10. Problem Set

To really get familiar with coding in Python (or any other language), the best way is to **write a lot of code**.  
We recommend working through a problem set to practice some more with coding in Python. The problem set will also cover some of the basics we covered in a bit more detail. We expect the problem set won't take longer than ~1-2 hrs to complete.

You can find the problem set at this [Google CoLab Document](https://colab.research.google.com/drive/1zJQIp-LbaK9K8Y6FbCAKVSGZA-kxJca7#scrollTo=2c08df7c-86a5-430c-95a3-a90719c3f81d).  
CoLab works just like a Jupyter notebook, but it automatically saves your changes and keeps them as a cloud document.  
**To get started on the problem set, make sure to first <mark>click "File" > "Save a copy in Drive"</mark> to make sure you don't lose your progress!**

We'll have AUG office hours next week for you to stop by and work on your problem set with other Arcadians as well as to work through any bugs in your code.  
If you're stumped, we also have an [Answer Key](https://github.com/Arcadia-Science/arcadia-computational-training/blob/main/docs/arcadia-users-group/20230228-intro-to-python-1/problem_set_1_answers.ipynb) that you can check.

Feel free to ping the `#software-questions` Slack channel for anything that comes up in the meantime!
