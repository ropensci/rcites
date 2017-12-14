#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param tax_id character string containing the taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param country_only logical statement for querying only the country information. Default is TRUE.
#' @return If country_only is TRUE, returns a dataframe with taxon and country. If appendix_only is FALSE, returns a list with all distribution information.
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList xmlToDataFrame xmlRoot xmlParse
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'insert your token here')
#' # taxon_distribution(cnx, tax_id = '4521', country_only = TRUE)

taxon_distribution <- function(cnx, tax_id = "4521", country_only = TRUE) {
    # if (is.null(tax_id)) { tax <- sppplus_taxonconcept(cnx, query = query_taxon,
    # appendix_only = TRUE) } else { tax <- data.frame(tax_id = tax_id) }

    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax_id, "/distributions.xml",
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))

    temp2 <- xmlParse(temp)
    temp2 <- xmlRoot(temp2)

    if (country_only == TRUE) {
        temp3 <- xmlToDataFrame(unlist(temp2["api-distributions-view"]))
        temp3$id <- tax_id
        temp3 <- temp3[c(1, 3, 2, 4, 6)]
        names(temp3) <- c("tax_id", "country", "iso2", "note", "reference")
        temp3
    } else {
        xmlToList(temp)
    }
}
