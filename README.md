<img src="man/figures/rcites_logo.png" width="130" height="150" align="right"/>

### Current Status

[![Build status](https://travis-ci.org/ibartomeus/rcites.svg?branch=master)](https://travis-ci.org/ibartomeus/rcites)
[![Build status](https://ci.appveyor.com/api/projects/status/bsd3c7mv12xv959j/branch/master?svg=true)](https://ci.appveyor.com/project/KevCaz/rcites/branch/master)
[![codecov](https://codecov.io/gh/ibartomeus/rcites/branch/master/graph/badge.svg)](https://codecov.io/gh/ibartomeus/rcites)
[![ROpenSci status](https://badges.ropensci.org/244_status.svg)](https://github.com/ropensci/onboarding/issues/244)
[![CRAN status](https://www.r-pkg.org/badges/version/rcites)](https://www.r-pkg.org/badges/version/rcites)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/rcites)](https://cran.r-project.org/package=rcites)


# rcites

An R package to access information from the [Speciesplus](https://speciesplus.net/) database via the [Species+/CITES Checklist API](https://api.speciesplus.net/documentation/v1.html). The package is available for download from [CRAN](https://cran.r-project.org/package=rcites) (stable version) and [Github](https://github.com/ibartomeus/rcites) (development version).

Please see the [release paper](link to come) for background information about the Convention on International Trade in Endangered Species of Wild Fauna and Flora ([CITES](https://cites.org)), the Speciesplus database and basic information about the aim of the package.


### Installation

The package can be installed from CRAN:

```R
install.packages("rcites")
library("rcites")
```

The development version can be installed via the `devtools` package:

```R
devtools::install_github("ibartomeus/rcites")
library("rcites")
```


### Setup requirements and use

To set up a connection to the CITES Speciesplus database, a personal authentication token is required. Please see the vignette for details how to get a token and how to set the token for package use:
[Get started with rcites](https://ibartomeus.github.io/rcites/articles/rcites-vignette.html)


### Key features

Once the token is set, the package has five key features:

- `spp_taxonconcept()`: [access the Speciesplus taxon concept](https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html) and retrieve a taxon id
- `spp_cites_legislation()`: [access CITES legislation data](https://api.speciesplus.net/documentation/v1/cites_legislation/index.html)
- `spp_eu_legislation()`: [access EU legislation data](https://api.speciesplus.net/documentation/v1/eu_legislation/index.html)
- `spp_distributions()`: [access a taxon distribution data](https://api.speciesplus.net/documentation/v1/distributions/index.html)
- `spp_references()`: [access a listing reference data](https://api.speciesplus.net/documentation/v1/references/index.html)


### Prefix information

The package functions have three different prexifes:
- `set_` for `set_token()` to initially set the API token
- `spp_` for the key features that access data from the CITES Speciesplus database
- `rcites_` for helper functions that are called within the key features


### Citation information

When citing, please refer to both the [package citation](https://ibartomeus.github.io/rcites/authors.html) and the [release paper](link to come).


## Contributors

- [Main contributors](https://github.com/ibartomeus/rcites/graphs/contributors)
- Reporting issues:
  - [FVFaleiro](https://github.com/FVFaleiro);


## Resources

An other package dealing with data from and about CITES, providing access to its wildlife trade database: [cites](https://github.com/ecohealthalliance/cites/)

While creating this package, we greatly benefited from:
1. [taxize](https://github.com/ropensci/taxize) that helps a lot in structuring this repository/package,
2. the `httr` vignette: [Managing secrets](https://cran.r-project.org/web/packages/httr/vignettes/secrets.html), extremely helpful for packages dealing with API.


## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.

Also, please read the terms and Conditions of Use of Species+ Data:
https://speciesplus.net/terms-of-use.
