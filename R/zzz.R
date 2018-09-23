#' rcites
#'
#' A programmatic interface to the Species+ <https://speciesplus.net/> database
#' via the Species+/CITES Checklist API <https://api.speciesplus.net/>.
#'
#' @docType package
#' @name rcites
#' @keywords internal
"_PACKAGE"

# Helper functions

## General helpers

rcites_baseurl <- function() "https://api.speciesplus.net/api/v1/"

rcites_url <- function(...) {
    paste0(rcites_baseurl(), ...)
}

rcites_get <- function(q_url, token) {
    names(token) <- "X-Authentication-Token"
    httr::GET(q_url, httr::add_headers(token))
}

rcites_res <- function(q_url, token) {
    con <- rcites_get(q_url, token)
    # check status
    httr::stop_for_status(con)
    # parsed
    httr::content(con, "parsed")
}

rcites_timestamp <- function(x) {
    # ISO 8601 format
    tm <- as.POSIXlt(x, tz = "UTC")
    strftime(tm, "%Y-%m-%dT%H:%M:%S")
}

rcites_lang <- function(x) {
    out <- match.arg(x, c("en", "fr", "es"))
    if (out == "en")
        out <- NULL else out <- paste0("language=", out)
    out
}

rcites_scope <- function(x) {
    out <- match.arg(x, c("current", "historic", "all"))
    if (out == "current")
        out <- NULL else out <- paste0("scope=", out)
    out
}

rcites_checkid <- function(taxon_id) {
    # id check
    if (!grepl(taxon_id, pattern = "^[0-9]*$")) {
        stop("The taxon concept identifier is made of digits only.")
    }
    invisible(NULL)
}

## Secret helpers

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

# remove secret
rcites_forgetsecret <- function() Sys.unsetenv("SPECIESPLUS_TOKEN")



## Pagination helpers

# auto pagination
rcites_autopagination <- function(q_url, per_page, pages, tot_page, token,
    verbose = TRUE) {
    out <- list()
    q_url_0 <- gsub(q_url, pattern = "page=[[:digit:]]+\\&per_page=[[:digit:]]+$",
        replacement = "")
    # grepl('\\.json?', pat = '\\.json\\?$')
    for (i in seq_along(pages)) {
        if (verbose)
            cat("Retrieving info from page ", pages[i], "/", tot_page,
                "\r")
        q_url_new <- paste0(q_url_0, "page=", pages[i], "&per_page=", min(per_page,
            500))
        out[[i]] <- rcites_res(q_url_new, token)
    }
    if (verbose) {
        cat("\nDone!\n")
    }
    out
}

#
rcites_numberpages <- function(x) {
    x$total_entries%/%x$per_page + (x$total_entries%%x$per_page > 0)
}




## Outputs helpers

# add author_year
rcites_add_author_year <- function(x) {
    if (!"author_year" %in% names(x)) {
        x["author_year"] <- NA_character_
    }
    x
}

# convert null to na
rcites_null_to_na <- function(x) {
    if (is.list(x)) {
        return(lapply(x, rcites_null_to_na))
    } else {
        return(ifelse(is.null(x), NA, x))
    }
}

# convert certain columns to logical
rcites_to_logical <- function(x) {
    vc_nm <- c("is_current", "applies_to_import", "public_display")
    id <- which(names(x) %in% vc_nm)
    if (length(id)) {
        # NB using apply here return a matrix and given the way data.frame now
        # includes matrix and list, it is not desired... so a loop
        for (i in seq_along(id)) {
            x[, id[i]] <- as.logical(x[, id[i]])
        }
    }
    x
}


# assign class and reset rownames
rcites_assign_class <- function(x) {
    row.names(x) <- NULL
    class(x) <- c("tbl_df", "tbl", "data.frame")
    x
}


#
rcites_simplify_listings <- function(x) {
    # fields below may or may not be included, so there are removed
    vc_rm <- c("party", "hash_annotation", "annotation")
    tmp <- lapply(lapply(x, FUN = function(x) x[!names(x) %in% vc_rm]),
        FUN = function(y) data.frame(do.call(cbind, y)))
    if (length(tmp) > 1) {
        out <- do.call(rbind, tmp)
    } else {
        out <- tmp[[1L]]
    }
    #
    out <- rcites_to_logical(out)
    out <- rcites_assign_class(out)
    out
}



