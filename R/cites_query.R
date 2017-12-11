require("httr")
require("RCurl")
require("XML")

#' Access data...
#'
#' Query CITES.
#'
#' @param cnx the output of your cites_connect() function.
#' @param query a query... character
#'
#' @return xml so far...
#' 
#' @export
#' @examples
#' cnx <- cites_connect(token = "ErJcYxUsIApHLCLOxiJ1Zwtt")


cites_query <- function(cnx, query = "Smaug giganteus", appendix_only = TRUE){
  #check is a valid name
  query2 <- gsub(pattern = " ", replacement = "%20", x = query)
  temp <- getURI(url = paste(con[[1]], query2, sep = ""),
         httpheader = paste("X-Authentication-Token: ", con[[2]], sep = ""))
  temp2 <- xmlToList(temp)
  if (temp2$pagination$`total-entries`$text == "0"){
    message("species not listed in CITES")
  } else {
    if (appendix_only){
      data.frame(taxon = temp2$`taxon-concepts`$`taxon-concept`$`full-name`, 
                 cites_listing = temp2$`taxon-concepts`$`taxon-concept`$`cites-listing`)
    } else{
      temp2
    }
  }
}

cites_query(cnx, query = "Smaug giganteus", appendix_only = TRUE)
cites_query(cnx, query = "Homo sapiens", appendix_only = TRUE)

