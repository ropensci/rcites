#' Print methods for objects of class `spp_raw*`.
#'
#' Print the outputs of a Species+ API call.
#'
#' @param x an object of class `spp_raw*`.
#' @param ... ignored.
#'
#' @return The JSON result.
#'
#' @name print.spp
NULL

#' @rdname print.spp
#' @method print spp_raw
#' @export
print.spp_raw <- function(x, ...) {
    print(jsonlite::toJSON(unclass(x), pretty = TRUE, auto_unbox = TRUE))
    invisible(NULL)
}

#' @rdname print.spp
#' @method print spp_raw_multi
#' @export
print.spp_raw_multi <- function(x, ...) {
    print.spp_raw(x)
    cat_line()
    rcites_print_taxon_id(x$taxon_ids)
    cat_line()
    invisible(NULL)
}

#' @rdname print.spp
#' @method print spp_cites_leg
#' @export
print.spp_cites_leg <- function(x, ...) {

    rcites_print_title("Cites listings ($cites_listings):")
    rcites_print_df_rm(x$cites_listings,
      col_rm = c("annotation", "hash_annotation"))

    rcites_print_title("Cites quotas ($cites_quotas):")
    rcites_print_df_rm(x$cites_quotas, col_rm = c("notes", "url"))

    rcites_print_title("Cites suspensions ($cites_suspensions):")
    rcites_print_df_rm(x$cites_suspensions, col_rm = c("notes",
        paste0("start_notification.", c("name", "date", "url"))))

    invisible(NULL)
}

#' @method print spp_cites_leg_multi
#' @rdname print.spp
#' @export
print.spp_cites_leg_multi <- function(x, ...) {
    rcites_print_taxon_id(x$cites_listings$taxon_id)
    cat_line()
    print.spp_cites_leg(x)
    invisible(NULL)
}


#' @method print spp_distr
#' @rdname print.spp
#' @export
print.spp_distr <- function(x, ...) {
    rcites_print_title("Distributions ($distributions):")
    rcites_print_df(x$distributions)

    rcites_print_title("References ($references):")
    x$references$reference <- rcites_print_shorten(x$references$reference)
    rcites_print_df_rm(x$references)
    invisible(NULL)
}

#' @method print spp_distr_multi
#' @rdname print.spp
#' @export
print.spp_distr_multi <- function(x, ...) {
    rcites_print_taxon_id(x$distributions$taxon_id)
    cat_line()
    print.spp_distr(x)
    invisible(NULL)
}


#' @method print spp_eu_leg
#' @rdname print.spp
#' @export
print.spp_eu_leg <- function(x, ...) {

    rcites_print_title("EU listings ($eu_listings):")
    rcites_print_df_rm(x$eu_listings,
      col_rm = c("annotation", "hash_annotation"))

    rcites_print_title("EU decisions ($eu_decisions):")
    npr <- c("notes", "eu_decision_type.description", "start_event.url")
    rcites_print_df_rm(x$eu_decisions, col_rm = npr)
    invisible(NULL)
}

#' @method print spp_eu_leg_multi
#' @rdname print.spp
#' @export
print.spp_eu_leg_multi <- function(x, ...) {
    rcites_print_taxon_id(x$eu_listings$taxon_id)
    cat_line()
    print.spp_eu_leg(x)
    invisible(NULL)
}



#' @method print spp_refs
#' @rdname print.spp
#' @export
print.spp_refs <- function(x, ...) {
    rcites_print_title("References ($references):")
    x$references$citation <- rcites_print_shorten(x$references$citation,
        40)
    rcites_print_df(x$references)
    invisible(NULL)
}

#' @method print spp_refs_multi
#' @rdname print.spp
#' @export
print.spp_refs_multi <- function(x, ...) {
    rcites_print_taxon_id(x$references$taxon_id)
    cat_line()
    print.spp_refs(x)
    invisible(NULL)
}


#' @method print spp_taxon
#' @rdname print.spp
#' @export
print.spp_taxon <- function(x, ...) {
    gen <- paste0("General info - ", attributes(x)$taxonomy, " ($general):")
    rcites_print_title(gen)
    rcites_print_df(x$general)

    rcites_print_title("Classification ($higher_taxa):")
    rcites_print_df(x$higher_taxa)

    rcites_print_title("Synonyms ($synonyms):")
    rcites_print_df(x$synonyms)

    rcites_print_title("Common names ($common_names):")
    rcites_print_df(x$common_names)

    cat("\nInformation available:",
      paste(paste0("$", names(x)), collapse = ", "), "\n")
    invisible(NULL)
}
