#' citesr:
#'
#' An R package to access the CITES Species+ database (https://speciesplus.net/)
#'
#' @docType package
#' @author Jonas Geschke et al.
#' @name citesr

spplus_baseurl <- function() "https://api.speciesplus.net/api/v1/"

sppplus_url <- function(what) {
    paste0(spplus_baseurl(), what)
}

sppplus_get <- function(q_url, token) {
    names(token) <- "X-Authentication-Token"
    httr::GET(q_url, httr::add_headers(token))
}

sppplus_res <- function(q_url, token) {
    con <- sppplus_get(q_url, token)
    # check status
    stop_for_status(con)
    # parsed
    content(con, "parsed")
}

sppplus_simplify <- function(x) {
    for (i in 1:ncol(x)) {
        tmp <- class(x[[i]][[1L]])
        if (tmp != "list") 
            data.table::set(x, j = i, value = methods::as(x[[i]], tmp))
    }
    invisible(NULL)
}

# https://cran.r-project.org/web/packages/httr/vignettes/secrets.html
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
