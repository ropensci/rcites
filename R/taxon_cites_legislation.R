#' Access CITES legislation data from CITES species+ API
#'
#' Query CITES.
#'
#' @param cnx the output of your \code{sppplus_connect()} function.
#' @param query_taxon a character vector to be documented
#' @param tax_id to be documented.
#' @param type to be documented.
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
#' # taxon_cites_legislation(cnx, tax_id = '4521', type = 'listing')

taxon_cites_legislation <- function(cnx, query_taxon = "Loxodonta africana", tax_id = NULL,
    type = "listing") {
    if (is.null(tax_id)) {
        tax <- sppplus_taxonconcept(cnx, query = query_taxon, appendix_only = TRUE)
    } else {
        tax <- data.frame(id = tax_id)
    }
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax$tax_id, "/cites_legislation.xml",
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))

    temp <- xmlParse(temp)
    temp2 <- xmlRoot(temp)
    xmlName(temp2)
    names(temp2)

    # listings <- temp2[[1]]['cites-listing'] quotas <- temp2[[2]]['cites-quota']
    # suspensions <- temp2[[3]]['cites-suspension']

    if (type == "listing") {
        listing <- xmlToDataFrame(unlist(temp2[[1]]["cites-listing"]))
        listing
    } else {
        if (type == "quota") {
            quota <- xmlToDataFrame(unlist(temp2[[2]]["cites-quota"]))
            quota
        } else {
            if (type == "suspension") {
                suspension <- xmlToDataFrame(unlist(temp2[[3]]["cites-suspension"]))
                suspension
            } else {
                message("select type of legislation: listing, quota or suspension")
            }
        }
    }

    # length(names(listings)) names(listings[[3]]) length(names(quotas))
    # length(names(suspensions))

    # temp3 <- unlist(xmlSApply(listings[[1]], function(x) xmlSApply(x, xmlValue)))
    # as.character(temp3[4]) # appendix as.character(temp3[6]) # date
    # as.character(temp3[7]) # notes

    # if (type = 'listing') { data.frame(id = tax$id, taxon =
    # ifelse(exists('query_taxon'), query_taxon, NA), country_iso2 =
    # unlist(lapply(listings, '[', 'party')), appendix = unlist(lapply(listings, '[',
    # 'appendix')), listing_date = unlist(lapply(listings, '[', 'effective-at')),
    # listing_notes = unlist(lapply(listings, '[', 'annotation'))) } else {
    # message('select type of legislation: listing, quota or suspension') }

}
