require("httr")
require(RCurl)

#' Creates a connection.
#'
#' Setup a connection to CITES with API token.
#'
#' @param url The base URL to connect to. Default value: 
#' @param token The user token
#' @param username The password for the user.
#'
#' @return connect returns a connection object for CITES.
#' This connection object can be used to discover and access to resources.
#' @export
#' @examples
#' cnx <- connect("url", "user", "token")

connect <- function(url="https://api.speciesplus.net/api/v1/taxon_concepts.xml?name=",
                    token="ErJcYxUsIApHLCLOxiJ1Zwtt") {
  #check URL is up
  urlbase <- httr::handle(url)
  rping <- httr::GET(handle=urlbase, path="ping")
  #save credentials.
  list(url, token)
}

con <- connect( token = "ErJcYxUsIApHLCLOxiJ1Zwtt")

acces <- function(con = con, query = "Mammalia"){
  getURI(url = paste(con[[1]], query, sep = ""),
         httpheader = paste("X-Authentication-Token: ", con[[2]], sep = ""))
}


