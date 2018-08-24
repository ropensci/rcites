#' rcites
#'
#' A programmatic interface to the Species+ <https://speciesplus.net/> database
#' via the Species+/CITES Checklist API <https://api.speciesplus.net/>.
#'
#' @docType package
#' @name rcites
#' @keywords internal
"_PACKAGE"

## Helper functions

rcites_baseurl <- function() "https://api.speciesplus.net/api/v1/"

# 
rcites_url <- function(what) {
    paste0(rcites_baseurl(), what)
}

# 
rcites_get <- function(q_url, token) {
    names(token) <- "X-Authentication-Token"
    httr::GET(q_url, httr::add_headers(token))
}

# 
rcites_res <- function(q_url, token) {
    con <- rcites_get(q_url, token)
    # check status
    httr::stop_for_status(con)
    # parsed
    httr::content(con, "parsed")
}

# See https://cran.r-project.org/web/packes/httr/vignettes/secrets.html
rcites_getsecret <- function() {
    val <- Sys.getenv("SPECIESPLUS_TOKEN")
    if (identical(val, "")) {
        message("
    `SPECIESPLUS_TOKEN` env var has not been set.
    A token is required to use the species + API, see
    https://api.speciesplus.net/documentation
    ")
        set_token()
    }
    val
}

# 
rcites_forgetsecret <- function() Sys.unsetenv("SPECIESPLUS_TOKEN")

# 
rcites_specialcase <- function(x, case) {
    out <- do.call(rbind.data.frame, lapply(x, function(y) do.call(cbind.data.frame, 
        y)))
    if ("date" %in% names(out)) 
        out$date <- as.Date(out$date)
    names(out) <- paste0(case, "_", names(out))
    out
}
