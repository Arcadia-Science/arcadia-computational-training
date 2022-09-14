# How to use the AWS S3 command line tool

## Accessing the shell for this lesson

For this lesson, we need to have access to a Unix shell.
If you're not sure how to open a terminal on your computer, see [these instructions](https://swcarpentry.github.io/shell-novice/setup.html).

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

Once the installation process is complete run `which aws` to make sure installation worked as expected.

## Configuring the AWS CLI to work with your credentials

### Getting your AWS credentials to use with the AWS CLI

This section assumes you are part of the Arcadia Science AWS account. If you're not, no worries. I'll securely share credentials with you. For AWS users, detailed instructions can be found [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html). The summary:

* Login to the [AWS console](https://console.aws.amazon.com/).
* Click on your username on the top right and select "Security credentials"
* Scroll down to the "Access keys for CLI, SDK, & API access" section, select "Create access key" and go through the steps.
* Record your access key and access secret in a secure place (or download it as a CSV temporarily) and do not share with anyone!

Now we need to tell the AWS CLI how to use your credentials.

### With `aws configure`

Run `aws configure`. It'll ask for your `AWS Access Key ID`, `AWS Secret Access Key`, `Default region name` and `Default output format` one command at a time.

Enter the credentials you got in the previous section for the first two settings. Our `Default region name` is `us-west` and `Default output format` is `json`.

It should look like this:

```{bash}
aws configure
AWS Access Key ID [None]: <YOUR_ACCESS_KEY>
AWS Secret Access Key [None]: <YOUR_ACCESS_SECRET>
Default region name [None]: us-west-1
Default output format [None]: json
```

### [Advanced] When working wit an EC2 instance

This section is out of the scope of this workshop, but it is important to note: When working with an AWS EC2 instance you can enable S3 access by using IAM roles. Instructions for that can be found [here](https://www.notion.so/arcadiascience/Enabling-EC2-and-S3-connection-3d8b3b75441b49eaac1095eb66fbde97).

## S3 commands we'll work with

### ls

### sync

### cp

### mv

### rm

## --dry-run

## [Optional] Advanced usage with s5cmd

[s5cmd](https://github.com/peak/s5cmd) is an unofficial tool to interact with AWS S3 through the command-line. In this section, we'll talk about the installation instructions and the differences to the official AWS S3 CLI. But first, why do we care about `s5cmd`?

### Why?

Great news: if your machine is configured to work with the AWS CLI, it's by default configured to work with s5cmd! It has two benefits over the official S3 CLI:
1. It's much faster. This is due to effective parallelization and bandwidth saturation. See [this blog post](https://joshua-robinson.medium.com/s5cmd-for-high-performance-object-storage-7071352cc09d) for benchmarking data.
![](s5cmd-benchmark.png)
2. It also is compatible with Google Cloud Storage (GCS) in case you have to work with any databases that are hosted on GCS (think: Alphafold).

## Downloading and installing the s5cmd CLI

```{bash}
wget https://github.com/peak/s5cmd/releases/download/v2.0.0/s5cmd_2.0.0_Linux-64bit.tar.gz
tar -xvf s5cmd_2.0.0_Linux-64bit.tar.gz
```

## Differences to the official CLI

### `--dry-run` behavior
