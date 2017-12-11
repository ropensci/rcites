#' Creates a connection.
#'
#' Setup a connection to CITES with API token.
#'
#' @param url The base URL to connect to. Default value:
#' @param token The user token
#'
#' @return connect returns a connection object for CITES.
#' This connection object can be used to discover and access to resources.
#' @export
#' @examples
#' cnx <- sppplus_connect(token = 'ErJcYxUsIApHLCLOxiJ1Zwtt')

sppplus_connect <- function(url = "https://api.speciesplus.net/api/v1/taxon_concepts.xml?name=",
    token) {
    # check URL is up
    urlbase <- httr::handle(url)
    rping <- httr::GET(handle = urlbase, path = "ping")
    # save credentials.
    list(url, token)
}
