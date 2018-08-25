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
rcites_url <- function(...) {
    paste0(rcites_baseurl(), ...)
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
    `SPECIESPLUS_TOKEN` env var has not been set yet.
    A token is required to use the species + API, see
    https://api.speciesplus.net/documentation
    ")
        set_token()
    }
    val
}

# 
rcites_forgetsecret <- function() Sys.unsetenv("SPECIESPLUS_TOKEN")

# pagination
rcites_numberpages <- function(x) {
    x$total_entries%/%x$per_page + (x$total_entries%%x$per_page > 0)
}


# simplify list
rcites_simplifylist_rbind <- function(x) {
    data.frame(do.call(rbind, x), stringsAsFactors = FALSE)
}

# simplify list
rcites_simplifylist_cbind <- function(x) {
    data.frame(do.call(cbind, x), stringsAsFactors = FALSE)
}

# 
rcites_specialcase <- function(x, case) {
    out <- do.call(rbind.data.frame, lapply(x, function(y) do.call(cbind.data.frame, 
        y)))
    if ("date" %in% names(out)) 
        out$date <- as.Date(out$date)
    names(out) <- paste0(case, "_", names(out))
    out
}
