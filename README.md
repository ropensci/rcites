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
    taxon_cites_legislation(token, tax_id = "4521", type = "listings")

    ## $cites_listings
    ##      id taxon_concept_id is_current appendix change_type effective_at
    ## 1: 3666             4521       TRUE       II           +   2007-09-13
    ## 2: 3665             4521       TRUE        I           +   2007-09-13
    ## 3: 3645             4521       TRUE        I          R+   1990-01-18
    ## 4: 3645             4521       TRUE        I          R+   1990-01-18
    ## 5: 3645             4521       TRUE        I          R+   1990-01-18
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         annotation
    ## 1: The populations of Botswana, Namibia, South Africa and Zimbabwe are listed in Appendix II for the exclusive purpose of allowing:a) trade in hunting trophies for non-commercial purposes;b) trade in live animals to appropriate and acceptable destinations, as defined in Resolution Conf. 11.20, for Botswana and Zimbabwe and for in situ conservation programmes for Namibia and South Africa;c) trade in hides;d) trade in hair;e) trade in leather goods for commercial or non-commercial purposes for Botswana, Namibia and South Africa and for non-commercial purposes for Zimbabwe;f) trade in individually marked and certified ekipas incorporated in finished jewellery for non-commercial purposes for Namibia and ivory carvings for non-commercial purposes for Zimbabwe;g) trade in registered raw ivory (for Botswana, Namibia, South Africa and Zimbabwe, whole tusks and pieces) subject to the following:      i) only registered government-owned stocks, originating in the State (excluding seized ivory and ivory of unknown origin);      ii) only to trading partners that have been verified by the Secretariat, in consultation with the Standing Committee, to have sufficient national legislation and domestic trade controls to ensure that the imported ivory will not be re-exported and will be managed in accordance with all requirements of Resolution Conf. 10.10 (Rev. CoP14) concerning domestic manufacturing and trade;    iii) not before the Secretariat has verified the prospective importing countries and the registered government-owned stocks;     iv) raw ivory pursuant to the conditional sale of registered government-owned ivory stocks agreed at CoP12, which are 20,000 kg (Botswana), 10,000 kg (Namibia) and 30,000 kg (South Africa);      v) in addition to the quantities agreed at CoP12, government-owned ivory from Botswana, Namibia, South Africa and Zimbabwe registered by 31 January 2007 and verified by the Secretariat may be traded and despatched, with the ivory in paragraph g) iv) above, in a single sale per destination under strict supervision of the Secretariat;     vi) the proceeds of the trade are used exclusively for elephant conservation and community conservation and development programmes within or adjacent to the elephant range; and    vii) the additional quantities specified in paragraph g) v) above shall be traded only after the Standing Committee has agreed that the above conditions have been met; and h) no further proposals to allow trade in elephant ivory from populations already in Appendix II shall be submitted to the Conference of the Parties for the period from CoP14 and ending nine years from the date of the single sale of ivory that is to take place in accordance with provisions in paragraphs g) i), g) ii), g) iii), g) vi) and g) vii). In addition such further proposals shall be dealt with in accordance with Decisions 14.77 and 14.78 (Rev. CoP15).On a proposal from the Secretariat, the Standing Committee can decide to cause this trade to cease partially or completely in the event of non-compliance by exporting or importing countries, or in the case of proven detrimental impacts of the trade on other elephant populations.All other specimens shall be deemed to be specimens of species included in Appendix I and the trade in them shall be regulated accordingly.
    ## 2:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Included in Appendix I, except the populations of Botswana, Namibia, South Africa and Zimbabwe, which are included in Appendix II.
    ## 3:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              NA
    ## 4:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              NA
    ## 5:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              NA
    ##      party
    ## 1:    NULL
    ## 2:    NULL
    ## 3:      MW
    ## 4:  Malawi
    ## 5: COUNTRY

