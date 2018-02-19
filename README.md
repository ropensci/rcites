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

    #R>       id          full_name cites_listing
    #R>  1: 4521 Loxodonta africana          I/II

    # also works at higher order taxonomy
    sppplus_taxonconcept(token, query = "Mammalia", appendix_only = TRUE)

    #R>     id full_name cites_listing
    #R>  1: 34  Mammalia   I/II/III/NC

#### `sppplus_distribution()`

    # you can ask for distribution
    taxon_distribution(token, tax_id = '4521', collapse_tags = ' + ')

    #R>         id iso_code2                             name
    #R>   1:  1778        ML                             Mali
    #R>   2:  1923        GQ                Equatorial Guinea
    #R>   3:  4429        RW                           Rwanda
    #R>   4:  4491        GH                            Ghana
    #R>   5:  5628        SD                            Sudan
    #R>   6:  6724        ET                         Ethiopia
    #R>   7:  8995        GA                            Gabon
    #R>   8: 12983        AO                           Angola
    #R>   9: 15554        CM                         Cameroon
    #R>  10: 17060        BJ                            Benin
    #R>  11: 19004        MZ                       Mozambique
    #R>  12: 21296        ZW                         Zimbabwe
    #R>  13: 22598        BW                         Botswana
    #R>  14: 25648        ZA                     South Africa
    #R>  15: 29237        DJ                         Djibouti
    #R>  16: 34325        BF                     Burkina Faso
    #R>  17: 36541        TZ      United Republic of Tanzania
    #R>  18: 38501        KE                            Kenya
    #R>  19: 39769        NG                          Nigeria
    #R>  20: 40132        UG                           Uganda
    #R>  21: 45272        CF         Central African Republic
    #R>  22: 47168        SO                          Somalia
    #R>  23: 47634        LR                          Liberia
    #R>  24: 55428        GN                           Guinea
    #R>  25: 55928        TG                             Togo
    #R>  26: 56100        ZM                           Zambia
    #R>  27: 56780        BI                          Burundi
    #R>  28: 56987        MW                           Malawi
    #R>  29: 60042        MR                       Mauritania
    #R>  30: 61625        TD                             Chad
    #R>  31: 64492        NA                          Namibia
    #R>  32: 65619        SS                      South Sudan
    #R>  33: 71202        CG                            Congo
    #R>  34: 71794        CD Democratic Republic of the Congo
    #R>  35: 72434        NE                            Niger
    #R>  36: 72883        SN                          Senegal
    #R>  37: 79470        SZ                        Swaziland
    #R>  38: 79693        GM                           Gambia
    #R>  39: 79814        ER                          Eritrea
    #R>  40: 80906        SL                     Sierra Leone
    #R>  41: 81799        GW                    Guinea Bissau
    #R>  42: 82840        CI                    Côte d'Ivoire
    #R>         id iso_code2                             name
    #R>                        tags    type references
    #R>   1:                   NULL COUNTRY     <list>
    #R>   2:                   NULL COUNTRY     <list>
    #R>   3:                   NULL COUNTRY     <list>
    #R>   4:                   NULL COUNTRY     <list>
    #R>   5:                   NULL COUNTRY     <list>
    #R>   6:                   NULL COUNTRY     <list>
    #R>   7:                   NULL COUNTRY     <list>
    #R>   8:                   NULL COUNTRY     <list>
    #R>   9:                   NULL COUNTRY     <list>
    #R>  10:                   NULL COUNTRY     <list>
    #R>  11:                   NULL COUNTRY     <list>
    #R>  12:                   NULL COUNTRY     <list>
    #R>  13:                   NULL COUNTRY     <list>
    #R>  14:                   NULL COUNTRY     <list>
    #R>  15:                extinct COUNTRY     <list>
    #R>  16:                   NULL COUNTRY     <list>
    #R>  17:                   NULL COUNTRY     <list>
    #R>  18:                   NULL COUNTRY     <list>
    #R>  19:                   NULL COUNTRY     <list>
    #R>  20:                   NULL COUNTRY     <list>
    #R>  21:                   NULL COUNTRY     <list>
    #R>  22:                   NULL COUNTRY     <list>
    #R>  23:                   NULL COUNTRY     <list>
    #R>  24:                   NULL COUNTRY     <list>
    #R>  25:                   NULL COUNTRY     <list>
    #R>  26:                   NULL COUNTRY     <list>
    #R>  27:                extinct COUNTRY     <list>
    #R>  28:                   NULL COUNTRY     <list>
    #R>  29:                extinct COUNTRY     <list>
    #R>  30:                   NULL COUNTRY     <list>
    #R>  31:                   NULL COUNTRY     <list>
    #R>  32:                   NULL COUNTRY     <list>
    #R>  33:                   NULL COUNTRY     <list>
    #R>  34:                   NULL COUNTRY     <list>
    #R>  35:                   NULL COUNTRY     <list>
    #R>  36:                   NULL COUNTRY     <list>
    #R>  37: extinct + reintroduced COUNTRY     <list>
    #R>  38:                extinct COUNTRY     <list>
    #R>  39:                   NULL COUNTRY     <list>
    #R>  40:                   NULL COUNTRY     <list>
    #R>  41:                   NULL COUNTRY     <list>
    #R>  42:                   NULL COUNTRY     <list>
    #R>                        tags    type references

#### `taxon_cites_legislation()`

    # you can ask for the CITES legislation information, e.g. listing
    leg <- taxon_cites_legislation(token, tax_id = "4521", type = "listings")
    leg$cites_listings[1, 1:6]

    #R>       id taxon_concept_id is_current appendix change_type effective_at
    #R>  1: 3666             4521       TRUE       II           +   2007-09-13

#### `taxon_eu_legislation()`

    # you can ask for the CITES legislation information, e.g. listing
    leg_eu <- taxon_eu_legislation(token, tax_id = "4521", type = "decisions")
    leg_eu$eu_decisions[1, 1:6]

    #R>        id taxon_concept_id notes start_date is_current eu_decision_type
    #R>  1: 26285             4521       2015-04-09       TRUE           <list>

    unlist(leg_eu$eu_decisions[1, 6])

    #R>  eu_decision_type.name eu_decision_type.type 
    #R>             "Positive"    "POSITIVE_OPINION"

#### `taxon_references()`

    ref <- taxon_references(token, tax_id = '4521', type = 'taxonomic')
    dim(ref)

    #R>  NULL

    ref$taxonomic[1, ]

    #R>        id                                           citation is_standard
    #R>  1: 10265 Anon. 1978. Red data book: Mammalia. IUCN. Morges.       FALSE

#### Distribution map

The example below requires `rworldmap`.

    library(rworldmap)
    map1 <- as.data.frame(taxon_distribution(token, '4521'))
    map2 <- joinCountryData2Map(map1, joinCode="ISO2", nameJoinColumn = "iso_code2", nameCountryColumn = "name")

    #R>  42 codes from your data successfully matched countries in the map
    #R>  0 codes from your data failed to match with a country code in the map
    #R>  201 codes from the map weren't represented in your data

    map2@data$iso2 <- unlist(lapply(map2$iso_code2, is.null))
    plot(c(-23, 62), c(45.9, -40), type = "n", main = "Loxodonta africana")
    plot(map2, add = T)
    plot(map2[!map2$iso2,], col = "#bd9a5e", add = T)

![](inst/assets/img/map-1.png)

------------------------------------------------------------------------

Todo list
=========

-   \[ \] improve documentation
-   \[ \] vignette
-   \[ \] API: taxon\_eu\_legislation
