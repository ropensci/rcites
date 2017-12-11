#' Access taxon_concept data from CITES species+ API 
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)  
#'
#' @param cnx species+ connection information (see \link[citesr]{sppplus_connect}})
#' @param query character string containing the query (e.g. species)
#' @param appendix_only a logical statement for querying only the appendix number information. Default is TRUE.  
#' @return If appendix_only is TRUE, returns a dataframe with taxon and cites_listing. If appendix_only is FALSE, returns a list with all taxon_concept information. 
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList
#'
#' @export
#' @examples
#' cnx <- sppplus_connect(token = 'insert token here')
#' sppplus_taxonconcept(cnx, query = 'Smaug giganteus', appendix_only = TRUE)
#' sppplus_taxonconcept(cnx, query = 'Homo sapiens', appendix_only = TRUE)

sppplus_taxonconcept <- function(cnx, query = "Smaug giganteus", appendix_only = TRUE) {
    #we can add here a check t ensure is a valid name
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
