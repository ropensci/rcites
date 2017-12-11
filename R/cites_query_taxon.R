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
#' sppplus_taxonconcept(cnx, query = 'Smaug giganteus', appendix_only = TRUE)
#' sppplus_taxonconcept(cnx, query = 'Homo sapiens', appendix_only = TRUE)

sppplus_taxonconcept <- function(cnx, query = "Smaug giganteus", appendix_only = TRUE) {
    # check is a valid name
    query2 <- gsub(pattern = " ", replacement = "%20", x = query)
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts.xml?name=" , query2, sep = ""),
                   httpheader = paste("X-Authentication-Token: ",
                                      cnx[[2]], sep = ""))
    temp2 <- xmlToList(temp)
    if (temp2$pagination$`total-entries`$text == "0") {
        message("species not listed in CITES")
    } else {
        if (appendix_only) {
            data.frame(id = temp2$`taxon-concepts`$`taxon-concept`$id$text,
                       taxon = temp2$`taxon-concepts`$`taxon-concept`$`full-name`,
                       cites_listing = temp2$`taxon-concepts`$`taxon-concept`$`cites-listing`)
        } else {
            temp2
        }
    }
}
