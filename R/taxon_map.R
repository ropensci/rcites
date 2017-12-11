

library(rworldmap)

taxon_map <- function(cnx, taxon){
  map1 <- taxon_distribution(cnx, query_taxon = taxon, country_only = TRUE)
map2 <- joinCountryData2Map(map1, joinCode="ISO2", nameJoinColumn = "iso2", nameCountryColumn = "distribution")
mapCountryData(mapToPlot = map2, nameColumnToPlot = "taxon", mapTitle = taxon, addLegend = FALSE)
}
taxon_map(cnx, "Branta canadensis")
