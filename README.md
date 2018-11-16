<img src="man/figures/rcites_logo.png" width="130" height="150" align="right"/>

### Current Status

[![Build status](https://travis-ci.org/ropensci/rcites.svg?branch=master)](https://travis-ci.org/ropensci/rcites)
[![Build status](https://ci.appveyor.com/api/projects/status/kgimo4v7rvtpkp5e?svg=true)](https://ci.appveyor.com/project/KevCaz/rcites-mo3vb)
[![codecov](https://codecov.io/gh/ropensci/rcites/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rcites)
[![DOI](https://zenodo.org/badge/113842199.svg)](https://zenodo.org/badge/latestdoi/113842199)
[![ROpenSci status](https://badges.ropensci.org/244_status.svg)](https://github.com/ropensci/onboarding/issues/244)
[![CRAN status](https://www.r-pkg.org/badges/version/rcites)](https://www.r-pkg.org/badges/version/rcites)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/rcites)](https://cran.r-project.org/package=rcites)


# rcites

An R package to access information from the [Speciesplus](https://speciesplus.net/) database via the [Species+/CITES Checklist API](https://api.speciesplus.net/documentation/v1.html). The package is available for download from [CRAN](https://cran.r-project.org/package=rcites) (stable version) and [Github](https://github.com/ropensci/rcites) (development version).

Please see the [release paper](link to come) for background information about the Convention on International Trade in Endangered Species of Wild Fauna and Flora ([CITES](https://cites.org)), the Species+ database and basic information about the aim of the package.


### Installation

The package can be installed from CRAN:

```R
install.packages("rcites")
library("rcites")
```

The development version can be installed via the `devtools` package:

```R
devtools::install_github("ropensci/rcites")
library("rcites")
```


### Setup requirements and use

To set up a connection to the CITES Species+ database, a personal authentication
token is required. Please see the vignette for details how to get a token and
how to set the token for package use: [Get started with rcites](https://ropensci.github.io/rcites/articles/get_started.html)

Additional information about specific use examples are provided for the
[African bush elephant (*Loxodonta africana*)](https://ropensci.github.io/rcites/articles/elephant.html).
The package usage for querying multiple species is described in another
vignette entitled ['Bulk analysis with rcites'](https://ropensci.github.io/rcites/articles/bulk_analysis.html).


### Key features

Once the token is set, the package has five key features:

- `spp_taxonconcept()`: [access the Speciesplus taxon concept](https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html) and retrieve a taxon id
- `spp_cites_legislation()`: [access CITES legislation data](https://api.speciesplus.net/documentation/v1/cites_legislation/index.html)
- `spp_eu_legislation()`: [access EU legislation data](https://api.speciesplus.net/documentation/v1/eu_legislation/index.html)
- `spp_distributions()`: [access a taxon distribution data](https://api.speciesplus.net/documentation/v1/distributions/index.html)
- `spp_references()`: [access a listing reference data](https://api.speciesplus.net/documentation/v1/references/index.html)


### Prefix information

The package functions have three different prefixes:

- `set_` for `set_token()` to initially set the API token
- `spp_` for the key features
- `rcites_` for helper functions that are called within the key features


### Citation information

When citing, please refer to both the [package citation](https://ropensci.github.io/rcites/authors.html).
 <!-- and the [release paper](link to come). -->


## Contributors

- [Main contributors](https://github.com/ropensci/rcites/graphs/contributors)

- Reviewers of the package:
  - [Noam Ross](https://github.com/noamross)
  - [Margaret Siple](https://github.com/mcsiple)

- Editor: [Scott Chamberlain](https://github.com/sckott)

- Reporting issue(s):
  - [FVFaleiro](https://github.com/FVFaleiro)



## Resources

Another package dealing with data from and about CITES, providing access to its
wildlife trade database: [cites](https://github.com/ecohealthalliance/cites/)

While creating this package, we greatly benefited from:

1. [taxize](https://github.com/ropensci/taxize) that inspired the structuring of this repository/package;

2. the `httr` vignette: [Managing secrets](https://cran.r-project.org/web/packages/httr/vignettes/secrets.html), which is extremely helpful for packages dealing with API.



## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.

Also, please read the Terms and Conditions of Use of Species+ Data:
https://speciesplus.net/terms-of-use.



[![ropensci_footer](https://ropensci.org/public_images/ropensci_footer.png)](https://ropensci.org)
