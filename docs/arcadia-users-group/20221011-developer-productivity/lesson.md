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

Download and install VS Code by going to [this URL](https://code.visualstudio.com/download).

## Customizing VS Code

You can just use VS Code as is. This section suggests a couple base-level customizations to make your life a little easier.

### Settings

- Format on save
- Auto save
- New line
- insertFinalNewline
- Ruler

### Extensions

- Prettier
- Git Graph
- GitHub Pull Requests and Issues
- Excel Viewer
- Markdown All in One
- Python
- Pylance
- R
- Jupyter
- Jupyter Cell Tags
- Jupyter Keymap
- Jupyter Notebook Renderers
- Jupyter Slide Show
- One Dark Pro

## Customizing the terminal

### Installing and using iTerm2

Download and install iTerm2 by going to [this URL](https://iterm2.com/).

### Customizing iTerm2

https://iterm2colorschemes.com/

### Tweaking the bash prompt

### Using aliases for commonly used commands

### Adding git auto-complete to bash

### Tweaking git

## What will happen in the future?

- We got a glimpse of basic forms of linting with Pylance and basic forms of formatting with Prettier. We'll be doing a more in-depth workshop on Python and R specific linters (and ways of automating the linting process) so you can easily catch errors and have consistent styling for your code.
- If we have a decent reception to this workshop, we may host another one on broader productivity tools for Mac and Chrome.