#
rcites_simplify_decisions <- function(x) {
    # these fields may or may not be included so I removed them
    tmp0 <- lapply(lapply(x, rcites_null_to_na), unlist)
    out <- data.frame(do.call(rbind, lapply(tmp0, function(y) data.frame(rbind(y)))))
    #
    out <- rcites_to_logical(out)
    out <- rcites_assign_class(out)
    out
}

#
rcites_simplify_distributions <- function(x) {
    # these fields may or may not be included so I removed them
    tmp <- lapply(x, rcites_null_to_na)
    out <- list()
    out$distributions <- data.frame(do.call(rbind, lapply(tmp, function(y) data.frame(rbind(unlist(y[!names(y) %in%
        c("tags", "references")]))))))
    out$distributions$tags <- unlist(lapply(tmp, function(y) paste(y$tags,
        collapse = ", ")))
    out$distributions <- rcites_assign_class(out$distributions)

    tmp2 <- lapply(tmp, function(y) cbind(y[["references"]]))
    out$references <- data.frame(id = rep(out$distributions$id, unlist(lapply(tmp2,
        length))), reference = unlist(do.call(rbind, tmp2)[, 1L]))
    #
    out$references <- rcites_assign_class(out$references)
    out
}



## print helpers

rcites_print_shorten <- function(x, stop = 20) {
  unlist(
    lapply(x,
      function(y) ifelse(nchar(y) > (stop + 5),
        paste0(substring(y, 1, stop), " [...]"), y)
    )
  )
}





rcites_print_title <- function(x, after = "", before = "") {
    cat(before, x, "\n", paste(rep("-", nchar(x)), collapse = ""), after,
        sep = "")
}
#
rcites_print_df <- function(x, nrows = 10) {
    if ("tibble" %in% .packages()) {
        # tibble truncates the outputs already
        print(x)
    } else {
        tmp <- min(nrow(x), nrows)
        print(x[seq_len(tmp), ])
        if (tmp < nrow(x))
            cat("-------Truncated-------\n")
    }
}

#
rcites_print_df_rm <- function(x, col_rm = "", nrows = 10) {
    rcites_print_df(x[, !names(x) %in% col_rm])
    id <- which(col_rm %in% names(x))
    if (length(id))
        cat("Field(s) not printed: ", paste(col_rm[id], collapse = ", "),
            "\n")
}


## spp_taxonconcept() helpers

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
    lng <- ifelse(is.null(language), "", paste0("language=", paste(language,
        collapse = ",")))
    tim <- ifelse(is.null(updated_since), "", paste0("updated_since=",
        rcites_timestamp(updated_since)))
    pag <- paste0("page=", page, "&per_page=", min(per_page, 500))
    #
    ele <- c(query, wdes, taxo, tim, lng, pag)
    # out_put
    rcites_url("taxon_concepts.json?", paste(ele[ele != ""], collapse = "&"))
}

rcites_taxonconcept_allentries <- function(x, sp_nm) {
    tmp <- lapply(lapply(x, function(x) x[!names(x) %in% sp_nm]), unlist)
    # author_year may be missing
    tmp2 <- lapply(tmp, rcites_add_author_year)
    #
    tmp <- lapply(tmp2, function(x) x[names(tmp2[[1L]])])
    #
    data.frame(do.call(rbind, tmp))
}

rcites_taxonconcept_higher_taxa <- function(x, identifier) {
    tmp <- lapply(x, function(y) y[["higher_taxa"]])
    wch <- which(unlist(lapply(tmp, length)) > 0)
    out <- data.frame(id = identifier[wch], do.call(rbind, tmp[wch]))
    #
    out <- rcites_assign_class(out)
    out
}

rcites_taxonconcept_special_cases <- function(x, name, identifier) {
    tmp <- lapply(x, function(y) y[[name]])
    wch <- which(unlist(lapply(tmp, length)) > 0)
    tmp2 <- lapply(tmp[wch], function(x) do.call(rbind, x))
    sz <- unlist(lapply(tmp2, nrow))
    out <- data.frame(do.call(rbind, tmp2))
    if (name == "synonym")
        names(out)[1L] <- "id_synonym"
    out <- cbind(id = rep(identifier[wch], sz), out)
    if (name == "accepted_names")
        names(out)[1L] <- "id_synonym"
    #
    out <- rcites_assign_class(out)
    out
}
