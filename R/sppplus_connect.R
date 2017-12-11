#' Create CITES species+ connection details
#'
#' Creates the connection for future CITES species+ query.
#' Generate your own API token from Species+ API dashboard \url{https://api.speciesplus.net}
#'
#' @param url The base URL to connect to. Default value is the Taxon connect API: \url{\https://api.speciesplus.net/api/v1/taxon_concepts.xml?name=}
#' @param token Your species+ API authentication token
#'
#' @return Returns a list of credentials for accessing CITES species+ API. The list contains the URL and token.
#' @export
#' @examples
#' # Not run: #
#' # cnx <- sppplus_connect(token = 'insert your token here')

sppplus_connect <- function(url = "https://api.speciesplus.net/api/v1/", token) {
    # check URL is up Not sure how to check that... urlbase <- httr::handle(url)
    # rping <- httr::GET(handle = urlbase, path = 'ping') message(paste('API status =
    # ', rping$status_code)) save credentials.
    list(url, token)
}
