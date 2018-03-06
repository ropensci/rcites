‘citesr’: R client for the CITES species+ API
=============================================

An R package to access the CITES Species+ database. Reference: UNEP
(2017). The Species+ Website. Nairobi, Kenya. Compiled by UNEP-WCMC,
Cambridge, UK. Available at: www.speciesplus.net. \[Accessed
18/02/2017\].

Current Status
--------------

![](https://img.shields.io/badge/citesr-InDevelopment-d7ae67.svg)
[![Build
Status](https://travis-ci.org/ibartomeus/citesr.svg?branch=master)](https://travis-ci.org/ibartomeus/citesr)
[![Build
status](https://ci.appveyor.com/api/projects/status/j8u04bwan0kqpn0f?svg=true)](https://ci.appveyor.com/project/KevCaz/citesr)
[![codecov](https://codecov.io/gh/ibartomeus/citesr/branch/master/graph/badge.svg)](https://codecov.io/gh/ibartomeus/citesr)

How it works
------------

### Get a token

So far, the user must get its own authentication token, *i.e.* it must
signed up on the species+/cites website: <https://api.speciesplus.net/>.
You basically have three options once you got the token:

1.  set an environment variable `SPPPLUS_TOKEN` in your
    [`.Renviron`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Startup.html)
    file (preferred);

2.  use `sppplus_login()`; you will be able to interactively set up
    `SPPPLUS_TOKEN` for the current R session (meaning you will have to
    do it again during the next session).

3.  use the `token` argument of the functions, *i.e.* pass the token to
    all of your function calls.

For the sack of clarity we use a variable `token` below. If you have
opted for 1 or 2 then you can ignore this parameter (*i.e.*
`token=NULL`). Note that value `8QW6Qgh57sBG2k0gtt` is not working, it
is actually the one displayed on the species plus website, see
<https://api.speciesplus.net/documentation>.

### Installation of our R client

So far the installation requires the `devtools` package:

    devtools::install_github("ibartomeus/citesr")
    library("citesr")
    token <- "8QW6Qgh57sBG2k0gtt"
    # alternatively use `sppplus_login` and ignore `token`

### Examples

#### `sppplus_taxonconcept()`

    # get all fields in nested list format
    sppplus_taxonconcept(query = "Loxodonta africana", token, appendix_only = TRUE)

    #R>       id          full_name cites_listing
    #R>  1: 4521 Loxodonta africana          I/II

    # also works at higher order taxonomy
    sppplus_taxonconcept(query = "Mammalia", token, appendix_only = TRUE)

    #R>     id full_name cites_listing
    #R>  1: 34  Mammalia   I/II/III/NC

#### `sppplus_distribution()`

    # get distribution information
    dis <- taxon_distribution(tax_id = '4521', token, collapse_tags = ' + ')
    head(dis)

    #R>       id iso_code2              name tags    type references
    #R>  1: 1778        ML              Mali NULL COUNTRY     <list>
    #R>  2: 1923        GQ Equatorial Guinea NULL COUNTRY     <list>
    #R>  3: 4429        RW            Rwanda NULL COUNTRY     <list>
    #R>  4: 4491        GH             Ghana NULL COUNTRY     <list>
    #R>  5: 5628        SD             Sudan NULL COUNTRY     <list>
    #R>  6: 6724        ET          Ethiopia NULL COUNTRY     <list>

#### `taxon_cites_legislation()`

    # you can ask for the CITES legislation information, e.g. listings
    leg <- taxon_cites_legislation(tax_id = "4521", token, type = "listings")
    leg$cites_listings[1L, 1L:6L]

    #R>       id taxon_concept_id is_current appendix change_type effective_at
    #R>  1: 3666             4521       TRUE       II           +   2007-09-13

#### `taxon_eu_legislation()`

    # you can ask for the CITES legislation information, e.g. listing
    leg_eu <- taxon_eu_legislation(tax_id = "4521", token, type = "decisions")
    leg_eu$eu_decisions[1L, 1L:6L]

    #R>        id taxon_concept_id notes start_date is_current eu_decision_type
    #R>  1: 26285             4521       2015-04-09       TRUE           <list>

    unlist(leg_eu$eu_decisions[1L, 6L])

    #R>  eu_decision_type.name eu_decision_type.type 
    #R>             "Positive"    "POSITIVE_OPINION"

#### `taxon_references()`

    ref <- taxon_references(tax_id = '4521', token, type = 'taxonomic')
    dim(ref)

    #R>  NULL

    ref$taxonomic[1L, ]

    #R>        id                                           citation is_standard
    #R>  1: 10265 Anon. 1978. Red data book: Mammalia. IUCN. Morges.       FALSE

#### Distribution map

The example below requires `rworldmap`.

    suppressPackageStartupMessages(library(rworldmap))
    map1 <- as.data.frame(taxon_distribution('4521', token))
    map2 <- joinCountryData2Map(map1, joinCode="ISO2", nameJoinColumn = "iso_code2", nameCountryColumn = "name")

    #R>  42 codes from your data successfully matched countries in the map
    #R>  0 codes from your data failed to match with a country code in the map
    #R>  201 codes from the map weren't represented in your data

    map2@data$iso2 <- unlist(lapply(map2$iso_code2, is.null))
    plot(c(-23, 62), c(45, -40), type = "n", main = "Loxodonta africana",
      xlab = "Longitude (°C)", ylab = "Latitude (°C)")
    plot(map2, add = T)
    plot(map2[!map2$iso2,], col = "#bd9a5e", add = T)

![](inst/assets/img/map-1.png)

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
