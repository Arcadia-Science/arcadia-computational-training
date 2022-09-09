# Introduction to shell part 2

In the [previous lesson](../20220906-intro-to-shell1/lesson.md), we introduced the concept of the Unix shell, showed how to navigate the shell, and introduced the commands `head`, `tail`, `pwd`, `ls`, and `cd`.
In this lesson, we'll cover how to create and delete directories (folders), how to move, copy, and delete files, and how to search the contents of a file more systematically.

## Accessing the shell for this lesson

For this lesson, we need to have access to a Unix shell. 
Click the button below to launch a shell through [binder](https://mybinder.org/).

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/arcadia-science/arcadia-computational-training/main)

This will launch a computer in the cloud.
You'll interact with this computer through your browser.
Click the Terminal button to launch a Terminal that we will work with for the rest of the lesson.

![](../20220906-intro-to-shell1/jupyterhub.png)

<details>
  <summary><b>More information on binder and what happens when you click the launch binder button.</b></summary>

Binder is a service that turns a Git repo into a collection of interactive notebooks. 
When a repository is configured to run as a binder, passing the GitHub repository URL to binder starts the binder-building process.
binder first builds a docker image that contains all of the software installations specified by a special set of files in the GitHub repository.
A docker image is a set of instructions that are used to create a docker container.
A docker container is a runnable instance of a docker image -- it's an encapsulated computing environment that can be used to reproducibly install sets of software on diverse computers.
Armed with the docker container, binder launches an "instance" in the cloud (either on Google Cloud or AWS typically) on which it runs the docker container.
Binder does some additional work in the background -- if no software configuration files are provided in the GitHub repo, or if those contain a minimal set of software, binder will by default include JupyterHub in the docker.
When the cloud instance is launched, this is the screen you interact with.
You interact with the cloud instance  in your browser.
Binders are ephemeral instances -- after a period of inactivity, the instance is automatically shut down, and any work you have done will be lost.
You're able to download files from your work before the instance is shut down if you do want to save anything.


You may notice that this instance already has a bunch of files on it. 
And that these files look suspiciously exactly like the files in the GitHub repository <a href="https://github.com/arcadia-science/arcadia-computational-training">Arcadia-Science/arcadia-computational-training</a>.
That's because that's the repository we used to build the binder from. 
</details>

<br />

## Interrogating the content of files 

### Looking at whole files

As we learned in the previous lesson, we can investigate the beginning and end of a file using `head` or `tail`.
What if you want to see all of the contents of a file?
The command `cat` will print the contents of a file to `stdout` -- the standard output stream that prints to the shell.

Let's run `ls` and see what files we're working with.

```
ls 
```

And then look at the contents of `mkdocs.yml` using `cat`:

```
cat mkdocs.yml
```

We see the following content:

```
site_name: Arcadia Science Computational Training
site_url: http://arcadia-science.github.io/arcadia-computational-training
repo_name: arcadia-computational-training
repo_url: https://github.com/arcadia-science/arcadia-computational-training
edit_uri: ""

copyright: 'Copyright &copy; 2022 <a href="https://www.arcadiascience.com">Arcadia Science</a>'

# change directory names here to reflect directories in the repository
docs_dir: docs
site_dir: site

theme:
  name: lux

extra_css: 
    - css/extra.css

# organize site structure and give a title for each page
# paths are relative to the docs directory
nav:
    - "Home": "index.md"
    - "Arcadia Users Group": "arcadia-users-group/overview.md"
    - "Workshops": "workshops/overview.md"
    - "Contribute": "CONTRIBUTING.md"
```

<details>
  <summary><b>More information on YAML (<code>.yml</code>, <code>.yaml</code>) file formats.</b></summary>
<a href="https://yaml.org">YAML</a> originally stood for Yet Another Markup Language as it was originally developed and released around the same time as many other markup languages (HTML, etc).
Now, it stands for YAML Ain't A Markup Language.  
Unlike <a href="https://arcadia-science.github.io/arcadia-computational-training/arcadia-users-group/20220822-intro-to-markdown-syntax/lesson/">Markdown</a> which strives to be human-readable and parseable into pretty documents, YAML is a data-oriented.
YAML is a human-friendly data serialization language for all programming language.
It's a file format commonly used to specify configuration files.
Configuration files specify where a computer program can find files it needs, parameters for when the program runs, or other metadata for a program.
</details>

<br />
In this case, the output of the file is palatable; we can grok the whole files contents by printing it all to stdout.

Let's use `cat` on a longer file:

```
cat docs/arcadia-users-group/20220822-intro-to-markdown-syntax/lesson.md 
```

When we run this command, the output takes up more than we can see without scrolling.
If we were to run `cat` on a really long file, it may take seconds, minutes, or even hours to print all of the contents to the screen. 
Enter `less`.
`less` is a terminal pager that shows a file's contents one screen at a time.

```
less docs/arcadia-users-group/20220822-intro-to-markdown-syntax/lesson.md
```

This allows us to interactivley view the contents of a file. 
To navigate the lesson screen, we can use key board arrows (line-by-line navigation), the space bar (page jump), or even special combinations of keys (`GG` jumps to the bottom of the file). 
To exit out of `less`, press the `q` key.

### Looking for specific content in a file

