# Code review during the pub process

## Goal of the code review process

Increase reproducibility and usability of the computational products we put out by making sure:
1. Our code is readable and well documented.
2. The software (and versions!) we used are clear.
3. It's clear how data inputs and outputs relate to the code. 

## Overview of the pub process and how it relates to code review

![](https://i.imgur.com/ayaQz9J.png)

## Most common pain points with code review

1. Pushing to `main` or `master` instead of to a branch and opening a pull request
2. Requesting review of the entire repo instead of requesting periodic reviews
 
## Most common changes to code requested during review

1. Undocumented software packages or versions.
2. Undocumented data locations. 
3. Absolute paths instead of relative paths.
4. Missing comments or documentation.
5. DOI for pub not linked in the README

## Resources to help you thrive through code review

1. Your code review partner, AUG office hours, and the #software-questions channel
2. https://github.com/Arcadia-Science/arcadia-software-handbook
3. GitHub lesson/workshop

## Process tips (these should probably just go into Monday and then be taken out of the lesson)

1. DOI for pub -> GitHub README
2. Figures go into PubPub first before zenodo release of code
3. Then zenodo release
