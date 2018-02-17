#' citesr:
#'
#' An R package to access the CITES Species+ database (https://speciesplus.net/)
#'
#' @docType package
#' @author Jonas Geschke et al.
#' @name citesr

sppplus_baseurl <- function() "https://api.speciesplus.net/api/v1/"

build_url <- function(what) {
  fmt <- tolower(format)
  paste0(sppplus_baseurl(), what)
}

sppplus_get <- function(url, token) {
  names(token) <- "X-Authentication-Token"
  httr::GET(url, httr::add_headers(token))
}
