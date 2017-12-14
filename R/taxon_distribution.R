#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
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
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax_id, "/distributions.xml",
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))
    temp2 <- xmlParse(temp)
    temp2 <- xmlRoot(temp2)

    if (country_only == TRUE) {
        temp3 <- xmlToDataFrame(unlist(temp2["api-distributions-view"]))
        rowno <- c(1:nrow(temp3))
        distr <- data.frame(matrix(NA, ncol = 6, nrow = length(rowno)))
        names(distr) <- c("id", "iso2", "name", "tags",
                               "type", "references")
        distr$id <- as.character(tax_id)
        distr$iso2 <- temp3$`iso-code2`
        distr$name <- temp3$name
        # tags
        for (r in rowno) {
          if (temp3[r, "tags"] == "") {
          } else {
            tags <- xmlToDataFrame(unlist(temp2[[r]]["tags"]))
            if (ncol(tags) == 1) {
              distr[r, "tags"] <- as.character(tags[1,1])
              } else {
                distr[r, "tags"] <- as.character(paste(tags[1,1], tags[1,2], sep = " + "))
              }
          }
        }
        distr <- distr[-c(5, 6)]
        names(distr) <- c("tax_id", "iso2", "country", "note")
        distr
    } else {
        xmlToList(temp)
    }
}
