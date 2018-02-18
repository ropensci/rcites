An R package to access the CITES Species+ database. Reference: UNEP
(2017). The Species+ Website. Nairobi, Kenya. Compiled by UNEP-WCMC,
Cambridge, UK. Available at: www.speciesplus.net. \[Accessed
18/02/2017\].

Current Status
--------------

![](https://img.shields.io/badge/inSileco-InDevelopment-3fb3b2.svg)
[![Build
Status](https://travis-ci.org/ibartomeus/citesr.svg?branch=master)](https://travis-ci.org/ibartomeus/citesr)

How it works so far
-------------------

### Get a token

So far we require the user to get its own authentication token, *i.e.*
it must signed up on the species plus / cites website:
<https://api.speciesplus.net/>. Below the variable `token` will refer to
your own token, the token below is not working (it is the one displays
on the species plus website ) 8QW6Qgh57sBG2k0gtt
(<https://api.speciesplus.net/documentation>).

### Installation of our R client

So far the installation required the `devtools` package:

    devtools::install_github("ibartomeus/citesr")
    library("citesr")
    token <- "8QW6Qgh57sBG2k0gtt"

### Examples

#### `sppplus_taxonconcept()`

    # get all fields in nested list format
    sppplus_taxonconcept(token, query = "Loxodonta africana", appendix_only = TRUE)

    ##      id          full_name cites_listing
    ## 1: 4521 Loxodonta africana          I/II

    # also works at higher order taxonomy
    sppplus_taxonconcept(token, query = "Mammalia", appendix_only = TRUE)

    ##    id full_name cites_listing
    ## 1: 34  Mammalia   I/II/III/NC

#### `sppplus_distribution()`

    # you can ask for distribution
    taxon_distribution(cnx, tax_id = "4521", country_only = TRUE)
    # you can ask for the CITES legislation information, e.g. listing
    taxon_cites_legislation(cns, tax_id = "4521", type = "listing")

Examples
--------

    library(rworldmap)
    map1 <- taxon_distribution(token, query_taxon = 'Loxodonta africana', country_only = TRUE)
    map2 <- joinCountryData2Map(map1, joinCode="ISO2", nameJoinColumn = "iso2", nameCountryColumn = "distribution")
    mapCountryData(mapToPlot = map2, nameColumnToPlot = "taxon", mapRegion = "africa", mapTitle = "Loxodonta africana", addLegend = FALSE)

![](inst/Elephant.jpeg)

------------------------------------------------------------------------

NB: other similar tools does exist: for code integration see [this
page](https://github.com/marketplace/category/continuous-integration)
and for code quality see [that
one](https://github.com/marketplace/category/code-quality).

Todo list
=========

-   \[x\] write function for personal API: sppplus\_connect
-   \[x\] write function for access to taxon concept:
    sppplus\_taxonconcept
-   \[x\] Query by Taxon
-   \[x\] Add warning when species do not exists.
-   \[ \] Better help
-   \[ \] vignette
-   \[X\] Add licence
-   \[ \] can we do a ping?
-   \[x\] API: taxon\_cites\_legislation
-   \[x\] API: taxon\_distribution
-   \[ \] API: taxon\_eu\_legislation
-   \[x\] API: taxon\_references