Sometimes, we care less about all the things in a file and instead want to find something specific.
`grep` is a great command for this.
`grep` (**g**lobal **r**egular **e**x**p**ression) is a search tool. 
It looks through text files for strings (sequences of characters). 
In its default usage, `grep` will look for whatever string of characters you give it (1st positional argument), in whichever file you specify (2nd positional argument), and then print out the lines that contain what you searched for. 
Let's try it:

```
grep "Arcadia" mkdocs.yml
```

```
site_name: Arcadia Science Computational Training
copyright: 'Copyright &copy; 2022 <a href="https://www.arcadiascience.com">Arcadia Science</a>'
    - "Arcadia Users Group": "arcadia-users-group/overview.md"
```

We see `Arcadia` appears three times.

If we `grep` for a string that is not in the file, nothing will be printed to the screen:
```
grep "hippo" mkdocs.yml
```

### Figuring out how long a file is

Sometimes we care less about the specific contents of a file and instead we want a general overview of the contents of a file.
This can be helpful when you download a large file -- you may know the number of lines you expect to see inside of it. 
We can use the `wc` **w**ord **c**ount command to get a summary of the number of lines, words, and characters in a file.

```
wc mkdocs.yml
```

This file has 25 lines, 75 words, and 782 characters.
```
 25  75 782 mkdocs.yml
```

`wc` also accepts flags -- the `-l` flag limits the output of `wc` to only the number of lines in a file.
```
wc -l
```

The options below allow you to select which counts are printed.

* `-l`, `--lines` - print the number of lines.
* `-w`, `--words` - print the number of words.
* `-m`, `--chars` - print the number of characters.
* `-c`, `--bytes` - print the number of bytes.
* `-L`, `--max-line-length` - print the length of the longest line.

## Copying, moving, and renaming files

The commands **`cp`** and **`mv`** (**c**o**p**y and **m**o**v**e) have the same basic structure. 
They both require two positional arguments – the first is the file you want to act on, and the second is where you want it to go (which can include the name you want to give it). 


To see how this works, let's make a copy of "example.txt":

```
ls
cp mkdocs.yml mkdocs_copy.yml
ls
```

By giving the second argument a name and nothing else (meaning no path in front of the name), we are implicitly saying we want it copied to where we currently are. 

To make a copy and put it somewhere else, like in our subdirectory `docs`, we could change the second positional argument using a **relative path** ("relative" because it starts from where we currently are):

```
ls docs
cp mkdocs.yml docs/mkdocs_copy.yml
ls docs
```

To copy a file to that subdirectory but keep the same name, we could type the whole name out, but we can also provide the directory but leave off the file name:

```
cp mkdocs.yml docs/
ls docs/
```

If we wanted to copy something *from somewhere else to our current working directory* and keep the same name, we can use another special character, a period (**`.`**), which specifies the current working directory:

```bash
ls
cp docs/index.md .
ls
```

The **`mv`** command is used to move files. 
Let's move the `README.md` file into the `docs` subdirectory:

```
ls
ls docs/
mv README.md docs/
ls
ls docs/
```

The **`mv`** command is also used to *rename* files. 
This may seem strange at first, but remember that the path (address) of a file actually includes its name too (otherwise everything in the same directory would have the same path). 

```
ls
mv mkdocs_copy.yml mkdocs_new.yml
ls
```

To delete files there is the **`rm`** command (**r**e**m**ove). 
This command requires at least one argument specifying the file we want to delete. 
Typically, this command does not ask you to confirm your actions and files are permanently deleted instead of being moved to a `Trash` directory.

```
ls
rm mkdocs_new.yml
ls
```

## Creating and removing directories

We can make a new directory with the command **`mkdir`** (for **m**a**k**e **dir**ectory): 

```
ls
mkdir subset
ls
```

And similarly, directories can be deleted with **`rmdir`** (for **r**e**m**ove **dir**ectory):

```bash
rmdir subset/
ls
```

The command line is a little more forgiving when trying to delete a directory. 
If the directory is not empty, **`rmdir`** will give you an error. 

```bash
rmdir docs/
```

The `rm` command can also be used to delete a directory, but it needs the flags `-rf` added to.
`-r` stands for recursive (meaning delete all files and folders located within the specified directory), while the `f` stands for for force.
Unlike `rmdir`, this command will not check whether you want the directory deleted before removing it and it will remove a directory even if it isn't empty. 
It's good to get into the habit of mentally or actually checking where you are and what you're deleting before removing something with `rm -rf` as this command can delete A LOT of files very quickly if you enter the wrong thing.

```
mkdir subset
ls
rm -rf subset
```


## Summary

<h4><i>Commands introduced:</i></h4>

|**Command**     |**Function**          |
|:----------:|:------------------:|
|**`cat`** | prints the contents of a file to `stdout` |
|**`less`**| allows us to browse a file (exit with <kbd>q</kbd> key) |
|**`wc`** | count lines, words, and characters in a file |
|**`cp`** | copy a file or directory |
|**`mv`**| move or rename a file or directory |
|**`rm`**| delete a file or directory |
|**`mkdir`**| create a directory |
|**`rmdir`**| delete a directory |

<h4><i>Special characters introduced:</i></h4>

|**Characters**     |  **Meaning**  |
|:----------:|:------------------:|
| **`.`** | specifies the current working directory |

</center>

## Credits

This lesson was modified from the following sources:

* ANGUS 2019:
    * https://angus.readthedocs.io/en/2019/shell_intro/shell-six-glorious-commands-04.html
    * https://angus.readthedocs.io/en/2019/shell_intro/shell-working-02.html

