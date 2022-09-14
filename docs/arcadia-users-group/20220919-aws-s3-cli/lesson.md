# How to use the AWS S3 command line tool

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

## What is the AWS S3 CLI and why do we care about it?

Arcadia uses Amazon Web Services (AWS) S3 to store our files remotely, sometimes as backups, sometimes to host files temporarily before we deposit them to a FAIR data repository.

Some of us may already know how to interact with AWS S3 through its own user interface or using a tool like [Cyberduck](https://www.notion.so/arcadiascience/Syncing-data-to-S3-via-a-GUI-for-the-microscopy-team-bd7c106e648343d4ac01c2d5198b633c). While these options work fine, they limit the speed at which you can interact with S3 (they put explicit caps on upload/download speeds) and may be burdensome for large scale changes (think: updating 100s of files).

This is where the AWS S3 command line tool comes into play. During this workshop, we'll learn about two tools: the official [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/s3/) and [s5cmd](https://github.com/peak/s5cmd).

Command line tools may be intimidating but great news: if you attended the AUG workshops in the last 2 weeks focusing on shell commands, you already know the shell versions of all the commands (`ls`, `cp`, `mv`, `rm` etc.) that we'll go through in this workshop. So let's get started!

## Downloading and installing the AWS CLI

The download and installation instructions for the AWS CLI can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html). Since we'll be using Binder for our workshop, you can use these two commands to start the installation process:

```{bash}
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
```

## Getting your AWS credentials to use with the AWS CLI

## Configuring the AWS CLI to work with your credentials

### With `aws configure`

### By setting `.aws/credentials`

### By manually passing it with each command

### When working wit an EC2 instance

## S3 commands we'll work with

### ls

### sync

### cp

### mv

### rm

## --dry-run

## Advanced usage with s5cmd

### Why?

## Downloading and installing the s5cmd CLI

https://github.com/peak/s5cmd

### s5cmd commands we'll work with

#### ls

### sync

#### cp

#### mv

#### rm

### --dry-run
