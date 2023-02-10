# Code review during the pub process

## Goals of the code review process

Increase reproducibility and usability of the computational products we put out by making sure:
1. Our code is readable and well documented.
2. The software (and versions!) we used are clear.
3. It's clear how data inputs and outputs relate to the code. 

## Code review FAQ and discussion

1. code review for figures
2. Could code review happen after version 1 of the pub?

## Overview of the pub process and how it relates to code review

![](https://i.imgur.com/ayaQz9J.png)

## Minimums for passing code review: a checklist

1. All software packages and their versions are documented.
2. Data inputs and outputs are documented.
3. Only relative paths (not absolute paths) are used and the relative paths reference files in the repo or there is documentation for how to get the file.
4. Enough comments and/or documentation is provided so it's clear what the code does.
5. DOI for pub is linked in the README.

## Most common pain points with code review

1. Pushing to `main` or `master` instead of to a branch and opening a pull request
2. Requesting review of the entire repo instead of requesting periodic reviews
 
## GitHub refresher

Figure and demo

## Resources to help you thrive through code review

1. Your code review partner, AUG office hours, and the #software-questions channel
2. https://github.com/Arcadia-Science/arcadia-software-handbook
3. GitHub lesson/workshop

## Process tips (these should probably just go into Monday and then be taken out of the lesson)

1. DOI for pub -> GitHub README
2. Figures go into PubPub first before zenodo release of code
3. Then zenodo release
