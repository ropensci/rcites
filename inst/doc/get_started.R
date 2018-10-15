## ----setup, echo = FALSE-------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  purl = NOT_CRAN,
  eval = NOT_CRAN,
  fig.align = "center",
  comment = "#> "
)
library(rcites)

## ---- eval = FALSE-------------------------------------------------------
#  library(rcites)
#  set_token("8QW6Qgh57sBG2k0gtt")

## ----result_1------------------------------------------------------------
res1 <- spp_taxonconcept(query_taxon = "Loxodonta africana")

## ---- eval = FALSE-------------------------------------------------------
#  res1 <- spp_taxonconcept(query_taxon = "Loxodonta africana", token = "8QW6Qgh57sBG2k0gtt")

## ----res1_attr-----------------------------------------------------------
attributes(res1)

## ----res1_names----------------------------------------------------------
res1

## ----res3----------------------------------------------------------------
res3 <- spp_taxonconcept(query = "Amazilia versicolor")
res3$general
res3$all_id

## ------------------------------------------------------------------------
res4 <- spp_taxonconcept(query = "Homo Sapiens")

## ----args_spp_taxonconcept-----------------------------------------------
args('spp_taxonconcept')

## ----taxo_cms------------------------------------------------------------
spp_taxonconcept(query = "Amazilia versicolor", taxonomy = "CMS")
spp_taxonconcept(query = "Loxodonta africana", taxonomy = "CMS")

## ----filter--------------------------------------------------------------
spp_taxonconcept(query_taxon = "Loxodonta africana", language = 'EN',
  updated_since = "2016-01-01")

## ------------------------------------------------------------------------
spp_cites_legislation(taxon_id = "4521", verbose = FALSE)

## ------------------------------------------------------------------------
spp_eu_legislation(taxon_id = "3210", scope = "all", verbose = FALSE)

## ------------------------------------------------------------------------
spp_distributions("4521", verbose = FALSE)

## ------------------------------------------------------------------------
spp_references("4521", verbose = FALSE)

