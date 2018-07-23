#' rcites:
#'
#' A programmatic interface to the Species+ <https://speciesplus.net/> database
#' via the Species+/CITES Checklist API <https://api.speciesplus.net/>.
#'
#' @docType package
#' @name rcites

## Helper functions

sppplus_baseurl <- function() "https://api.speciesplus.net/api/v1/"

# 
sppplus_url <- function(what) {
    paste0(sppplus_baseurl(), what)
}

# 
sppplus_get <- function(q_url, token) {
    names(token) <- "X-Authentication-Token"
    httr::GET(q_url, httr::add_headers(token))
}

# 
sppplus_res <- function(q_url, token) {
    con <- sppplus_get(q_url, token)
    # check status
    httr::stop_for_status(con)
    # parsed
    httr::content(con, "parsed")
}

# See https://cran.r-project.org/web/packes/httr/vignettes/secrets.html
sppplus_getsecret <- function() {
    val <- Sys.getenv("SPPPLUS_TOKEN")
    if (identical(val, "")) {
        message("
    `SPPPLUS_TOKEN` env var has not been set.
    A token is required to use the species + API, see
    https://api.speciesplus.net/documentation
    ")
        sppplus_login()
    }
    val
}

# 
sppplus_forgetsecret <- function() Sys.unsetenv("SPPPLUS_TOKEN")
