---
title: Overview of Jupyter Notebooks
---

![Example Jupyter Notebook](../fig/00_0_jupyter_notebook_example.jpg)
*Screenshot of a [Jupyter Notebook on quantum mechanics](https://github.com/jrjohansson/qutip-lectures) by Robert Johansson*

## Jumping in with Jupyter notebooks

We'll start today's tutorial using a Binder installation of jupyter notebook in the cloud.
After we take a tour of jupyter notebooks, we'll learn how to install and interact with them on our local computers.

Click the button below to launch a jupyter notebook through [binder](https://mybinder.org/).

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/arcadia-science/arcadia-computational-training/main)

This will launch a computer in the cloud.
You'll interact with this computer through your browser.
Click the Terminal button to launch a Terminal that we will work with for the rest of the lesson.

![](../20220906-intro-to-shell1/jupyterhub.png)

<details>
  <summary>More information on binder and what happens when you click the launch binder button.</summary>

Binder is a service that turns a Git repo into a collection of interactive notebooks. 
When a repository is configured to run as a binder, passing the GitHub repository URL to binder starts the binder-building process.
Binder first builds a docker image that contains all of the software installations specified by a special set of files in the GitHub repository.
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

### Jupyter notebook vs. JupyterLab

Technically, our entry point for this tutorial is JupyterLab.
JupyterLab is the next-generation user interface that includes notebooks.
For an in depth comparison between Jupyter notebooks and JupyterLab, see [this article](https://medium.com/analytics-vidhya/why-switch-to-jupyterlab-from-jupyter-notebook-c6d98362945b).

![](nbvslab.png) 



### How the Jupyter notebook works

After typing the command `jupyter notebook`, the following happens:

* A Jupyter Notebook server is automatically created on your local machine.
* The Jupyter Notebook server runs locally on your machine only and does not
  use an internet connection.
* The Jupyter Notebook server opens the Jupyter notebook client, also known
  as the notebook user interface, in your default web browser.

  ![Jupyter notebook file browser](../fig/00_1_jupyter_file_browser.png)
  *The Jupyter notebook file browser*

* To create a new Python notebook select the "New" dropdown on the upper
  right of the screen.

  ![Jupyter notebook file browser](../fig/00_2_jupyter_new_notebook.png)
  *The Jupyter notebook file browser*

* When you can create a new notebook and type code into the browser, the web
  browser and the Jupyter notebook server communicate with each other.

  ![new Jupyter notebook](../fig/00_3_jupyter_blank_notebook.png)
  *A new, blank Jupyter notebook*

* Under the "help" menu, take a quick interactive tour of how to
  use the notebook. Help on Jupyter and key workshop packages is
  available here too.

  ![Jupyter tour and help](../fig/00_4_jupyter_tour_help.png)
  *User interface tour and Help*

* The Jupyter Notebook server does the work and calculations, and the web
  browser renders the notebook.
* The web browser then displays the updated notebook to you.

* For example, click in the first cell and type some Python code.

  ![Code cell](../fig/00_5_jupyter_code_before.png)
  *A Code cell*

* This is a **Code** cell (see the cell type dropdown with the word **Code**).
  To run the cell, type <kbd>Shift</kbd>+<kbd>Return</kbd>.

  ![Code cell and its output](../fig/00_6_jupyter_code_after.png)
  *A Code cell and its output*

* Let's look at a **Markdown** cell. Markdown is a text manipulation
  language that is readable yet offers additional formatting. Don't forget
  to select **Markdown** from the cell type dropdown. Click in the cell and
  enter the markdown text.

  ![markdown input cell](../fig/00_7_jupyter_markdown_before.png)
  *A markdown input cell*

* To run the cell, type <kbd>Shift</kbd>+<kbd>Return</kbd>.

  ![rendered markdown cell](../fig/00_8_jupyter_markdown_after.png)
  *A rendered markdown cell*

This workflow has several advantages:

- You can easily type, edit, and copy and paste blocks of code.
- Tab completion allows you to easily access the names of things you are using
  and learn more about them.
- It allows you to annotate your code with links, different sized text,
  bullets, etc. to make information more accessible to you and your
  collaborators.
- It allows you to display figures next to the code that produces them
  to tell a complete story of the analysis.

### How the notebook is stored

The notebook file is stored in a format called JSON and has the suffix `.ipynb`.
Just like HTML for a webpage, what's saved in a notebook file looks different from what you see in your browser.
This format allows Jupyter to mix software (in several languages) with documentation and graphics, all in one file.

### Viewing and interacting with jupyter notebooks

While jupyter notebooks are saved in a plain text file in JSON format, the files themselves are quite large (often exceeding a megabyte).
This text-rich format isn't very rewarding to look at it in its raw format.
Historically, one needed to use `jupyter notebook` to open, view (render), and execute a jupyter notebook.
This could be a heavy lift when you wanted to share a notebook with collaborators.
This is probably still the most popular way to interact with notebooks but there are now lighter weight alternatives.

**Viewing and interacting with jupyter notebooks.**
To view a jupyter notebook, you can use any of the following strategies.
1. Use a local installation of jupyter notebook or jupyter hub to open the notebook in your browser. You'll have full functionality of the notebook with this strategy.
2. Use VS Code to open and render the notebook. You'll still need jupyter installed locally for this to work, and you'll have full functionality of the notebook but it will be rendered directly in VS Code.

**Only viewing jupyter notebooks.**
If your goal is view the notebook, or allow others to view the notebook, you can use the following strategies.
1. Export the notebook to html, markdown, or PDF. You can then share the file with others who would like to view it.
2. Upload the notebook to a GitHub repository. GitHub will automatically render the notebook, allowing others to view it without having to download it and use a local installation of jupyter notebook to open it.
3. You can use [nbviewer](https://nbviewer.org/) or other third party applications that render and distribute jupyter notebooks. 
### Notebook modes: Control and Edit

The notebook has two modes of operation: Control and Edit. Control mode lets
you edit notebook level features; while, Edit mode lets you change the
contents of a notebook cell. Remember a notebook is made up of a number of
cells which can contain code, markdown, html, visualizations, and more.

### Help and more information

Use the **Help** menu and its options when needed.

### Executing shell commands in a jupyter notebook

To execute a line of bash code in a python jupyter notebook, prepend the line of code with an `!`:
```
!ls
```

## Running jupyter notebooks locally: installation and startup

### Managing jupyter notebook installations with conda

### Setting up an R kernel to run R code in a jupyter notebook

