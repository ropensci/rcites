#' rcites
#'
#' A programmatic interface to the Species+ <https://speciesplus.net/> database
#' via the Species+/CITES Checklist API <https://api.speciesplus.net/>.
#'
#' @docType package
#' @name rcites
#' @keywords internal
#' @importFrom cli cat_rule cat_line col_green col_red col_blue col_yellow
"_PACKAGE"


# HELPER FUNCTIONS

################## console helper 

# https://github.com/inSileco/inSilecoMisc/blob/master/R/msgInfo.R

rcites_msg_info <- function(..., appendLF = TRUE) {
  message(col_blue(cli::symbol$info, " ", ...), appendLF = appendLF)
  invisible(paste0(...))
}

rcites_cat_done <- function() {
  message(col_green(cli::symbol$tick))
}

rcites_cat_failure <- function() {
  message(col_red(cli::symbol$cross))
}



################## General helpers

rcites_baseurl <- function() "https://api.speciesplus.net/api/v1/"

rcites_url <- function(...) {
  # print(  paste0(rcites_baseurl(), ...))
    paste0(rcites_baseurl(), ...)
}

rcites_get <- function(q_url, token, ...) {
    names(token) <- "X-Authentication-Token"
    httr::GET(httr::modify_url(q_url), httr::add_headers(token), ...)
}

rcites_res <- function(q_url, token, raw, verbose, ...) {
    con <- rcites_get(q_url, token, ...)
    suc <- httr::http_status(con)
    if (suc$category == "Success") {
      if (verbose) 
        rcites_cat_done()
      httr::content(con, "parsed", ...)
    } else {
        if (verbose) 
          rcites_cat_failure()
        httr::warn_for_status(con)
      if (raw) {
        httr::content(con, "parsed", ...)
      } else {
        # avoid conflict when merging outputs
        NULL
      }
    }
}

rcites_timestamp <- function(x) {
    # ISO 8601 format
    tm <- as.POSIXlt(x, tz = "UTC")
    curl::curl_escape(strftime(tm, "%Y-%m-%dT%H:%M:%S"))
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
        warning("The taxon concept identifier is made of digits only.")
        rcites_msg_info("Skipping '", paste0(taxon_id, "'.\n"))
        out <- TRUE
    } else out <- FALSE
    out
}

rcites_current_id <- function(x) {
  rcites_msg_info(
      "Now processing taxon_id '", x ,"'",
      paste(rep(".", 26 - nchar(x)), collapse = ""), 
      " ",
      appendLF = FALSE
    )
}


rcites_add_taxon_id <- function(x, taxon_id) {
    if (length(x)) {
        out <- cbind.data.frame(taxon_id = as.character(taxon_id), x,
          stringsAsFactors = FALSE)
    } else out <- data.frame()
    out
}


rcites_combine_lists <- function(x, taxon_id, raw) {
    wch <- !unlist(lapply(x, is.null))
    x <- Filter(Negate(is.null), x)
    cls <- class(x[[1L]])
    if (raw) {
        out <- x
        out$taxon_ids <- taxon_id[wch]
        class(out) <- c("list", "spp_raw_multi")
    } else {
        # get names
        ls_keys <- lapply(x, names)
        if (!all(unlist(lapply(ls_keys, identical, ls_keys[[1L]])))) {
            stop("Cannot combine lists with different names")
        }
        #
        for (i in seq_along(x)) {
            x[[i]] <- lapply(x[[i]], rcites_add_taxon_id, taxon_id[wch][i])
        }
        #
        out <- list()
        for (i in seq_along(ls_keys[[1L]])) {
            key <- ls_keys[[1L]][i]
            out[[key]] <- rcites_assign_class(do.call(rbind, lapply(x,
                `[[`, key)))
        }
        class(out) <- paste0(cls, "_multi", sep = "")
    }
    out
}



################# Secret helpers

