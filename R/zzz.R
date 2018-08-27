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
rcites_timestamp <- function(x) {
  # ISO 8601 format
  # https://stackoverflow.com/questions/29517896/current-time-in-iso-8601-format
  tm <- as.POSIXlt(x, tz = "UTC")
  strftime(tm , "%Y-%m-%dT%H:%M:%S")
}

#
rcites_print_df <- function(x, nrows = 10) {
  print(x[seq_len(min(nrow(x), nrows)),])
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



## helper functions for spp_taxonconcept()

rcites_taxonconcept_request <- function(x, token, taxonomy, with_descendants,
    page, per_page, updated_since = NULL, language = NULL) {
    # deal with blank space
    tmp <- gsub(pattern = " ", replacement = "%20", x = x)
    if (tmp == "") {
        query <- ""
    } else {
        query <- paste0("name=", tmp)
    }
    #
    taxo <- ifelse(taxonomy == "CMS", "taxonomy=CMS", "")
    wdes <- ifelse(with_descendants, "with_descendants=true", "")
    lng <- ifelse(is.null(language), "",
      paste0("language=", paste(language, collapse = ",")))
    tim <- ifelse(is.null(updated_since), "",
      paste0("updated_since=", rcites_timestamp(updated_since)))
    pag <- paste0("page=", page, "&per_page=", min(per_page, 500))
    #
    ele <- c(query, wdes, taxo, tim, lng, pag)
    # out_put
    rcites_url("taxon_concepts.json?", paste(ele[ele != ""], collapse = "&"))
}

rcites_taxonconcept_allentries <- function(x, sp_nm) {
    tmp <- lapply(lapply(x, function(x) x[!names(x) %in% sp_nm]), unlist)
    # author_year may be missing
    tmp2 <- lapply(tmp, rcites_addauthor)
    #
    tmp <- lapply(tmp2, function(x) x[names(tmp2[[1L]])])
    #
    data.frame(do.call(rbind, tmp))
}

rcites_taxonconcept_higher_taxa <- function(x, identifier) {
    tmp <- lapply(x, function(y) y[["higher_taxa"]])
    wch <- which(unlist(lapply(tmp, length)) > 0)
    out <- data.frame(id = identifier[wch], do.call(rbind, tmp[wch]))
    class(out) <- c("tbl_df", "tbl", "data.frame")
    out
}

rcites_taxonconcept_special_cases <- function(x, name, identifier) {
    tmp <- lapply(x, function(y) y[[name]])
    wch <- which(unlist(lapply(tmp, length)) > 0)
    tmp2 <- lapply(tmp[wch], function(x) do.call(rbind, x))
    sz <- unlist(lapply(tmp2, nrow))
    out <- data.frame(do.call(rbind, tmp2))
    if (name == "synonym") names(out)[1] <- "id_synonym"
    out <- cbind(id = rep(identifier[wch], sz), out)
    if (name == "accepted_names") names(out)[1] <- "id_synonym"
    class(out) <- c("tbl_df", "tbl", "data.frame")
    out
}
