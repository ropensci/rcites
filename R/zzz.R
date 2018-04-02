#' citesr:
#'
#' An R package to access the CITES Species+ database (https://speciesplus.net/)
#'
#' @docType package
#' @name citesr

sppplus_baseurl <- function() "https://api.speciesplus.net/api/v1/"

sppplus_url <- function(what) {
    paste0(sppplus_baseurl(), what)
}

sppplus_get <- function(q_url, token) {
    names(token) <- "X-Authentication-Token"
    httr::GET(q_url, httr::add_headers(token))
}

sppplus_res <- function(q_url, token) {
    con <- sppplus_get(q_url, token)
    # check status
    httr::stop_for_status(con)
    # parsed
    httr::content(con, "parsed")
}


# https://cran.r-project.org/web/packes/httr/vignettes/secrets.html
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

sppplus_login <- function(token = NULL) {
    if (is.null(token)) 
        token <- readline("Enter your token: ")
    Sys.setenv(SPPPLUS_TOKEN = token)
    if (identical(token, "")) {
        message("Token is still missing!")
    } else cat("Authentication token stored for the session.\n")
    invisible(NULL)
}
