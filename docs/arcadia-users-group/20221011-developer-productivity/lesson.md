# Increasing developer productivity with IDEs and terminal customizations

In the last couple of weeks, we learned many [shell](../20220906-intro-to-shell1/lesson.md) and [git](../../workshops/20220920-intro-to-git-and-github/lesson.md) commands. This week, we'll take a step back to learn about using an integrated development environment (IDE) to develop our scripts/pipelines and customizing our terminals with shortcuts and git visualizations.

## Accessing the shell for this lesson

For this lesson, we need to have access to a Unix shell.
If you're not sure how to open a terminal on your computer, see [these instructions](https://swcarpentry.github.io/shell-novice/setup.html).

## Caveats

- You don't really have to do any of these customizations to get good at programming. But these are designed to make your life easier.
- A good chunk of these customizations are personal. The goal is to learn _how_ to customize and to empower you to customize as you wish.
- A good chunk of these customizations are stylistic. As a programmar, you spend a lot of time in your terminal or text editor. I think it's important to make these tools beautiful.
- I like bash because I've been using it for 10 years. This workshop will focus on using bash in more detail, and give basic examples of zsh customizations. But there are parallels between the two and learning to customize one will help you customize the other.
- IDEs can sometimes get RAM-intensive. So, beware if you have a laptop with <16GB of RAM. Any customizations to your terminal should be fine.
- Most of the instructions today are for Mac devices. This is because 95% of Arcadia Science scientists use Macs for development work.

## Demo repository

For demo purposes, we'll use the contents of the [AUG repository](https://github.com/Arcadia-Science/arcadia-computational-training). So, let's download the contents of it. Our clone code assumes you have git configured to use an ssh key like we set up in the workshop. If you don't, head over to [this lesson](../../workshops/20220920-intro-to-git-and-github/lesson/#setting-up) for instructions on how to set it up.

```{bash}
cd ~/Desktop # or cd wherever you keep git repositories on your computer
git clone git@github.com:Arcadia-Science/arcadia-computational-training.git
cd arcadia-computational-training
ls
```

## IDEs

### What are IDEs?

People think of programming as mostly editing the source code of a web application or a script or a computational pipeline. But there are many other aspects of programming that happen all the time that we take for granted: debugging, testing, checking the code for errors, typos etc.

Integrated development environments or IDEs bring all these aspects of programming together and offer convenient features like autocomplete, syntax highlighting, linting, code execution etc.

IDEs are not necessary for programming, but with basic configuration, they can significantly increase coding productivity.

### Which IDE should I use?