# See https://cran.r-project.org/web/packes/httr/vignettes/secrets.html
rcites_getsecret <- function() {
    val <- Sys.getenv("SPECIESPLUS_TOKEN")
    if (identical(val, "")) {
        rcites_msg_info("
    `SPECIESPLUS_TOKEN` env var has not been set yet.
    A token is required to use the species + API, see
    https://api.speciesplus.net/documentation
    ")
        set_token()
        val <- rcites_getsecret()
    }
    val
}


##################### Pagination helpers

rcites_autopagination <- function(q_url, per_page, pages, tot_page, token,
    verbose = TRUE, ...) {
    out <- list()
    q_url_0 <- gsub(
        q_url,
        pattern = "page=[[:digit:]]+\\&per_page=[[:digit:]]+$",
        replacement = "")
    ##
    rcites_msg_info(
      tot_page, 
      " pages available, retrieving info from ", 
      length(pages), 
      " more"
    )
    for (i in seq_along(pages)) {
        if (verbose)
            rcites_cat_pages(pages[i])
        q_url_new <- paste0(q_url_0, "page=", pages[i], "&per_page=",
          min(per_page, 500))
        out[[i]] <- rcites_res(q_url_new, token, verbose = verbose, ...)
    }
    #
    out
}

rcites_cat_pages <- function(pag) {
  rcites_msg_info(
    "Retrieving info from page ", 
    pag, " ",
    paste(rep(".", 25 - nchar(pag)), collapse = ""), " ",
    appendLF = FALSE
  )
}

rcites_numberpages <- function(x) {
    x$total_entries %/% x$per_page + (x$total_entries %% x$per_page > 0)
}



################## Outputs helpers

# add author_year
rcites_add_author_year <- function(x) {
    if (!"author_year" %in% names(x)) {
        x["author_year"] <- NA_character_
    }
    x
}

# convert null to na recursively
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

# convert list element to data frame 
rcites_list_to_df <- function(x, name) {
  # data.frame(
    do.call(
      rbind, 
      lapply(
        x, 
        function(y) do.call(
          rbind, 
          lapply(y[[name]], as.data.frame)
        )
      )
    )
}

# assign class and reset rownames
rcites_assign_class <- function(x) {
    row.names(x) <- NULL
    class(x) <- c("tbl_df", "tbl", "data.frame")
    x
}


rcites_simplify_listings <- function(x) {
    if (!length(x)) {
      out <- data.frame()
    } else {
      # fields below may or may not be included, so there are removed
      vc_rm <- c("party", "hash_annotation", "annotation")
      tmp <- lapply(lapply(x, FUN = function(x) x[!names(x) %in% vc_rm]),
          FUN = function(y) data.frame(do.call(cbind, y),
          stringsAsFactors = FALSE))
      if (length(tmp) > 1) {
          out <- do.call(rbind, tmp)
      } else out <- tmp[[1L]]
    }
    #
    out <- rcites_to_logical(out)
    out <- rcites_assign_class(out)
    out
}

rcites_simplify_decisions <- function(x) {
    tmp0 <- lapply(lapply(x, rcites_null_to_na), unlist)
    out <- data.frame(do.call(rbind, lapply(tmp0,
        function(y) data.frame(rbind(y), stringsAsFactors = FALSE))),
        stringsAsFactors = FALSE)
    #
    out <- rcites_to_logical(out)
    out <- rcites_assign_class(out)
    out
}

rcites_simplify_distributions <- function(x) {
    tmp <- as.data.frame(
        do.call(rbind, lapply(lapply(x, rcites_null_to_na), rbind)),
        stringsAsFactors = FALSE
    )
    tmp1 <- tmp[!names(tmp) %in% c("tags", "references")]
    out <- list()
    out$distributions <- as.data.frame(lapply(tmp1, unlist),
        stringsAsFactors = FALSE)
    # collapse tags
    out$distributions$tags <- unlist(lapply(tmp$tags,
        function(x) ifelse(length(x), paste(unlist(x), collapse = ", "), "")
    ))
    out$distributions <- rcites_assign_class(out$distributions)
    # references
    tmp2 <- tmp$references
    if (nrow(out$distributions)) {
      out$references <- data.frame(
          id = rep(out$distributions$id,
          unlist(lapply(tmp2, length))),
          reference = unlist(tmp2), stringsAsFactors = FALSE)
      out$references <- rcites_assign_class(out$references)
    } else out$references <- data.frame()
    #
    out
}




################ print helpers

rcites_print_shorten <- function(x, stop = 20) {
    unlist(lapply(x, function(y) ifelse(nchar(y) > (stop + 5),
      paste0(substring(y, 1, stop), " [truncated]"), y)))
}

rcites_print_title <- function(x, after, before) {
    cat_line()
    cat_rule(x, col = "blue")
}

rcites_print_df <- function(x, nrows = 10) {
  if (nrow(x)) {
    if ("tibble" %in% .packages()) {
        # tibble truncates the outputs already
        print(x)
    } else {
        tmp <- min(nrow(x), nrows)
        print(x[seq_len(tmp), , drop = FALSE])
        if (tmp < nrow(x))
            cat("-------truncated-------\n")
    }
  } else {
      cat(col_yellow("No records available.\n"))
  }
}

rcites_print_df_rm <- function(x, col_rm = "", nrows = 10) {
  
  if (nrow(x)) {
    rcites_print_df(x[, !names(x) %in% col_rm])
    id <- which(col_rm %in% names(x))
    if (length(id))
        cat("Field(s) not printed: ", paste(col_rm[id], collapse = ", "), "\n")
  } else {
      cat(col_yellow("No records available.\n"))
  }
  
}

rcites_print_taxon_id <- function(x, max_print = 20) {
    rcites_print_title("Taxon identifiers:")
    tmp <- unique(x)
    if (length(tmp) > max_print) {
        cat(paste(tmp[seq_len(max_print - 1)], collapse = ", "), "[tuncated]\n")
    } else cat(paste(tmp, collapse = ", "), "\n")
}



############################# spp_taxonconcept() helpers

rcites_taxonconcept_request <- function(x, taxonomy, with_descendants,
    page, per_page, updated_since = NULL, language = NULL) {
    # deal with whitespace
    tmp <- curl::curl_escape(as.character(x))
    #
    query <- ifelse(tmp == "", "", paste0("name=", tmp))
    taxo <- ifelse(taxonomy == "CMS", "taxonomy=CMS", "")
    #
    wdes <- ifelse(with_descendants, "with_descendants=true", "")
    lng <- ifelse(is.null(language), "", paste0("language=", paste(language,
        collapse = ",")))
    tim <- ifelse(is.null(updated_since), "", paste0("updated_since=",
        rcites_timestamp(updated_since)))
    #
    pag <- paste0("page=", page, "&per_page=", min(per_page, 500))
    #
    ele <- c(query, wdes, taxo, tim, lng, pag)
    # output
    rcites_url("taxon_concepts.json?", paste(ele[ele != ""], collapse = "&"))
}

rcites_taxonconcept_allentries <- function(x, sp_nm) {
    tmp <- lapply(lapply(x, function(x) x[!names(x) %in% sp_nm]), unlist)
    # author_year may be missing and we want to keep it here
    tmp2 <- lapply(tmp, rcites_add_author_year)
    #
    tmp <- lapply(tmp2, function(x) x[names(tmp2[[1L]])])
    #
    data.frame(do.call(rbind, tmp), stringsAsFactors = FALSE)
}

rcites_taxonconcept_higher_taxa <- function(x, identifier) {
    tmp <- lapply(
      lapply(x, rcites_null_to_na),
      function(y) unlist(y$higher_taxa)
    )
    wch <- which(lapply(tmp, length) > 0)
    #
    out <- data.frame(id = identifier[wch], do.call(rbind, tmp[wch]),
      stringsAsFactors = FALSE)
    out <- rcites_assign_class(out)
    out
}


rcites_taxonconcept_names <- function(x, name, identifier) {
    out <- rcites_list_to_df(x, name)
    if (!is.null(out)) {
      if (! "id" %in% names(out)) {
          nbr <- unlist(lapply(x, function(y) length(y[[name]])))
          ids <- unlist(lapply(x, function(y) y$id))
          # NB sometimes several synonyms are given seprated by a virgule, 
          # sometimes the d is repeasted
          out <- cbind(id = rep.int(ids, nbr), out)
      }
    } else out <- data.frame()
    out <- rcites_assign_class(out)
    out
}

rcites_party <- function(x) {
    if (is.na(x[1L])) {
      out <- rep(NA_character_, 3)
    } else out <- unlist(x)
    out
}

rcites_taxonconcept_cites_listings <- function(x, identifier) {
    # extract cites_listings
    ls_cl <- lapply(lapply(x, rcites_null_to_na), function(x) x$cites_listings)
    wch <- unlist(lapply(ls_cl, function(x) length(x) > 0))
    ##
    if (sum(wch)) {
      tmp <- lapply(
        Filter(Negate(is.null), ls_cl),
        function(y) do.call(rbind, y)
      )
      tmp2 <- do.call(rbind, lapply(tmp, as.data.frame))
      ## collapse hash_annotation
      tmp2$hash_annotation <- lapply(tmp2$hash_annotation, paste, collapse = "")
      ## Deal with party
      party_all <- as.data.frame(
        do.call(rbind, lapply(tmp2$party, rcites_party)))
      row.names(party_all) <- NULL
      colnames(party_all) <- paste0('party_', colnames(party_all))
      ##
      tmp3 <- cbind(tmp2[! names(tmp2) %in% c("party")] , party_all)
      out <- data.frame(
          id = rep(identifier[wch], unlist(lapply(tmp, nrow))),
          apply(tmp3, 2, unlist),
          stringsAsFactors = FALSE
        )
    } else out <- data.frame()
    ## output
    out <- rcites_assign_class(out)
    out
}
