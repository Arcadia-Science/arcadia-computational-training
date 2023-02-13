# Introduction to Python, Part 2

---
## 0. Loops and Conditionals

This lesson is the second in a series of workshops that provide an introduction to programming using Python.

**This lesson** builds on the foundation of lesson 1 and covers:
- lists and dictionaries
- methods
- loops
- booleans
- conditional expressions

---
## 1. Data structures

Often, when you're working with values in science, you're not just working with `x = 1` and `y = 2`, but instead with large amounts of data. Python offers a variety of data structures that aggregate data, including:

- `list`s: ordered arrays of values.
- `dict` or dictionaries: values ordered with key-value pairs.
- `set`s: like lists, but each value can only occur once.
- `tuple`s: like lists, but you can't modify the values.

We'll first talk about `list` and `dict` structures, as they're the easiest and most intuitive to understand.

---
### 1.1 Lists
You can create a `list` in Python using bracket notation, such as below.


```python
lst = [1, 2, 3, 4, 5]
```

To access a specific value in the list, such as `2`, you use the **index**, or the position of the value in the list, in bracket notation, as below.

A key thing to remember in Python is that **lists are indexed starting with the index `[0]`**. So, if you wanted to get the value `2` from the list above, you would use an the index `[1]`.


```python
lst[1]
```




    2



Lists are powerful because you can do **many** different operations with them using built-in functionality. For example, you can slice lists to get only specific elements using the colon operator `:`.

To get the first through third elements of a list, you would use the following notation:


```python
lst[0:3]
```




    [1, 2, 3]



Note that, in the above example, the elements are extracted with a 'left-included, right-excluded' notation - the *fourth* element in the list, `4`, at index `3`, is not included.

You can slice and index lists in some pretty interesting ways, such as in the examples below:


```python
lst = [0, 1, 2, 3, 4, 5, 6, 7, 8]

# The below expression is equivalent to lst[0:3].
# It gives you everything from the start of the list up to the ending address.
print(lst[:3])

# The below expression gives you the last element in the list.
print(lst[-1])

# The below expression gives you the last two elements in the list.
print(lst[-2:])
```

    [0, 1, 2]
    8
    [7, 8]


Note that accessing a slice of a `list` returns a list, whereas accessing a single element returns the value itself.

---
### 1.2 List Methods

Many data types in Python have special functions built-in to their data type. These special functions are called **methods** and are accessed using a dot operator, or period (`.`). For example, you can add new elements to a list using the `.append()` method.


```python
fruit_trees = ['apple', 'orange', 'peach', 'pear', 'cherry']
print(fruit_trees)

new_fruit = 'coconut'

fruit_trees.append(new_fruit)

print(fruit_trees)
```

    ['apple', 'orange', 'peach', 'pear', 'cherry']
    ['apple', 'orange', 'peach', 'pear', 'cherry', 'coconut']


