#' Access data...
#'
#' Query CITES.
#'
#' @param cnx the output of your cites_connect() function.
#' @param query a query... character
#' @param appendix_only a logical
#' @return xml so far...
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList
#'
#' @export
#' @examples
#' cnx <- cites_connect(token = 'ErJcYxUsIApHLCLOxiJ1Zwtt')
#' cites_query_taxon(cnx, query = 'Smaug giganteus', appendix_only = TRUE)
#' cites_query_taxon(cnx, query = 'Homo sapiens', appendix_only = TRUE)

cites_distribution <- function(cnx, query_taxon = "Smaug giganteus", 
                                     country = "Spain") {
  tax <- cites_query_taxon(cnx, query = query_taxon, appendix_only = TRUE)
  temp <- getURI(url = paste(cnx[[1]], 
                             "taxon_concepts/:", tax$id, 
                             "/distributions.xml", sep = ""),
                 httpheader = paste("X-Authentication-Token: ",
                                    cnx[[2]], sep = ""))
  
  temp <- getURI(url = paste(cnx[[1]], 
                             "taxon_concepts.xml?=", query2, 
                             "/distributions.xml", sep = ""),
                 httpheader = paste("X-Authentication-Token: ",
                                    cnx[[2]], sep = ""))
  
  
  temp2 <- xmlToList(temp)
}






