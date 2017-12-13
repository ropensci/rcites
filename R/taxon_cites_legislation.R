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
#    xmlName(temp2)
#    names(temp2)

    if (type == "quota" & is.null(unlist(temp2[[2]]["cites-quota"])) == TRUE) {
      message("no current quotas in place for this species")
    } else {}
    if (type == "suspension" & is.null(unlist(temp2[[3]]["cites-suspension"])) == TRUE) {
      message("no current suspensions in place for this species")
    } else {}
    
    if (type == "listing") {
      listing <- xmlToDataFrame(unlist(temp2[[1]]["cites-listing"]))
      rowno <- c(1:nrow(listing))
      for (r in rowno) {
        if (colnames(listing[8]) != "party") {
        } else {
        if (is.na(listing[r,8]) == T) {
        } else {
      party <- xmlToDataFrame(unlist(temp2[[1]][[r]]["party"]))
      names(party) <- c("iso2", "name", "type")
      listing[r,8] <- as.character(party$iso2)
        }}}
      if (colnames(listing[8]) == "party") {
      listing <- listing[c(2,4,8,6,7)]
      names(listing) <- c("tax_id", "appendix", "iso2", "date", "notes")
      } else {
        listing$iso2 <- NA
        listing <- listing[c(2,4,9,6,7)]
        names(listing) <- c("tax_id", "appendix", "iso2", "date", "notes")
      }
      listing
    } else {
      
      if (type == "quota") {
        quota <- xmlToDataFrame(unlist(temp2[[2]]["cites-quota"]))
        quota[,10] <- as.character(quota[,10])
        rowno <- c(1:nrow(quota))
        for (r in rowno) {
          if (is.na(quota[r,10]) == T) {
          } else {
            geoentity <- xmlToDataFrame(unlist(temp2[[2]][[r]]["geo-entity"]))
            names(geoentity) <- c("iso2", "name", "type")
            quota[r,10] <- as.character(geoentity$iso2)
          }}
        quota <- quota[c(2,4,10,3,5)]
        quota[,1] <- as.character(quota[,1])
        quota[,2] <- as.character(quota[,2])
        quota[,4] <- as.character(quota[,4])
        quota[,5] <- as.character(quota[,5])
        names(quota) <- c("tax_id", "date", "iso2", "quota", "notes")
        quota
      } else {
        
        if (type == "suspension") {
          suspension <- xmlToDataFrame(unlist(temp2[[3]]["cites-suspension"]))
          suspension[,7] <- as.character(suspension[,7])
          suspension[,8] <- as.character(suspension[,8])
          rowno <- c(1:nrow(suspension))
          for (r in rowno) {
            if (is.na(suspension[r,7]) == T) {
            } else {
              geoentity <- xmlToDataFrame(unlist(temp2[[3]][[r]]["geo-entity"]))
              names(geoentity) <- c("iso2", "name", "type")
              suspension[r,7] <- as.character(geoentity$iso2)
            }}
          for (r in rowno) {
            if (is.na(suspension[r,8]) == T) {
            } else {
              notification <- xmlToDataFrame(unlist(temp2[[3]][[r]]["start-notification"]))
              suspension[r,8] <- as.character(notification$name)
            }}
          suspension <- suspension[c(2,4,7,8,3)]
          names(suspension) <- c("tax_id", "date", "iso2", "notification", "notes")
          suspension
          
        } else {
                message("select type of legislation: listing, quota or suspension")
          }
        }
      }

}
