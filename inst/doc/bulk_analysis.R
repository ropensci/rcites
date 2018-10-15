## ----setup, echo = FALSE-------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  purl = NOT_CRAN,
  eval = NOT_CRAN,
  fig.align = "center",
  comment = "#> "
)
library(rcites)

## ----all_cms-------------------------------------------------------------
res_cms <- spp_taxonconcept("", taxonomy = "CMS") #slow
dim(res_cms$general)

## ----all_cites-----------------------------------------------------------
res_cites <- spp_taxonconcept("", page = 1:2)
dim(res_cites$general)

## ------------------------------------------------------------------------
res1 <- spp_distributions(taxon_id = c('4521', '3210', '10255'), verbose = FALSE)
## Number of countries concerned per taxon ID
table(res1$distributions$taxon_id)

## ---- echo = FALSE-------------------------------------------------------
Sys.sleep(5)

## ------------------------------------------------------------------------
res2 <- spp_cites_legislation(taxon_id = c('4521', '3210', '10255'), verbose = FALSE)
res2$cites_listings

## ---- echo = FALSE-------------------------------------------------------
Sys.sleep(7)

## ------------------------------------------------------------------------
res3 <- spp_eu_legislation(taxon_id = c('4521', '3210', '10255'), verbose = FALSE)
res3$eu_listings

## ---- echo = FALSE-------------------------------------------------------
Sys.sleep(7)

## ------------------------------------------------------------------------
res4 <- spp_references(taxon_id = c('4521', '3210', '10255'), verbose = FALSE)
## Number of references per taxon ID
table(res4$references$taxon_id)

