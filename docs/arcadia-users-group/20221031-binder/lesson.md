# Turning a GitHub repo into a collection of interactive notebooks with Binder

A Binder (also called a Binder-ready repository) is a code repository that contains at least two things:

1. Code or content that you’d like people to run. This might be a Jupyter Notebook that explains an idea, or an R script that makes a visualization.
2. Configuration files for your environment. These files are used by Binder to build the environment needed to run your code. For a list of all configuration files available, see the [Configuration Files page](https://mybinder.readthedocs.io/en/latest/using/config_files.html#config-files).

A Binder repository can be built by a BinderHub, which will generate a link that you can share with others, allowing them to interact with the content in your repository.
[mybinder.org](https://mybinder.org/) and [pangeo-binder](https://hub.aws-uswest2-binder.pangeo.io/hub/login?next=%2Fhub%2Fapi%2Foauth2%2Fauthorize%3Fclient_id%3Dauth0%26redirect_uri%3Dhttps%253A%252F%252Faws-uswest2-binder.pangeo.io%252Foauth_callback%26response_type%3Dcode%26state%3DeyJ1dWlkIjogIjA1NTM1MTk4YmZlYTQ0NmVhMDhkZDU0NGYwZTlhNzAyIiwgIm5leHRfdXJsIjogIi8ifQ) are two free online BinderHubs that build the shareable reproducible and interactive computational environments from binder-compatible online repositories.

In this lesson, we will create a Binder project from scratch: we will first make a repository on GitHub and then launch it on mybinder.org.
This lesson will tie together pieces from all of our previous lessons. 
We'll use our new knowledge about the command line, Git and Github, conda, markdown, jupyter notebooks, and reproducible computing in general.

## Creating a Binderize-able python repository

> Interested in creating a Binder repo for a different language (like R or Julia)?
> See this [lesson](https://the-turing-way.netlify.app/communication/binder/zero-to-binder.html).

We'll start by creating a python Binder repository on GitHub.

1. Create a new repo on GitHub called 2022-my-py-binder
    * Make sure the repository is **public**, not private
    * Initialize the repo with a README
2. Create a file called `hello.py` via the web interface with `print("Hello from Binder!")` on the first line and commit to the main branch

> **Why does the repo have to be public?** [mybinder.org](https://mybinder.org) cannot access private repositories as this would require a secret token. 
> The Binder team choose not to take on the responsibility of handling secret tokens as mybinder.org is a public service and proof of technological concept. 
> If accessing private repositories is a feature you/your team need, you can look into building your own BinderHub.

## Launching your Binderized repository on [mybinder.org](https://mybinder.org)

1. Go to **<https://mybinder.org>**
2. Type the URL of your repo into the "GitHub repo or URL" box.
   It should look like this:
   > **https://github.com/YOUR-USERNAME/2022-my-py-binder**`
3. As you type, the webpage generates a link in the "Copy the URL below..." box
   It should look like this:
   > **https://mybinder.org/v2/gh/YOUR-USERNAME/2022-my-py-binder/HEAD**
4. Copy it, open a new browser tab and visit that URL
   - You will see a "spinner" as Binder launches the repo

If everything ran smoothly, you'll see a JupyterLab interface.

**What happens when you launch a Binder?**
In the background, BinderHub (the backend of Binder) fetches your repo from GitHub and analyzes the contents of the files in the repo.
It then builds a docker image based on your repo and launches the docker image in the cloud.
Lastly, BinderHub connects you to the instance running the docker image via your browser.

## Interacting with files in Binder

The Binder environment is fully executable. 
Let's execute our python script from the command line.
Click the `Terminal` button to open the Terminal app, then run:

```
python hello.py
```

`Hello from Binder!` should be printed to the terminal.

## Building out the environment and pinning dependencies

By including a `.py` file in our repository, BinderHub knew that we wanted to launch a Binder with python installed.
We can provide more explicit instructions to customize the installation experience.
We'll do this using conda because conda allows us to install python, R, ... dependencies.

The `environment.yml` is the standard configuration file used by conda that lets you install any kind of package, including Python, R, and C/C++ packages.
BinderHub will use this file to update the `base` conda environment with the packages listed in your `environment.yml` -- it does _not_ create and activate a new conda environment. 
This means that the environment will always have the same default name, not the name specified in your `environment.yml`.

You can install files from pip in your environment.yml as well. 
For example, see the [binder-examples `environment.yml` file](https://github.com/binder-examples/python-conda_pip/blob/HEAD/environment.yml).

We'll start by creating an `environment.yml` and pinning a dependency.

* In your repo, create a file called `environment.yml`
* Add the following lines:
```
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - numpy=1.14.5
```
* Check for typos! Then commit to the main branch
* Visit <https://mybinder.org/v2/gh/YOUR-USERNAME/2022-my-py-binder/HEAD> again in a new tab

This time, BinderHub will read the configuration file you added and install the specific version of the package you requested using conda.

## Using dependencies in the notebook environment

1. From the launch panel, select "Python 3" from the Notebook section to open a new notebook
2. Type the following into a new cell and run it with <kbd>Shift</kbd>+<kbd>Enter</kbd> 
```
import numpy
print(numpy.__version__)
numpy.random.randn()
```

> **If you save this notebook, it will not be saved to the GitHub repo.** 
Pushing changes back to the GitHub repo through the container is not possible with Binder. 
Any changes you have made to files inside the Binder will be lost once you close the browser window.

## Sharing your Binder with others


Binder is all about sharing your work easily and there are two ways to do it:

1. Share the **https://mybinder.org/v2/gh/YOUR-USERNAME/2022-my-py-binder/HEAD** URL directly
2. Visit **<https://mybinder.org>**, type in the URL of your repo and copy the Markdown or ReStructured Text snippet into your `README.md` file.
  This snippet will render a badge that people can click, which looks like this: ![Binder](https://mybinder.org/badge_logo.svg)
3. Add the **Markdown** snippet from **<https://mybinder.org>** to the `README.md` file in your repo. 
The grey bar displaying a binder badge will unfold to reveal the snippets.
Click the clipboard icon next to the box marked with "m" to automatically copy the Markdown snippet.
4. Click the badge to make sure it works!

## Accessing data from Binder

Another kind of dependency for projects is **data**.
There are different ways to make data available in your Binder depending on the size of your data and your preferences for sharing it.

**Small public files.**
The simplest approach for small, public data files is to add them directly into your GitHub repository.
They are then directly encapsulated into the environment and versioned along with your code.
This is ideal for files up to **10MB**.

**Medium public files.**
To access medium files **from a few 10s MB up to a few hundred MB**, you can add a file called `postBuild` to your repo.
A `postBuild` file is a shell script that is executed as part of the image construction and is only executed once when a new image is built, not every time the Binder is launched.
See [Binder's `postBuild` example](https://mybinder.readthedocs.io/en/latest/using/config_files.html#postbuild-run-code-after-installing-the-environment) for more uses of the `postBuild` script.

**Large public files.** 
It is not practical to place large files in your GitHub repo or include them directly in the image that Binder builds.
The best option for large files is to use a library specific to the data format to stream the data as you're using it or to download it on demand as part of your code.
For security reasons, the outgoing traffic of your Binder is restricted to HTTP/S or GitHub connections only. You will not be able to use FTP sites to fetch data on mybinder.org.

### Get data with `postBuild`

1. Go to your GitHub repo and create a file called `postBuild`
2. In `postBuild`, add a single line reading: `wget -q -O gapminder.csv http://bit.ly/2uh4s3g`
`wget` is a program which retrieves content from web servers.
This line extracts the content from the bitly URL and saves it to the filename denoted by the `-O` flag (capital "O", not zero), in this case `gapminder.csv`.
The `-q` flag tells `wget` to do this quietly, meaning it won't print anything to the console.
3. Update your `environment.yml` file by adding a new line with `pandas` on it and another new line with `matplotlib` on it. These packages aren't necessary to download the data but we will use them to read the CSV file and make a plot.
4. Click the binder badge in your README to launch your Binder

Once the Binder has launched, you should see a new file has appeared that was not part of your repo when you clicked the badge.

Now visualise the data by creating a new notebook (selecting "Python 3" from the Notebook section) and run the following code in a cell.

```python
%matplotlib inline

import pandas

data = pandas.read_csv("gapminder.csv", index_col="country")

years = data.columns.str.strip("gdpPercap_")  # Extract year from last 4 characters of each column name
data.columns = years.astype(int)              # Convert year values to integers, saving results back to dataframe

data.loc["Australia"].plot()
```

## Attributions

This lesson was modified in part from the following sources:

* [Binder user guide](https://mybinder.readthedocs.io/en/latest/introduction.html)
* The Turing Way [Zero-to-Binder](https://the-turing-way.netlify.app/communication/binder/zero-to-binder.html) ([license](https://creativecommons.org/licenses/by/4.0/)).