There are many IDEs or IDE-like text editors out there. Some are language-specific (think [RStudio](https://www.rstudio.com/) for R). Some are generic like [Sublime Text](https://www.sublimehq.com/). Up until very recently, I've exclusively used Sublime Text and still love it for light-weight programming.

Today we'll cover [Visual Studio Code](https://code.visualstudio.com/) (aka VS Code). There are couple reasons for this:

- It has a tight-integration with git and Github.
- It has a rich marketplace of free extensions, enabling you to configure your IDE to your heart's content.
- It works cross-platform and has a straightforward way of syncing your settings across devices.
- It is quite easy to configure because it suggests improvements on its own as needed.
- It has access to a built-in terminal. Try hitting CTRL + \` when you install it.
- It has tooling built-in to enable remote SSH access. So you can use an EC2 instance and navigate it through these tools.

### Installing VS Code

Download and install VS Code by going to [this URL](https://code.visualstudio.com/download). Once installed, turn on sync across devices and login with your GitHub account. This will only sync your settings and extensions across devices and will not sync any files you work with.

## Customizing VS Code

You can use VS Code as is. This section suggests a couple base-level customizations to make your life a little easier.

### Settings

**Note:** There are hundreds of settings you can customize, we'll only focus on the essentials.

Open up the settings panel by hitting Command + , or by selecting "Code" -> "Preferences" -> "Settings" from the top left corner. There are two ways to adjust settings:

1. You can search through them using the search bar
2. You can edit the underlying JSON blob that specifies the user settings.

Today, we'll mostly do #1, but if you're interested in following the second method, a simplified version of all my settings can be found in [this file](config-and-dotfiles/vscode_settings.json). So, let's get started.

- **Auto Save:** Search for "Auto Save" in the settings menu. And adjust it to the non-default value (which is none). Mine is "afterDelay". This will make sure your changes are saved automatically 1000ms after you stop typing.
- **Font Size:** Search for "Font Size" and adjust it as you wish. I like 14pts font.
- **Trim Trailing Whitespace:**: Search for it and turn it on, so your code doesn't have trailing spaces or tabs.
- **Insert Final Newline:** Search for it and turn it on. This will prevent you from receiving PR review comments on [this](https://stackoverflow.com/questions/729692/why-should-text-files-end-with-a-newline).
- **Trim Final Newlines:** Again, turn it on. This will make sure there's only a single newline at the end of each file.
- **Format on Save:** Search for "Format on Save" and turn it on. This will make sure, whatever code formatter you use formats the code upon saving it.
- **Default Terminal application:** You only need to change this if you use iTerm2. If you're on Mac, search for "Osx Exec" and type "iTerm.app". For Linux users, you'd have to search for "Linux Exec".
- **Default Terminal profile:** If you're on Mac, search for "Default Profile: Osx" and choose "bash" or "zsh" depending on your preferences.
- **Adding code in the PATH:** Open the command palette with Command + Shift + P. Search for "code" and choose the "Install 'code' command in PATH". This will make it so that you can open any file/directory from the terminal with `code`.

### Extensions

Before we go through this section, let's quit VS Code. Renavigate to the correct demo folder and re-open with VS Code:

```{bash}
cd ~/Desktop/arcadia-computational-training
code .
```

For this section, we'll only go through the installation instructions of a few VS Code extensions and give you a list of other extensions you can install on your own time. For downloading and installing extensions, click on the "Extensions" tab from the left tab, search for the name of the extension and hit "install". Here are the extensions:

- Prettier: Customization with "Format Document With"
- Markdown All in One: Opening Markdown previews with Command + Shift + V
- Excel Viewer: Opening CSV and Excel previews with Command + Shift + V
- GitHub Pull Requests and Issues
- Git Graph

#### Extension recommendations

- Python
- Pylance - for basic linting
- R
- Jupyter - for Jupyter notebooks. These tools will allow to specify your Python version/kernel you use.
- Jupyter Cell Tags
- Jupyter Keymap
- Jupyter Notebook Renderers
- Jupyter Slide Show
- One Dark Pro - for color schemes
- Nextflow specific [extensions](https://github.com/nf-core/vscode-extensionpack) recommended by the nf-core team

## Customizing the terminal

There are 3 main ways, we'll customize our terminals.

- (Optional) Switching from zsh to bash if you haven't already.
- Installing [iTerm2](https://iterm2.com/), a better version of Apple's built-in Terminal application.
- Customizing bash with `.bash_profile` or customizing zsh with `.zshrc`.

### (Optional) Switching from zsh to bash

**Note:** I like bash because I've been using it for 10 years. You don't have to. If you want to learn more about the differences, you can read more [here](https://www.geeksforgeeks.org/bash-scripting-difference-between-zsh-and-bash/). The main differences are:

- zsh is more configurable and support more customizable plug-ins (like auto-complete!).
- bash is the default shell you'll get access on Linux devices (like AWS instances).

If you want to keep using zsh, that's perfectly fine! You can check [this blog post](https://medium.com/@harrison.miller13_28580/bash-vs-z-shell-a-tale-of-two-command-line-shells-c65bb66e4658) and [this tool](https://github.com/ohmyzsh/ohmyzsh) for ways to configure it. And we'll go through an example customization below.

If you want to start using bash, open the Terminal application, run `chsh -s /bin/bash` and quit the application. Next time you open, you should see bash. You'll see an alert that `zsh` the new Apple default when you open the terminal

### Installing and using iTerm2

Download and install iTerm2 by going to [this URL](https://iterm2.com/). There aren't too many ways to customize iTerm2. Or at least, I only customize the color scheme. My color scheme can be found [here](config-and-dotfiles/iterm.json). If you want to download something unique for you, there are many options [here](https://iterm2colorschemes.com/).

Once you select the color scheme you'd like to use, just do the following:

- Launch iTerm2
- Type CMD+i
- Navigate to Colors tab
- Click on Load Presets
- Click on Import
- Select your file
- Click on Load Presets and choose a color scheme

### Tweaking zsh

There are two files as part of this repository that should give you a sense of how to configure zsh. First one is the [.zshrc](config-and-dotfiles/.zshrc) file and the other is the [iTerm2 zsh configuration file](config-and-dotfiles/.iterm2_shell_integration.zsh). As you'll see most of the configurations rely on the [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) repository. So let's start with installing that:

On Unix systems, you can run `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`.

Note that any previous `.zshrc` will be renamed to `.zshrc.pre-oh-my-zsh`.

You can make sure the installation worked as expected with:

```{bash}
cat ~/.zshrc
```

This file should look awfully similar to [this one](config-and-dotfiles/.zshrc). You can copy the [iTerm2 zsh configuration file](config-and-dotfiles/.iterm2_shell_integration.zsh) in this repository to the root directory (`~`). And copy the contents of the sample .zshrc file to the newly created `~/.zshrc` file. And you should be all set!

### Tweaking bash

In general, most customizations go to the `.bash_profile` or `.bashrc` files. Here, we'll show a slightly modular approach, so we can simplify the files before they get too long and difficult to manage. Once you change the `.bash_profile` or the underlying configuration files, you need to make sure those changes are persistant. You can do that by "sourcing" the `.bash_profile` with `source .bash_profile` or restarting your terminal.

#### Tweaking the bash prompt

For this and the following sections, we need to create the following files: `.bash_profile` (main entry point the Terminal application searches for), `.bash_prompt` (customizes the look of the prompt), `.aliases` (adds new shortcuts/aliases for common commands) and `.gitconfig` (customizations for git commands). Let's start with creating these:

```{bash}
cd ~
touch .bash_profile .bash_prompt .aliases .gitconfig
code .bash_profile .bash_prompt .aliases .gitconfig
```

These commands will not recreate the files if they already exist. If they already exist, we'll edit them. My versions of all these files can be found in the `config-and-dotfiles` directory. You can just copy and paste them, making sure to not delete anything in your existing files. We'll go through them one by one, starting with the [.bash_prompt](config-and-dotfiles/.bash_prompt).

This file basically shapes the main prompt that shows up when you use bash. For it to be activated, make sure you also copy the [.bash_profile](config-and-dotfiles/.bash_profile) file. And run `source ~/.bash_profile`.

#### Using aliases for commonly used commands

Aliases are shortcuts for commands that you frequently use. Some of these provide stylistic changes. Some of these provide useful shortcuts for common git commands. You can customize this however you want, but a simplified version of my aliases can be found [here](config-and-dotfiles/.aliases).

#### Tweaking git

Git uses the `.gitconfig` file to configure the behavior of the git CLI. My simplified version of the configuration file can be found [here](config-and-dotfiles/.gitconfig). The two big components of this configuration file are:

- Colorful view for git branches, stages etc.
- Better visualization of the git history through the command-line

## What will happen in the future?

- We got a glimpse of basic forms of linting with Pylance and basic forms of formatting with Prettier. We'll be doing a more in-depth workshop on Python and R specific linters (and ways of automating the linting process) so you can easily catch errors and have consistent styling for your code
- Updating `bash` to its latest version. This can get a little bit complicated and is error-prone because you have to work with Homebrew. Instructions are [here](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba), but we won't cover it in-depth for brevity.
- Adding auto-complete to git on bash. Originally, this was going to be included in this workshop, but was cut out for breviy purposes. [This](https://stackoverflow.com/questions/12399002/how-to-configure-git-bash-command-line-completion) is actually quite straightforward to do, but is better done with the latest version of bash.
- If we have a decent reception to this workshop, we may host another one on broader productivity tools for Mac and Chrome.
