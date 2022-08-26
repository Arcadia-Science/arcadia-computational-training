# Arcadia Computational Training

This repository houses computational training materials developed for or delivered at Arcadia.
The repository is still a work in progress so things may shift around as we settle on an organizational structure.

The content in this repository is meant to present a sensible set of defaults for common computational tasks in biology at the time that the content is added to the repo.


## Building and deploying a site with MkDocs

[MkDocs](https://www.mkdocs.org/) is static site generator that integrates nicely with GitHub to build websites from repositories.

The file [mkdocs.yml](mkdocs.yml) controls the website layout and organization of the website (as opposed to this being controlled by the file structure in the repository).

This website uses the [Bootswatch](https://mkdocs.github.io/mkdocs-bootswatch/) [lux](https://mkdocs.github.io/mkdocs-bootswatch/#lux) theme.
The [installation & usage](https://mkdocs.github.io/mkdocs-bootswatch/#installation-usage) instructions were added to the [.github/workflows/gh-pages.yml](.github/workflows/gh-pages.yml) as the first `run` directive.

For complete documentation on getting started with MkDocs, see their [getting started documentation](https://www.mkdocs.org/getting-started/).
If you have conda (version `4.13.0`) and mamba (version `0.25.0`) installed, you can run the following to use the MkDocs built-in dev-server:

```
mamba create -n mkdocs mkdocs=1.3.0 mkdocs-bootswatch=1.1
conda activate mkdocs
mkdocs serve
```

Then in your browser, navigate to the URL printed to standard out.
