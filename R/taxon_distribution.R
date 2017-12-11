#' Access distribution data
#'
#' Query CITES.
#'
#' @param cnx the output of your sppplus_connect() function.
#' @param query a query... character
#' @param country_only a logical
#' @return data frame or list...
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList
#'
#' @export
#' @examples
#' cnx <- sppplus_connect(token = 'ErJcYxUsIApHLCLOxiJ1Zwtt')
#' taxon_distribution(cnx, query_taxon = 'Loxodonta africana', country_only = TRUE)

taxon_distribution <- function(cnx, query_taxon = "Loxodonta africana", 
                                     country_only = TRUE) {
  tax <- sppplus_taxonconcept(cnx, query = query_taxon, appendix_only = TRUE)
  temp <- getURI(url = paste(cnx[[1]], 
                             "taxon_concepts/", tax$id, 
                             "/distributions.xml", sep = ""),
                 httpheader = paste("X-Authentication-Token: ",
                                    cnx[[2]], sep = ""))
  temp2 <- xmlToList(temp)
  if (country_only) {
    data.frame(id = tax$id,
               taxon = query_taxon,
               distribution = unlist(sapply(temp2, '[', 'name')),
               iso2 = unlist(sapply(temp2, '[', 'iso-code2')))
  } else {
    temp2
  }
}






