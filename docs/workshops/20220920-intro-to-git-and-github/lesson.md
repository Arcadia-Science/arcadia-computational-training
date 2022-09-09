# Hands on introduction to Git and GitHub

## Version control

#### What it is and when to use it

<center>
<figure markdown>
  ![Image title](phd101212s.png){ width="400" }
  <figcaption> 'Piled Higher and Deeper' by Jorge Cham <a href='http://www.phdcomics.com/comics/archive.php?comicid=1531' target='_blank'>www.phdcomics.com</a> </figcaption>
</figure>
</center>

Version control keeps track of changes to a file over time.
While the document above is technically under version control, using file names can be chaotic and unreliable especially when files are passed between multiple people working on different computers.

<center>
<figure markdown>
  ![Image title](version_control_diff_lines.png){ width="600" }
  <figcaption> Figure 6 in DOI 10.1093/gigascience/giaa140 <a href='https://doi.org/10.1093/gigascience/giaa140' target='_blank'>www.academic.oup.com/gigascience</a> </figcaption>
</figure>
</center>

Version control systems work by tracking incremental differences -- delineated by commits -- in files and keeping a history of those changes. 
This allows you to return to return to previous versions at any time.
The file name doesn't change and only one version of a file is displayed at a time, but the full history is accessible.

#### How to use it: overview of Git and GitHub