#### `taxon_references()`

    taxon_references(token, tax_id = '4521', type = 'taxonomic')

    ## $taxonomic
    ##        id
    ##  1: 10265
    ##  2:  6344
    ##  3: 17013
    ##  4:  6371
    ##  5:  6532
    ##  6:  6534
    ##  7:  6825
    ##  8:  7224
    ##  9:  7609
    ## 10: 19397
    ## 11: 19572
    ## 12: 15783
    ## 13:  7852
    ## 14: 43172
    ## 15: 17655
    ##                                                                                                                                                                                                                                                                                                                                 citation
    ##  1:                                                                                                                                                                                                                                                                                   Anon. 1978. Red data book: Mammalia. IUCN. Morges.
    ##  2:                                                                                           Barnes, R. F., Agnagna, M., Alers, M. P. T., Blom, A., Doungabe, G., Fay, M. Masunda, T., Ndo, J. C., Nkoumou, C., Sikubwalo Kiyengo and Tchamba, M. 1993. Elephants and ivory poaching in the forests of equatorial Africa. Oryx: 27: 27.
    ##  3: Blanc, J.J., Thouless, C.R., Hart, J.A., Dublin H.T., Douglas-Hamilton, I., Craig, C.R. and Barnes, R.F.W. 2003. African Elephant Status Report 2002: an update from the African Elephant Database. http://iucn.org/afesg/aed/aesr2002.html IUCN/SSC African Elephant Specialist Group. IUCN, Gland, Switzerland and Cambridge, UK. 
    ##  4:                                                                                                                                                                                                            Burton, M. P. 1994. Alternative projections of the decline of the African Elephant. Biological Conservation: 70: 183-188.
    ##  5:                                                                                                                                                                                                                                                    Douglas-Hamilton, I. 1987. African Elephant population study. Pachyderm: 8: 1-10.
    ##  6:                                                                                                                                                                                                                                   Douglas-Hamilton, I. 1987. African Elephants: population trends and their causes. Oryx: 21: 11-24.
    ##  7:                                                                                                                                                                                                                                                  Jackson, P. 1982. Elephants and rhinos in Africa. A time for decision. IUCN. Gland.
    ##  8:                                                                                                                                                                                           Meester, J. and Setzer, H. W (eds.) 1974. The mammals of Africa. An identification manual. Smithsonian Institution Press. Washington, D.C.
    ##  9:                                                                                                                                                                                                                                                               Parker, I. and Amin, M. 1983. Ivory crisis. Chatto and Windus. London.
    ## 10:                                                                                                                                                                                                                          Parker, I.S.C. and Martin, E.B. 1982. How many elephants are killed for the ivory trade? Oryx: 16: 235-239.
    ## 11:                                                                                                                                                                                     Riddle, H.S., Schulte, B.A., Desai, A.A. and van der Meer, L. 2009. Elephants - a conservation overview. Journal of Threatened Taxa: 2: 653-661.
    ## 12:                                                                                                                                                                            Roca, A. L., Georgiadis, N., Pecon-Slattery, J. and O'Brien, S. J. 2001. Genetic evidence for two species of elephant in Africa. Science: 293: 1473-1477.
    ## 13:                                                                                                                                                  Said, M. and Change, R. 1994. African elephant database. A preliminary update Nov. 1994. IUCN, UNEP, African Elephant Specialist Group, SSC, Global Resource Information Database .
    ## 14:                                                                                                                                                           Wilson, D.E. and Reeder, D.M. (Eds.) 1993. <i>Mammal species of the world, a taxonomic and geographic reference</i>. Smithsonian Institution Press. Washington and London.
    ## 15:                                                                                                                                 Wilson, D.E. and Reeder, D.M. (Eds.). 2005. <i>Mammal species of the world, a taxonomic and geographic reference</i>. 3rd Edition, The Johns Hopkins University Press, Baltimore, Maryland. 2,142pp.
    ##     is_standard
    ##  1:       FALSE
    ##  2:       FALSE
    ##  3:       FALSE
    ##  4:       FALSE
    ##  5:       FALSE
    ##  6:       FALSE
    ##  7:       FALSE
    ##  8:       FALSE
    ##  9:       FALSE
    ## 10:       FALSE
    ## 11:       FALSE
    ## 12:       FALSE
    ## 13:       FALSE
    ## 14:        TRUE
    ## 15:       FALSE

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
