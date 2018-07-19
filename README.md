---
title: "citesr: An R package to access the CITES Speciesplus database"
output:
    md_document
---


# citesr

An R package to access the CITES Speciesplus database (https://speciesplus.net/)

## Current Status

![](https://img.shields.io/badge/citesr-InDevelopment-d7ae67.svg)
[![Build Status](https://travis-ci.org/ibartomeus/citesr.svg?branch=master)](https://travis-ci.org/ibartomeus/citesr)
[![Build status](https://ci.appveyor.com/api/projects/status/j8u04bwan0kqpn0f?svg=true)](https://ci.appveyor.com/project/KevCaz/citesr)
[![codecov](https://codecov.io/gh/ibartomeus/citesr/branch/master/graph/badge.svg)](https://codecov.io/gh/ibartomeus/citesr)


## Key features

- sppplus_taxonconcept: [retrieve a taxon concept](https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html)
- taxon_distribution: [access distribution data](https://api.speciesplus.net/documentation/v1/distributions/index.html)
- taxon_eu_legislation: [access EU legislation data](https://api.speciesplus.net/documentation/v1/eu_legislation/index.html)
- taxon_cites_legislation: [Access legislation data](https://api.speciesplus.net/documentation/v1/cites_legislation/index.html)
- taxon_references: [access reference data](https://api.speciesplus.net/documentation/v1/references/index.html)


### Installation

So far, the installation requires the `devtools` package:

```R
devtools::install_github("ibartomeus/citesr")
library("citesr")
```

See the vignette for details on how to use the package: [vignette](https://ibartomeus.github.io/citesr/)

## Contributors

### Code contributors

- Main contributors: https://github.com/ibartomeus/citesr/graphs/contributors
- Reporting issues: [FVFaleiro](https://github.com/FVFaleiro);


## Resources

- The structure of this repository/package was inspired by [taxize](https://github.com/ropensci/taxize);
- "Managing secrets" is a very helpful vignette for dealing with tokens https://cran.r-project.org/web/packages/httr/vignettes/secrets.html.



## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.
