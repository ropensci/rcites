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

# auto pagination
rcites_autopagination <- function(q_url, per_page, seq_page, tot_page,
    token, verbose = TRUE) {
    out <- list()
    q_url_0 <- gsub(q_url, pattern = "page=[[:digit:]]+\\&per_page=[[:digit:]]+$",
        replacement = "")
    # grepl('\\.json?', pat = '\\.json\\?$')
    for (i in seq_along(seq_page)) {
        if (verbose)
            cat("Retrieving info from page ", seq_page[i], "/", tot_page, "\r")
        q_url_new <- paste0(q_url_0, "page=", seq_page[i], "&per_page=",
        min(per_page, 500))
        out[[i]] <- rcites_res(q_url_new, token)
    }
    if (verbose) {
        cat("\n")
        cat("Done!\n")
    }
    out
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

# add 'author_year field
rcites_addauthor <- function(x) {
    if (!"author_year" %in% names(x)) {
        x["author_year"] <- NA_character_
    }
    x
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
