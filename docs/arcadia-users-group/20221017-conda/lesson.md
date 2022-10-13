# Introduction to conda for software installation and environment management

## Why should I use a package and environment management system?

**Package managers and why we use them.** 
A [package manager](https://en.wikipedia.org/wiki/Package_manager) is a software tool that automates the process of installing, upgrading, configuring, or removing software from your computer.
[Pip](https://pypi.org/project/pip/) (python), [BiocManager](https://cran.r-project.org/web/packages/BiocManager/vignettes/BiocManager.html) (Bioconductor R packages), and [APT](https://en.wikipedia.org/wiki/APT_(software)) (ubuntu) are three commonly encountered package managers. 
Package managers make installation software easier. 

**Environments and why we use them.** 
Environment managers address the problems created when software is installed system-wide.
System-wide installs create complex dependencies between disparate projects that are difficult to entangle to version compute environments and that can create dependcency conflicts. 
An environment is a directory that contains a specific collection of packages/tools that you have installed. 
An environment manager is a software tool that organizes where and how software is installed on a computer.
For example, you may have one environment with Python 2.7 and its dependencies, and another environment with Python 3.4 for legacy testing. 
If you change one environment, your other environments are not affected. 
You can easily activate or deactivate environments, which is how you switch between them. 

## What is Conda?

Conda is open source package and runs on Windows, Mac OS and Linux.

+ Conda can quickly install, run, and update packages and their dependencies.
+ Conda can create, save, load, and switch between project specific software environments on your local computer.

Conda as a package manager helps you find and install packages. 
If you need a package that requires a different version of Python, you do not need to switch to a different environment manager, because Conda is also an environment manager. 
With a few commands, you can set up a totally separate environment to run that different version of Python, while continuing to run a different version of Python in another environment.

## Installing Conda

<center>
<figure markdown>
  ![installingconda](installing_conda.png){ width="700" }
  <figcaption> Cartoon of decision points for conda installation by Gergely Szerovay <a href='https://www.freecodecamp.org/news/why-you-need-python-environments-and-how-to-manage-them-with-conda-85f155f4353c/' target='_blank'>www.freecodecamp.org</a> </figcaption>
</figure>
</center>

For this lesson, we'll install miniconda. 
We've included the latest installation instructions below.
You can access the latest and legacy installation links [here](https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links).

### Installing conda on an Apple machine

Apple now has two processor types, the Intel x64 and the Apple M1 (or M2) ARM64.
As of October 2022, many of the packages available via conda-forge and other conda installation channels are only available of the Intel x64 processor. 
Therefore, even if you have an M1 (or M2) Mac, we currently recommend that you use the Intel x64 installation and take advantage of Apple's translation program Rosetta. 
This requires a little bit of pre-configuration to make sure your Terminal application also runs with Rosetta.
To set this up, open **Finder** -> navigate to your **Applications** folder -> right click on your Terminal application (either Terminal or iTerm2) -> select **Get Info** -> check the box for **Open using Rosetta**.


  
### Installing conda on a Linux machine

## How does Conda work

<center>
<figure markdown>
  ![conda](conda.png){ width="700" }
  <figcaption> Cartoon of conda environments by Gergely Szerovay <a href='https://www.freecodecamp.org/news/why-you-need-python-environments-and-how-to-manage-them-with-conda-85f155f4353c/' target='_blank'>www.freecodecamp.org</a> </figcaption>
</figure>
</center>

## Benefits of Conda

<center><img src="_static/conda3.png" width="90%"></center>
<br>

## Installing & Activating Conda

We have already installed conda on these instances, but please see the [stellar conda documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/install/) after the class if you'd like to install it on your personal computer or elsewhere. 

## Adding a new environment

> If you need to re-access your terminal environment, [see here](jetstream/boot.html#ssh-secure-login).

Check your current version of python by exectuting `python --version`

To create a new environment named, for instance mynewenv (you can name it what ever you like), that includes, let’s say, a Python version 3.4., run:

```
conda create --name mynewenv
```

## Activating and leaving (deactivating) an environment

Inside a new Conda installation, the root environment is activated by default, so you can use it without activation.

In other cases, if you want to use an environment (for instance manage packages, or run Python scripts inside it) you need to first activate it.

```
conda activate mynewenv
```
The command prompt changes upon the environment’s activation, it now contains the active environment’s name.

The directories of the active environment’s executable files are added to the system path (this means that you can now access them more easily). You can leave an environment with this command:

```
conda deactivate
```

It needs to be mentioned that upon deactivating an environment, the base environment becomes active automatically.


## What are Conda channels?

Channels are the locations of the repositories (directories) online containing Conda packages. Upon Conda’s installation, Continuum’s (Conda’s developer) channels are set by default, so without any further modification, these are the locations where your Conda will start searching for packages.

Channels in Conda are ordered. The channel with the highest priority is the first one that Conda checks, looking for the package you asked for. You can change this order, and also add channels to it (and set their priority as well).

<center><img src="_static/conda4.png" width="90%"></center>
<br>

If multiple channels contain a package, and one channel contains a newer version than the other one, the order of the channels’ determines which one of these two versions are going to be installed, even if the higher priority channel contains the older version.


<center><img src="_static/conda5.png" width="90%"></center>
<br>

 Bioconda Channel

See the bioconda paper and the [bioconda web site](http://bioconda.github.io/)

Bioconda is a community-enabled repository of 3,000+ bioinformatics packages, installable via the conda package manager.
Note: bioconda is not available for windows systems

Add channels

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Searching, installing and removing packages

To list out all the installed packages in the currently active environment, run:

```
conda list
```

Try running a program pre-installed on this instance:

```
fastqc
```

To search for all the available versions of a certain package, you can use the search command. For instance, to list out all the versions of the seaborn package (it is a tool for data visualization), run:

```
conda search samtools
```

Similarly to the conda list command, this one results in a list of the matching package names, versions, and channels:

```
Loading channels: done
# Name                       Version           Build  Channel             
samtools                      0.1.12               0  bioconda            
samtools                      0.1.12               1  bioconda            
samtools                      0.1.12               2  bioconda            
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
samtools                         1.9      h91753b0_3  bioconda            
samtools                         1.9      h91753b0_4  bioconda            
samtools                         1.9      h91753b0_5  bioconda            
samtools                         1.9      h91753b0_8  bioconda  
```

To install a package (for samtools) that is inside a channel that is on your channel list, run this command (if you don’t specify which version you want, it’ll automatically install the latest available version from the highest priority channel):

```
conda install samtools
```

You can also specify the package’s version:
```
conda install samtools=1.9
```

### Freezing an environment

This will save the list of **conda-installed** software you have in a particular
environment to the file `packages.txt`:
```
conda list --export > packages.txt
```
(it will not record the software versions for software not installed by conda.)

```
conda install --file=packages.txt
```
will install those packages in your local environment.

### Conda Commands

| Conda commands | action |
| -------- | -------- |
| `conda install`     | install a package     |
| `conda list`     | list installed packages     |
| `conda search`     |   To search a package   |
| `conda info`     | list of information about the environment     |
| `conda list`     | list out all the installed packages in the currently active environment    |
| `conda remove`     | Remove a conda package     |
| `conda config --get channels`     | list out the active channels and their priorities     |
| `conda update`     | update all the installed packages     |
| `conda config --remove channels unwanted_channel` | remove unwanted_channel |
| `conda env list` | list the different environments you have set up | 
| `conda activate myNewEnvironment` | activate the myNewEnvironment Conda environment (this also works for activating our `base` environment |
| `conda info --envs` | list the locations of Conda directories |

## A note on the management Conda Environments
Conda environments are expceptionally useful! However, they can become quite large depending on how many packages we load into them. We can check how large any of our Conda enviroments are by finding the path to the environment directory and then estimating the file space usage of that directory.

First, let's find where we put out `mynewenv` directory
```
conda info --envs
```
This will print out a list of the locations of our Conda environments.

```
# conda environments:
#
base                  *  /opt/miniconda
mynewenv                 /opt/miniconda/envs/mynewenv
```

Next, let's use the command `du` to estimate the space our `mynewenv` directory is taking up!

```
du -sh /opt/miniconda/envs/mynewenv/
```

We can see our `mynewenv` environment is taking up about 12K of space. 

```
12K	/opt/miniconda/envs/mynewenv/
```

**QUESTION: How much space is your `base` environment taking up?**



## More Reading on Conda

+ Conda [Documentation](https://conda.io/en/latest/)

+ Image credits: Gergely Szerovay. Read original article [here](https://www.freecodecamp.org/news/why-you-need-python-environments-and-how-to-manage-them-with-conda-85f155f4353c/)

## A note about the conda ecosystem

Conda has truly been a gift to the scientific community, taking software installs that used to take days and bringing it down to minutes.
It also simplified versioning and environment management by integrating software encoded in many different languages into its ecosystem (python, R, perl, rust...).
It has therefore attracted contributions from many parties over the years that have lead to a diversity of modular pieces that participate in the conda ecosystem. 
This can be especially confusing for conda newcomers.
This section outlines many of the key pieces in the conda ecosytem to reduce confusion as people onboard to conda.

Conda itself is a piece of software that is a package and environment manager.
To get access to the conda software, you need to install it.
The most popular way to install conda is via miniconda or miniforge.
**[miniforge](https://github.com/conda-forge/miniforge)** is the community (conda-forge) driven minimalistic conda installer. 
By default, subsequent package installations come from conda-forge channel.
**[miniconda](https://docs.conda.io/en/latest/miniconda.html)** is the Anaconda (company) driven minimalistic conda installer. 
By default, subsequent package installations come from anaconda channels (default or otherwise).
The default channel order can be changed for either conda installation type.
miniforge started when miniconda didn't support the linux aarch64 system architectures and was quickly adopted by many conda user.
It's stuck around even though both miniconda and miniforge support most system architectures.

One of the problems conda addresses is resolving dependency conflicts betweens many pieces of software installed in the same environment.
This is an [NP-complete problem](https://www.anaconda.com/blog/understanding-and-improving-condas-performance) meaning it gets slower as more software is added to an environment and it's a hard problem to solve.
[mamba](https://mamba.readthedocs.io/en/latest/index.html) is a drop-in replacement for conda that offers higher speed and more reliable environment solutions.
However, the best way to install mamba at the moment is via conda.
Mamba is worth the confusion it has caused -- it decreases install times by orders of magnitude thus saving time.

