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

## Attributions

This lesson was modified in part from the following sources:

* [Binder user guide](https://mybinder.readthedocs.io/en/latest/introduction.html)
* The Turing Way [Zero-to-Binder](https://the-turing-way.netlify.app/communication/binder/zero-to-binder.html) ([license](https://creativecommons.org/licenses/by/4.0/)).
