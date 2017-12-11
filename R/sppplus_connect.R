#' Create CITES species+ connection details
#' 
#' Creates the connection information for CITES species+ query. Takes the API token generated from Species+ API dashboard \url{https://api.speciesplus.net}
#'
#' @param url The base URL to connect to. Default value is the Taxon connect API: https://api.speciesplus.net/api/v1/taxon_concepts.xml?name=
#' @param token The species+ API authentication token
#'
#' @return Returns a list of credentials for accessing CITES species+ API. The list contains the URL and token.
#' @export 
#' @examples
#' cnx <- sppplus_connect(token = 'ErJcYxUsIApHLCLOxiJ1Zwtt')

sppplus_connect <- function(url = "https://api.speciesplus.net/api/v1/",
    token) {
    # check URL is up
    urlbase <- httr::handle(url)
    rping <- httr::GET(handle = urlbase, path = "ping")
    # save credentials.
    list(url, token)
}
