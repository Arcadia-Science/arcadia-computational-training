# Increasing developer productivity with IDEs and terminal customizations

In the last couple of weeks, we learned many [shell](../20220906-intro-to-shell1/lesson.md) and [git](../../workshops/20220920-intro-to-git-and-github/lesson.md) commands. This week, we'll take a step back to learn about using an integrated development environment (IDE) to develop our scripts/pipelines and customizing our terminals with shortcuts and git visualizations.

## Accessing the shell for this lesson

For this lesson, we need to have access to a Unix shell.
If you're not sure how to open a terminal on your computer, see [these instructions](https://swcarpentry.github.io/shell-novice/setup.html).

## Caveats

- You don't really have to do any of these customizations to get good at programming. But these are designed to make your life easier.
- A good chunk of customizations are personal. The goal is to learn _how_ to customize and to empower you to customize as you wish.
- A good chunk of customizations are stylistic. As a programmar, you spend a lot of time in your terminal or text editor. I like making these tools beautiful.
- I like bash because I've been using it for 10 years. This workshop will focus on using bash instead of zsh. But there are parallels between the two and learning to customize one will help you customize the other.
- These type of tools can sometimes get RAM-intensive. So, beware if you have a laptop with <16GB of RAM.

## Demo repository

For demo purposes, we'll use the contents of the [AUG repository](https://github.com/Arcadia-Science/arcadia-computational-training). So, let's download the contents of it:

```{bash}
cd ~/Desktop
git clone git@github.com:Arcadia-Science/arcadia-computational-training.git
cd arcadia-computational-training
ls
```

## Customizing the terminal

There are 3 main ways, we'll customize our terminals.

- Switching from zsh to bash if you haven't already.
- Installing [iTerm2](https://iterm2.com/), a better version of Apple's built-in Terminal application.
- Customizing bash with `.bash_profile`.

### Switching from zsh to bash

Open the Terminal application, run `chsh -s /bin/bash` and quit the application. Next time you open, you should see bash. You'll see an alert that `zsh` the new Apple default when you open the terminal

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

### Tweaking the bash prompt

### Using aliases for commonly used commands

### Adding git auto-complete to bash

### Tweaking git

## IDEs

### What are IDEs?

People think of programming as mostly editing the source code of a web application or a script or a computational pipeline. But there are many other aspects of programming that happen all the time that we take for granted: debugging, testing, checking the code for errors, typos etc.

Integrated development environments or IDEs bring all these aspects of programming together and offer convenient features like autocomplete, syntax highlighting, linting, code execution etc.

IDEs are not necessary for programming, but with basic configuration, they can significantly increase coding productivity.

### Which IDE should I use?

There are many IDEs or IDE-like text editors out there. Some are language-specific (think [IntelliJ](https://www.jetbrains.com/idea/) for Java). Some are generic like [Sublime Text](https://www.sublimehq.com/). Up until very recently, I've exclusively used Sublime Text and still love it for light-weight programming.

But at Arcadia Science, we'll be using [Visual Studio Code](https://code.visualstudio.com/) (aka VS Code). There are couple reasons for this:

- It has a tight-integration with git and Github.
- It has a rich marketplace of free extensions, enabling you to configure your IDE to your heart's content.
- It works cross-platform and has a straightforward way of syncing your settings across devices.
- It is quite easy to configure because it suggests improvements on its own as needed.

### Installing VS Code

Download and install VS Code by going to [this URL](https://code.visualstudio.com/download). Once installed, turn on sync across devices and login with your GitHub account.

## Customizing VS Code

You can just use VS Code as is. This section suggests a couple base-level customizations to make your life a little easier. Some of these are basic settings changes and some of these are installing extensions to add new capabilities to VS Code.

### Settings

**Note:** There are hundreds of settings you can customize, we'll only focus on essentials.

Open up the settings panel by hitting Command + , or by selecting "Code" -> "Preferences" -> "Settings" from the top left corner. There are two ways to adjust settings:

1. You can search through them using the search bar or
2. You can edit the underlying JSON blob that specifies the user settings.

Today, we'll mostly do #1, but if you're interested in following the second method, a simplified version of all my settings can be found in [this file](config-and-dotfiles/vscode_settings.json). So, let's get started.

- **Auto Save:** Search for "Auto Save" in the settings menu. And adjust it to the non-default value (which is none). Mine is "afterDelay".
- **Font Size:** Search for "Font Size" and adjust it as you wish. I like 14pts font.
- **Trim Trailing Whitespace:**: Search for it and turn it on, so your code doesn't have trailing spaces or tabs.
- **Insert Final Newline:** Search for it and turn it on. This will prevent you from receiving PR review comments on [this](https://stackoverflow.com/questions/729692/why-should-text-files-end-with-a-newline).
- **Trim Final Newlines:** Again, turn it on. This will make sure there's only a single newline at the end of each file.
- insertFinalNewline
- **Format on Save:** Search for "Format on Save" and turn it on. This will make sure, whatever code formatter you use formats the code upon saving it.
- **Default Terminal application:** Search for "Osx Exex" and type "iTerm.app".
- **Default Terminal profile:** Search for "Default Profile: Osx" and choose "bash".

### Extensions

For this section, I'll only go through the installation instructions of a few VS Code extensions and give you a list of other extensions you can install on your own time. For downloading and installing extensions, click on the "Extensions" tab from the left tab, search for the name of the extension and hit "install". Here are the extensions:

- Prettier
- Git Graph
- GitHub Pull Requests and Issues
- Excel Viewer
- Markdown All in One

#### Extension recommendations

- Python
- Pylance - for basic linting
- R
- Jupyter - for Jupyter notebooks
- Jupyter Cell Tags
- Jupyter Keymap
- Jupyter Notebook Renderers
- Jupyter Slide Show
- One Dark Pro - for color schemes

## What will happen in the future?

- We got a glimpse of basic forms of linting with Pylance and basic forms of formatting with Prettier. We'll be doing a more in-depth workshop on Python and R specific linters (and ways of automating the linting process) so you can easily catch errors and have consistent styling for your code
- Updating `bash` to its latest version. This can get a little bit complicated and is error-prone because you have to work with Homebrew. Instructions are [here](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba), but we won't cover it in-depth for brevity.
- Adding auto-complete to git on bash. Originally, this was going to be included in this workshop, but was cut out for breviy purposes. [This](https://stackoverflow.com/questions/12399002/how-to-configure-git-bash-command-line-completion) is actually quite straightforward to do, but is better done with the latest version of bash.
- If we have a decent reception to this workshop, we may host another one on broader productivity tools for Mac and Chrome.