**[Git](https://git-scm.com/)** is a [free](https://www.gnu.org/philosophy/free-sw.en.html), [distributed](https://en.wikipedia.org/wiki/Distributed_version_control) version control system.
The complete history of your project is safely stored in a hidden `.git` repository.
A **repository** is like a project folder or directory on your computer.
It contains all of the files and folders for a project as well as the history of those files.
Changes to files are recorded as **commits**.
A **commit** is marked by the user when they're ready to check in a set of changes to a file.
You can always go back to a previous commit.

**GitHub** is an internet service for hosting files that are under git version control.
You can think of it like social media for code and small text files.
GitHub houses repositories in a central locations.
Repositories on GitHub are referred to as **remote** repositories.
Users can create a **local** copy of a repository by **cloning** (downloading) it to their computer, or to a computer in the cloud that they have access to.

You don't need GitHub to use the Git version control system.
By using the Git command line interface, you can use version control locally without ever **pushing** your files to a remote repository on GitHub. 

You also don't need to know the Git command line interface to take advantage of the version control system: Git is well-integrated into GitHub, so if you know the basic terminology and definitions, you can still version control your project through GitHub alone.

However, both Git and GitHub are most powerful when combined together.
This workshop will teach you the basics of Git and GitHub so you can leverage both in your research.
TODO: ADD A LIST OF WHY USING GIT AND GITHUB WILL MAKE YOUR RESEARCH BETTER. 

## Setting up

#### Signing up for a GitHub account

You will need a GitHub account for today's workshop.
If you already have one, you can use your current username (e.g. there is no need to create an Arcadia-specific GitHub username).
If you don't, sign up at [github.com](https://github.com/).
Usernames are public so choose accordingly.

#### Accessing a Unix shell

For this lesson, we need to have access to a Unix shell. 
Click the button below to launch a shell through [binder](https://mybinder.org/).

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/arcadia-science/arcadia-computational-training/main)

This will launch a computer in the cloud.
You'll interact with this computer through your browser.
Click the Terminal button to launch a Terminal that we will work with for the rest of the lesson.

![](../../arcadia-users-group/20220906-intro-to-shell1/jupyterhub.png)

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

#### First time setup and configuration

Whenever you use Git for the first time on a computer, there are a few things you need to set up.
Unless you need to change something, these commands only need to be used the first time you use Git on a computer.

First, set your name and email:
```
git config --global user.name "Taylor Reiter"
git config --global user.email "myemail@gmail.com"
```

> Your email and user name is recorded with every commit.
> This helps ensure integrity and authenticity of the history.
> Most people keep their email public, but if you are concerned about privacy, check GitHub's tips to [hide your email](https://help.github.com/articles/keeping-your-email-address-private/).

Next, we'll set up a key pair. 
GitHub [recently discontinued password authentication](https://docs.github.com/en/rest/overview/other-authentication-methods). 
Cryptographic keys are a convenient and secure way to authenticate without having to use passwords and are an authentication method still supported by GitHub. 
They consist of a pair of files called the public and private keys: the public part can be shared with whoever you'd like to authenticate with (in our case, GitHub), and the private part is kept "secret" on your machine. 
Things that are encrypted with the public key can be be decrypted with the private key, but it is computationally intractable (ie, it would take on the order of thousands of years) to determine a private key from a public key. 
You can read more about it [here](https://en.wikipedia.org/wiki/Public-key_cryptography).

```
mkdir ssh
cd ssh
ssh-keygen
```

By convention, key files are usually stored in a `.ssh` directory, not in a `ssh` directory.
The difference is the `.ssh` folder is hidden from view by default.
We need to download this file to our local computer however, and to do that, we need to be able to see if in the file panel viewer of our binder jupyter hub, so we'll put it in an `ssh` folder instead.

The `ssh-keygen` program will prompt you to input a key file name (below, we use `20220909-github`) and a passphrase.
It's ok to leave the passphrase blank.

```
ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/jovyan/.ssh/id_rsa): 20220909-github
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in 20220909-github.
Your public key has been saved in 20220909-github.pub.
The key fingerprint is:
SHA265:
The key's randomart image is:
```

Next, we'll check the key files permissions.
Permissions control who has access to a file on your computer, and key files need to have very restricted permissions.

```
ls -lah
```

We see:
```
total 16K
drwxr-xr-x 2 jovyan jovyan 4.0K Sep  9 20:21 .
drwxr-xr-x 1 jovyan jovyan 4.0K Sep  9 20:20 ..
-rw------- 1 jovyan jovyan 1.7K Sep  9 20:21 20220909-github
-rw-r--r-- 1 jovyan jovyan  445 Sep  9 20:21 20220909-github.pub
```

We are the only user who has read access to our private key file, so our permissions are fine.

When we ran `ls`, we saw that the `ssh-keygen` program generated two files. 
The first file `20220909-github` is the private key file and should never be shared.
The second file `20220909-github.pub` is the public key file that we'll upload to GitHub. 
We can tell it's the public key file because it ends in `.pub`.

Next, we need to get our public key file uploaded to GitHub so we can use it for authentication.
To do that, we'll first download it to our local computers and then we'll upload it to our GitHub accounts.

Click on the `ssh` folder:

![](ssh_folder.png){ width="600" }

And then use the file navigator to download the file to your local computer. 
It doesn't matter where you save it, but make sure you know what the location is.

![](ssh_pub_download.png){ width="525" }


## Getting started with version control

#### Creating your first repository on GitHub






## Branches

When you want to make changes to code, it’s best practice to do it in a **branch**.
A **branch** is an independent line of development of files in a repository. 
You can think of it like making a copy of a document and making changes to that copy only: the original stays the same, but the copy diverges with new content.
In a branch, all files are copied and can be changed. 


## Bringing the whole process together

<center>
<figure markdown>
  ![Image title](allison_horst_git_overview.png){ width="900" }
  <figcaption> Figure by Allison Horst. <a href='https://twitter.com/allison_horst/status/1563210538510737409?s=20&t=USB46onUf9i7zYnkqjUSPQ' target='_blank'>www.twitter.com/allison_horst</a> </figcaption>
</figure>
</center>

This figure by [@allison_horst](https://twitter.com/allison_horst) gives an overview of the entire Git & GitHub ecosystem.
It provides a succinct review of the concepts we've covered today.

Once you like a set of changes you’ve finished on your branch, you can tell git about them by using the command **`git add`**.
This stages the changes you have made. 
Next, you bake them into the branch using **`git commit`**.
When you’re ready, you can communicate those changes back to GitHub using **`git push`**.
This will push your the changes that are on your local branch up to the remote branch.
To integrate this changes formally back into the **main branch**, you can open a **pull request**.
**Pull requests** create a line-by-line comparison between the original code and the new code and generate an interface for inline and overall comments and feedback. 
Pull requests are how changes are **reviewed** before they’re integrated.
Once a pull request is **approved**, the changes are merged into the main branch.
To get the merged changes back to your local branch, you can run **`git pull`**.

GitHub has integrated enough features that many of these steps can be orchestrated completely on GitHub without needing to clone a repository to your local machine.
However, this mental model is still helpful: you can create a branch, make edits to a text file and commit them, open a pull request, and merge the pull request all from the GitHub online interface.
**You do not need to learn Git to experience the joys and benefits of GitHub and to contribute to projects that live there.**

## Summary

Git
GitHub
repository
local 
remote
commit
branch
pull request
review
issue

`git clone`
`git checkout`
`git add`
`git commit`
`git push`
`git pull`