There are many different list methods. You can take a look at some of them at the [Python documentation page](https://docs.python.org/3/tutorial/datastructures.html).

### 1.3 List indexing tricks

You can actually apply list indexing to certain other data types, such as `str`.  
`str` objects can be treated like lists, where each character is an element of the list. For example:


```python
fruit = 'pineapples'

print(fruit[0:4])
print(fruit[-1])
```

    pine
    s


---
### 1.4 Dictionaries

Dictionaries are another data structure in Python, which allows for assigning a `key` to each `value` in the structure. Dictionaries are created using specific curly brace `{}` notation as below:


```python
# Dictionaries are instantiated using curly braces.
# Each key-value pair in the dictionary is assigned using the notation:
##  'key': 'value'
# Entries are separated using commas.

favorite_fruits = {'Anabelle': 'peach', 'Becky': 'pear', 'Cole': 'coconut'}

print(favorite_fruits)
```

    {'Anabelle': 'peach', 'Becky': 'pear', 'Cole': 'coconut'}


To access the value in a dictionary, you index by the `key`.

This returns the `value` assigned to that `key`.


```python
favorite_fruits['Anabelle']
```




    'peach'



Sometimes you might want just the keys or the values in your dictionary.  
You can access those with the `.keys()` and `.values()` methods.


```python
villagers = favorite_fruits.keys()
print(villagers)

fruits = favorite_fruits.values()
print(fruits)
```

    dict_keys(['Anabelle', 'Becky', 'Cole'])
    dict_values(['peach', 'pear', 'coconut'])


These methods return special types of data structures: `dict_keys` and `dict_values`.  
It's important to note that these are _not_ `list`s, and operations or methods that you can normally perform on lists might not work on these data structures.  

However, you can always use typecasting to coerce `dict_keys` and `dict_values` structures into `list` format.


```python
list(villagers)
```




    ['Anabelle', 'Becky', 'Cole']



---
## 2. Loops

Often when working with scientific data, you might want to apply the same set of transformations to many different samples. You can repeat a process in Python and other programming languages using **loops**.

---
### 2.1 **`for`** loops

A basic example of this approach is the **`for`** loop.  

Let's say you had a bunch of different samples with different ID numbers, and you wanted to create a sample name as a string for each. You could take the following approach and manually do that transformation:


```python
sample_ids = [100, 231, 572]

sample_1 = 'sample_' + str(sample_ids[0])
sample_2 = 'sample_' + str(sample_ids[1])
sample_3 = 'sample_' + str(sample_ids[2])

print(sample_1, sample_2, sample_3)
```

    sample_100 sample_231 sample_572


A faster way to do this would be to use a **`for`** loop.

The **`for`** loop will repeat for every element in a list, as below:


```python
for i in [0, 1, 2]:
    print('Ha')
```

    Ha
    Ha
    Ha


You can combine a **`for`** loop with your data structure to be able to iterate through your list, as follows:


```python
sample_ids = [100, 231, 572]
sample_names = []

for i in [0, 1, 2]:
    sample_name = 'sample_' + str(sample_ids[i])
    sample_names.append(sample_name)
    
print(sample_names)
```

    ['sample_100', 'sample_231', 'sample_572']


The example code above differs from our first attempt in several ways.  
Let's walk through what each of these changes is doing:
- **We created an empty `sample_names` list.**  
    Rather than creating a new variable for each sample name we're creating, we can store those values in a list that mirrors our `sample_ids` list.  
    We create this empty list so that we have somewhere to put the new strings we're generating. We add those new values to the empty list using the `.append()` method.
    
- **We used a `for` loop to iterate through the original list.**  
    In the original example, we manually added the string `'sample_'` and converted the `int` from sample_ids to a `str`. We accessed the values in `sample_ids` using the explicit index at each position, e.g. `[0]`, `[1]`, `[2]`.  
    In the revised code, we instead use the **`for`** loop to do that tedious work for us. The loop assigns a variable `i` to a list of values, `[0, 1, 2]`. Every time the loop runs, it replaces the variable `i` in our code with one of the values in the list, in that exact order.
    
Hopefully you can see from this example how loops can help us automate repetitive processes. This also helps our code become much more readable.

---
### 2.2 Implicit iteration

In a lot of programming languages, looping requires you to create a separate list of elements that are used for iteration, as in the previous example.  

Python actually has a more helpful way of looping over elements - rather than creating a separate list, you can simply iterate over the list you care about. See the example below, where we want to print out the elements in the list `vegetables`:


```python
vegetables = ['pumpkin', 'potato', 'tomato']

for veg in vegetables:
    print(veg)
```

    pumpkin
    potato
    tomato


In the case above, instead of an arbitrary list `[0, 1, 2]`, we use the specific `vegetables` list we'd like to iterate across. Instead of the variable `i`, we create a different variable, `veg`, which takes on the value of each element of `vegetables` in each iteration of the loop.

When iterating in this way, it's usually helpful to have a more explicit name such as `veg` than an unintuitive name such as `i`, as it helps contextualize what you're doing.

---
### 2.3 Loops using `dict`s

In addition to iterating through loops using `list` data structures, we can also use `dict`s. You can understand some of the behavior of how this iteration happens using the example below:


```python
favorite_vegetables = {'Marko': 'pumpkin', 'Charlene': 'potato', 'Stu': 'tomato'}

for entry in favorite_vegetables:
    print(entry)
```

    Marko
    Charlene
    Stu


You'll notice that iterating using a **`for`** loop across a dictionary iterates over the `key`s of that dictionary.

If you wanted to access both the key and the value in the dictionary, you can use the `.items()` method of a `dict` data structure.


```python
for villager, veg in favorite_vegetables.items():
    print(villager + "'s favorite vegetable is", veg + '.')
```

    Marko's favorite vegetable is pumpkin.
    Charlene's favorite vegetable is potato.
    Stu's favorite vegetable is tomato.


Rather than using a single variable such as `entry`, because `.items()` returns two values for every entry in the dictionary, we can unpack those paired values into two separate variables: `villager`, and `veg`.

---
### 2.4 **`while`** loops

Another type of helpful loop in Python is the **`while`** loop. Unlike the **`for`** loop, which requires you to explicitly state what you're iterating over, a **`while`** loop continues as long as a conditional statement is `True`. For example:


```python
a = [0, 1, 2, 3, 4]
i = 0

while a[i] < 3:
    print(a[i])
    i += 1    # The += operator adds the value on the right and updates the original variable.
```

    0
    1
    2


In the above example, there are a number of different things happening.  
Prior to the loop, we specify a variable `i`. At the end of each entry in the loop, we increment `i` by 1 in order to step through the list `a`.

How do we know when to stop? Take a look at the **`while`** statement:
```python
while a[i] < 3:
```
This means that as long as the entry at index `[i]` in list `[a]` is less than 3, we continue through the loop, printing the value of `a[i]`.

As soon as we arrive at `i = 3`, at the top of the **`while`** loop, we get the value `a[i] = 3`, which is NOT less than `3`. Therefore, the **`while`** loop terminates, and the value `3` is never printed.

**`while`** loops can be very powerful for a class of Python functions that rely on recursion, but you can also easily end up writing functions that "hang", or run forever without stopping.

## P1. Practice

Let's explore lists, dictionaries, and loops.

> ### Practice 1
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

greeting = 'Bonjour'
name = 'Jacques'

greetings(greeting, name)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[18], line 13
         10 greeting = 'Bonjour'
         11 name = 'Jacques'
    ---> 13 greetings(greeting, name)


    NameError: name 'greetings' is not defined


> ### Practice 4
> What happens if you pass the variable `x` below to your `greetings()` function?
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

    NameError                                 Traceback (most recent call last)

    Cell In[19], line 12
          1 ###############################################
          2 # Write your new function in the space below. #
          3 #### Then run the cell to check your work. ####
       (...)
          7 
          8 ###############################################
         10 robot_name = 120
    ---> 12 greetings(greeting, robot_name)


    NameError: name 'greetings' is not defined



```python

```

---
## 3. Booleans

In the previous lesson, we covered some basic data types such as `int`, `float`, and `str`. In this lesson, we've also covered data structures such as `list` and `dict`. One major data type that we haven't yet discussed is the `bool`, or Boolean.

`bool` values are `True` or `False` and are crucial to a lot of what gives programming languages power and flexibility to manage different types of scenarios.

`bool` values also have their own specific **operands** which can be used to build logic into our code. You can see some examples in the code below.

---

### 3.1 Equal

To check if two values are equivalent, you can use the `==` operand.  
This evaluates to `True` if the two values are equal and `False` if they are not.


```python
print(1 == 1)

print(1 == '1')

x = 'apple'
print(x == 'apple')
```

    True
    False
    True


### 3.2 Not Equal

The opposite of the `==` operand is the `!=` operand, which returns `True` if the values are NOT equal.



```python
print(1 != 1)

print(1 != '1')
```

    False
    True


### 3.3. Greater Than or Less Than

You can also perform comparison between two values using expressions such as `>`, `<`, `>=`, and `<=`.


```python
print(1 < 2)

print(1 > 2)

print(2 <= 2.0)
```

    True
    False
    True


### 3.4 **`and`** and **`or`**

You can also chain together boolean expressions using the operands **`and`** and **`or`**.
- The **`and`** operator only returns `True` if BOTH of the elements are `True`.
- the **`or`** operator returns `True` if EITHER of the elements are `True`.


```python
print(1 == 1 and 2 == 2)

print(1 == 1 or 2 == 3)
```

    True
    True


### 3.5 **`not`**

The **`not`** operand gives the inverse of a boolean expression.


```python
print(not (1 == 1 and 2 == 2))
```

    False


### 3.6 Checking membership with **`in`**

The **`in`** operand searches for values in data structures such as `list` or `dict`.  
It can also be used to search for substrings within `str`.


```python
pasture = ['sheep', 'sheep', 'sheep', 'wolf', 'sheep', 'sheep']

print('wolf' in pasture)

sentence = 'The quick brown fox jumped over the lazy dog.'

print('dog' in sentence)
print('monkey' in sentence)
```

    True
    True
    False


These Boolean operations are *crucial* to the logic that underpins programming. They are also the backbone of conditional expressions, which allow us to have a Python script make decisions.

---
## 4. Conditional expressions

When working with data, you don't always want to perform the same transformations to every feature of the data. Sometimes, you want to select only specific aspects of the data and manipulate those. Using boolean expressions, we can generate conditional code.

For example, we could determine whether a value falls within a specific range using an `if` statement.

### 4.1. **`if`** this, **`else`** that

We can use **`if`** statements to choose how Python will proceed, as in the example below.


```python
value = 10

if value <= 7:
    print('Value is less than or equal to 7.')
elif value > 7 and value < 12:
    print('Value is between 7 and 12.')
else:
    print('Value is greater than 12.')
```

    Value is between 7 and 12.


In the example above, you can see the three major types of conditional expressions associated with an **`if`** statement:
- **`if`**: If this expression evaluates as True, do the thing in the first indented block.
- **`elif`**: If the **`if`** statement is False, and this is True, do the thing in the second indented block.
- **`else`**: If all other **`if`** and **`elif`** statements are false, do the thing in the last indented block.

### 4.2 Bringing it all together

The above example might seem a bit silly, because we can already tell in advance where `10` is relative to `7` and `12`.  

But you could also write this code in a different way to be able to set the values of the high and low bar.


```python
value = 10

upper = 18
lower = 10

if value <= lower:
    print(value, 'is less than or equal to', str(lower) + '.')
elif value > lower and value < upper:
    print(value, 'is between', str(lower), 'and', str(upper) + '.')
else:
    print(value, 'is greater than', str(upper) + '.')
```

    10 is less than or equal to 10.


You could make this code more reusable by turning it into a function.


```python
def goldilocks(upper, lower, value):
    if value <= lower:
        print(value, 'is less than or equal to', str(lower) + '.')
    elif value > lower and value < upper:
        print(value, 'is between', str(lower), 'and', str(upper) + '.')
    else:
        print(value, 'is greater than', str(upper) + '.')
    return None

value = 10
upper = 30
lower = 5

goldilocks(upper, lower, value)
```

    10 is between 5 and 30.


And, if you combined this function call with a **`for`** loop, you could easily apply the same function to a variety of different numbers.


```python
values = [5, 6, 10, 30, 60, 1]
upper = 20
lower = 7

for value in values:
    goldilocks(upper, lower, value)
```

    5 is less than or equal to 7.
    6 is less than or equal to 7.
    10 is between 7 and 20.
    30 is greater than 20.
    60 is greater than 20.
    1 is less than or equal to 7.


### 4.3 Doing nothing

Sometimes, when combining a conditional and a loop, you want the loop to do nothing at all.  
In this specific situation, you can force a loop to **`continue`**.

For example, let's say you had a list of names and wanted to add a number to only the ones beginning with `'C'` and return those.


```python
names = ['Celine', 'Britney', 'Stefani', 'Rina', 'Charli', 'Billie']
output = []

for name in names:
    if name[0] == 'C':
        output.append(name + '_01')
    else:
        continue

print(output)
```

    ['Celine_01', 'Charli_01']


### 4.4 Other conditional statements

There are other types of conditional statements in Python which you'll encounter less frequently, but can still be very helpful:

- **`try`** **`except`** **`finally`**: tries to do something, unless it returns an error. If an error occurs, runs the **`except`** statement. at the end of each attempt, do a thing.


```python
values = ['a', 1, 3, '5', 'q', 3.0]

for value in values:
    try:
        print(value / 3)
    except TypeError:
        print("Cannot divide - wrong value type.")
    finally:
        print("---")
```

    Cannot divide - wrong value type.
    ---
    0.3333333333333333
    ---
    1.0
    ---
    Cannot divide - wrong value type.
    ---
    Cannot divide - wrong value type.
    ---
    1.0
    ---


- **`match`** **`case`**: works very similarly to an if - elif - else statement, but can be much easier to read when you have specific expected outcomes. See example [here](https://learnpython.com/blog/python-match-case-statement/).

> **NOTE:** match - case statements are still very new to Python 3.10, so Jupyter doesn't have syntax highlighting for them yet.

- **`with`** `open()`: used for opening files. We'll cover this in lesson 3!

---
## 5. Problem Set

With a wealth of data types, functions, loops, and conditional expressions at your disposal, you can accomplish **many** different computations using Python.  

This week's problem set features several open-ended problems that you can solve in many different ways.  
Some will revisit and revise the code you wrote in Problem Set 1.  
Hopefully you'll be able to write some fun and interesting code and feel empowered by Python programming!

You can find the problem set at this [Google CoLab Document](https://colab.research.google.com/drive/16UsMDgDffCj2fxdLp0MMEG7yRDxPfNNV?usp=sharing).  
CoLab works just like a Jupyter notebook, but it automatically saves your changes and keeps them as a cloud document.  
**To get started on the problem set, make sure to first <mark>click "File" > "Save a copy in Drive"</mark> to make sure you don't lose your progress!**

We'll have office hours throughout the week for you to stop by and work on your problem set with other Arcadians as well as to work through any bugs in your code.


```python

```
