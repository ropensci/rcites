#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}})
#' @param query_taxon character string containing the query (e.g. species). Depreciated if tax_id is provided.
#' @param tax_id character string containing the tax id (e.g. 4521)
#' @param country_only a logical statement for querying only the country information. Default is TRUE.
#' @return If country_only is TRUE, returns a dataframe with taxon and country. If appendix_only is FALSE, returns a list with all distribution information.
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'nsert your token here')
#' # taxon_distribution(cnx, tax_id = '4521', country_only = TRUE)

taxon_distribution <- function(cnx, query_taxon = "Loxodonta africana", tax_id = NULL, 
    country_only = TRUE) {
    if (is.null(tax_id)) {
        tax <- sppplus_taxonconcept(cnx, query = query_taxon, appendix_only = TRUE)
    } else {
        tax <- data.frame(id = tax_id)
    }
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax$id, "/distributions.xml", 
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))
    temp2 <- xmlToList(temp)
    if (country_only) {
        data.frame(id = tax$id, taxon = query_taxon,
                   country = unlist(lapply(temp2, "[", "name")),
                   iso2 = unlist(lapply(temp2, "[", "iso-code2")))
    } else {
        temp2
    }
}
