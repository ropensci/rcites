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

## ------------------------------------------------------------------------
elephant_taxonconcept <- spp_taxonconcept(query_taxon = "Loxodonta africana")
elephant_taxonconcept

## ----map, message = FALSE, fig.width = 6.4, fig.height = 7.6, fig.align="center"----
library(rworldmap)

par(las = 1)
elephant_distr <- spp_distributions(taxon_id = "4521", verbose = FALSE)$distributions

map2 <- joinCountryData2Map(elephant_distr,
                            joinCode="ISO2",
                            nameJoinColumn = "iso_code2",
                            nameCountryColumn = "name")
plot(c(-23, 62), c(45, -40),
     type = "n",
     main = "Loxodonta africana",
     xlab = "Longitude",
     ylab = "Latitude")
plot(map2, add = TRUE)
plot(map2[!is.na(map2$iso_code2),], col = "#cba74d", add = TRUE)

## ------------------------------------------------------------------------
elephant_cites <- spp_cites_legislation(taxon_id = "4521")
elephant_cites

## ------------------------------------------------------------------------
elephant_eu <- spp_eu_legislation(taxon_id = "4521")
elephant_eu

## ------------------------------------------------------------------------
elephant_refs <- spp_references(taxon_id = "4521", verbose = FALSE)
elephant_refs
dim(elephant_refs$references)

