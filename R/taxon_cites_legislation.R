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
#' # cnx <- sppplus_connect(token = 'insert your token here')
#' # taxon_cites_legislation(cnx, tax_id = '4521', type = 'listing')

taxon_cites_legislation <- function(cnx, query_taxon = "Loxodonta africana", tax_id = NULL,
    type = "listing") {
    if (is.null(tax_id)) {
        tax <- sppplus_taxonconcept(cnx, query = query_taxon, appendix_only = TRUE)
    } else {
        tax <- data.frame(tax_id = tax_id)
    }
  
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax$tax_id, "/cites_legislation.xml",
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))

    temp <- xmlParse(temp)
    temp2 <- xmlRoot(temp)
    xmlName(temp2)
    names(temp2)

    if (type == "listing") {
      listing <- xmlToDataFrame(unlist(temp2[[1]]["cites-listing"]))
      rowno <- c(1:nrow(listing))
      for (r in rowno) {
        if (is.na(listing[r,8]) == T) {
        } else {
      party <- xmlToDataFrame(unlist(temp2[[1]][[r]]["party"]))
      names(party) <- c("iso2", "name", "type")
      listing[r,8] <- as.character(party$iso2)
        }}
      listing <- listing[c(2,4,8,6,7)]
      names(listing) <- c("tax_id", "appendix", "iso2", "date", "notes")
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
            if (type == "suspension") {
                suspension <- xmlToDataFrame(unlist(temp2[[3]]["cites-suspension"]))
                suspension
            } else {
                message("select type of legislation: listing, quota or suspension")
            }
          }
        }
      }

}
