#' Access CITES legislation data from CITES species+ API
#'
#' Query CITES.
#'
#' @param cnx the output of your \code{sppplus_connect()} function.
#' @param query_taxon a query... character
#' @param tax_id to be documented
#' @param citesleg_only a logical to be documented
#'
#'
#' @return data frame or list...
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'ErJcYxUsIApHLCLOxiJ1Zwtt')
#' # taxon_cites_legislation(cnx, tax_id = '4521', citesleg_only = TRUE)

taxon_cites_legislation <- function(cnx, query_taxon = "Loxodonta africana", tax_id = NULL, 
    citesleg_only = TRUE) {
    if (is.null(tax_id)) {
        tax <- sppplus_taxonconcept(cnx, query = query_taxon, appendix_only = TRUE)
    } else {
        tax <- data.frame(id = tax_id)
    }
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax$id, "/cites_legislation.xml", 
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))
    temp2 <- xmlToList(temp)
    if (citesleg_only) {
        data.frame(id = tax$id, taxon = query_taxon, iso2 = unlist(sapply(temp2$`cites-suspensions`$`cites-suspension`$`geo-entity`$`iso-code2`)), 
            suspension_notes = unlist(sapply(temp2$`cites-suspensions`$`cites-suspension`$notes)), 
            cites_notification = unlist(sapply(temp2$`cites-suspensions`$`cites-suspension`$`start-notification`$name)))
    } else {
        temp2
    }
}
