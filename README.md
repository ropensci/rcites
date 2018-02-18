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
    taxon_distribution(token, tax_id = '4521', collapse_tags = ' + ')

    ##        id iso_code2                             name
    ##  1:  1778        ML                             Mali
    ##  2:  1923        GQ                Equatorial Guinea
    ##  3:  4429        RW                           Rwanda
    ##  4:  4491        GH                            Ghana
    ##  5:  5628        SD                            Sudan
    ##  6:  6724        ET                         Ethiopia
    ##  7:  8995        GA                            Gabon
    ##  8: 12983        AO                           Angola
    ##  9: 15554        CM                         Cameroon
    ## 10: 17060        BJ                            Benin
    ## 11: 19004        MZ                       Mozambique
    ## 12: 21296        ZW                         Zimbabwe
    ## 13: 22598        BW                         Botswana
    ## 14: 25648        ZA                     South Africa
    ## 15: 29237        DJ                         Djibouti
    ## 16: 34325        BF                     Burkina Faso
    ## 17: 36541        TZ      United Republic of Tanzania
    ## 18: 38501        KE                            Kenya
    ## 19: 39769        NG                          Nigeria
    ## 20: 40132        UG                           Uganda
    ## 21: 45272        CF         Central African Republic
    ## 22: 47168        SO                          Somalia
    ## 23: 47634        LR                          Liberia
    ## 24: 55428        GN                           Guinea
    ## 25: 55928        TG                             Togo
    ## 26: 56100        ZM                           Zambia
    ## 27: 56780        BI                          Burundi
    ## 28: 56987        MW                           Malawi
    ## 29: 60042        MR                       Mauritania
    ## 30: 61625        TD                             Chad
    ## 31: 64492        NA                          Namibia
    ## 32: 65619        SS                      South Sudan
    ## 33: 71202        CG                            Congo
    ## 34: 71794        CD Democratic Republic of the Congo
    ## 35: 72434        NE                            Niger
    ## 36: 72883        SN                          Senegal
    ## 37: 79470        SZ                        Swaziland
    ## 38: 79693        GM                           Gambia
    ## 39: 79814        ER                          Eritrea
    ## 40: 80906        SL                     Sierra Leone
    ## 41: 81799        GW                    Guinea Bissau
    ## 42: 82840        CI                    Côte d'Ivoire
    ##        id iso_code2                             name
    ##                       tags    type references
    ##  1:                   NULL COUNTRY     <list>
    ##  2:                   NULL COUNTRY     <list>
    ##  3:                   NULL COUNTRY     <list>
    ##  4:                   NULL COUNTRY     <list>
    ##  5:                   NULL COUNTRY     <list>
    ##  6:                   NULL COUNTRY     <list>
    ##  7:                   NULL COUNTRY     <list>
    ##  8:                   NULL COUNTRY     <list>
    ##  9:                   NULL COUNTRY     <list>
    ## 10:                   NULL COUNTRY     <list>
    ## 11:                   NULL COUNTRY     <list>
    ## 12:                   NULL COUNTRY     <list>
    ## 13:                   NULL COUNTRY     <list>
    ## 14:                   NULL COUNTRY     <list>
    ## 15:                extinct COUNTRY     <list>
    ## 16:                   NULL COUNTRY     <list>
    ## 17:                   NULL COUNTRY     <list>
    ## 18:                   NULL COUNTRY     <list>
    ## 19:                   NULL COUNTRY     <list>
    ## 20:                   NULL COUNTRY     <list>
    ## 21:                   NULL COUNTRY     <list>
    ## 22:                   NULL COUNTRY     <list>
    ## 23:                   NULL COUNTRY     <list>
    ## 24:                   NULL COUNTRY     <list>
    ## 25:                   NULL COUNTRY     <list>
    ## 26:                   NULL COUNTRY     <list>
    ## 27:                extinct COUNTRY     <list>
    ## 28:                   NULL COUNTRY     <list>
    ## 29:                extinct COUNTRY     <list>
    ## 30:                   NULL COUNTRY     <list>
    ## 31:                   NULL COUNTRY     <list>
    ## 32:                   NULL COUNTRY     <list>
    ## 33:                   NULL COUNTRY     <list>
    ## 34:                   NULL COUNTRY     <list>
    ## 35:                   NULL COUNTRY     <list>
    ## 36:                   NULL COUNTRY     <list>
    ## 37: extinct + reintroduced COUNTRY     <list>
    ## 38:                extinct COUNTRY     <list>
    ## 39:                   NULL COUNTRY     <list>
    ## 40:                   NULL COUNTRY     <list>
    ## 41:                   NULL COUNTRY     <list>
    ## 42:                   NULL COUNTRY     <list>
    ##                       tags    type references

#### `sppplus_distribution()`

    # you can ask for the CITES legislation information, e.g. listing
    taxon_cites_legislation(token, tax_id = "4521", type = "listing")

Examples
--------

    library(rworldmap)
    map1 <- taxon_distribution(token, query_taxon = 'Loxodonta africana')
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
