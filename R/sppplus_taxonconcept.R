#' Access taxon_concept data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param query_taxon character string containing the query (e.g. species). Scientific taxa only.
#' @param appendix_only logical statement for querying only the taxon and CITES appendix information. Default is TRUE.
#' @return If appendix_only is TRUE, returns a dataframe with taxon and CITES appendix information. If appendix_only is FALSE, returns a list with all Species+ taxon concept information.
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList xmlToDataFrame xmlParse xmlRoot
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'insert your token here')
#' # sppplus_taxonconcept(cnx, query_taxon = 'Loxodonta africana', appendix_only = TRUE)
#' # sppplus_taxonconcept(cnx, query_taxon = 'Homo sapiens', appendix_only = TRUE)

sppplus_taxonconcept <- function(cnx, query_taxon = "Loxodonta africana", appendix_only = TRUE) {
    # we can add here a check to ensure is a valid name
    query <- gsub(pattern = " ", replacement = "%20", x = query_taxon)
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts.xml?name=", query, sep = ""),
        httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))
    temp2 <- xmlParse(temp)
    temp2 <- xmlRoot(temp2)
    if (xmlToList(unlist(temp2[[1]][[3]]))$text == "0") {
        message("taxon not listed in CITES")
    } else {
        if (appendix_only == TRUE) {
            temp3 <- xmlToDataFrame(unlist(temp2[[2]]["taxon-concept"]))
            temp3 <- temp3[c(1, 2, 8)]
            names(temp3) <- c("tax_id", "taxon", "appendix")
            temp3
        } else {
            xmlToList(temp)
        }
    }
}
