#' Print methods for objects of class `spp_raw*`
#'
#' Print the outputs of a Species+ API call
#'
#' @param x An object of class `spp_raw*`.
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
}

#' @rdname print.spp
#' @method print spp_raw_multi
#' @export
print.spp_raw_multi <- function(x, ...) {
    print.spp_raw(x)
    cat("\n")
    rcites_print_taxon_id(x$taxon_ids)
    cat("\n")
}


#' @method print spp_cites_leg
#' @rdname print.spp
#' @export
print.spp_cites_leg <- function(x, ...) {

    rcites_print_title("Cites listings ($cites_listings):", "\n")
    rcites_print_df_rm(x$cites_listings,
      col_rm = c("annotation", "hash_annotation"))

    rcites_print_title("Cites quotas ($cites_quotas):", "\n", "\n")
    rcites_print_df_rm(x$cites_quotas, col_rm = c("notes", "url"))

    rcites_print_title("Cites suspensions ($cites_suspensions):", "\n",
        "\n")
    rcites_print_df_rm(x$cites_suspensions, col_rm = c("notes",
        paste0("start_notification.", c("name", "date", "url"))))
}

#' @method print spp_cites_leg_multi
#' @rdname print.spp
#' @export
print.spp_cites_leg_multi <- function(x, ...) {
    rcites_print_taxon_id(x$cites_listings$taxon_id)
    cat("\n")
    print.spp_cites_leg(x)
}


#' @method print spp_distr
#' @rdname print.spp
#' @export
print.spp_distr <- function(x, ...) {
    rcites_print_title("Distributions ($distributions):", "\n")
    rcites_print_df(x$distributions)

    rcites_print_title("References ($references):", "\n", "\n")
    x$references$reference <- rcites_print_shorten(x$references$reference)
    rcites_print_df_rm(x$references)
}

#' @method print spp_distr_multi
#' @rdname print.spp
#' @export
print.spp_distr_multi <- function(x, ...) {
    rcites_print_taxon_id(x$distributions$taxon_id)
    cat("\n")
    print.spp_distr(x)
}


#' @method print spp_eu_leg
#' @rdname print.spp
#' @export
print.spp_eu_leg <- function(x, ...) {

    rcites_print_title("EU listings ($eu_listings):", "\n")
    rcites_print_df_rm(x$eu_listings,
      col_rm = c("annotation", "hash_annotation"))

    rcites_print_title("EU decisions ($eu_decisions):", "\n", "\n")
    npr <- c("notes", "eu_decision_type.description", "start_event.url")
    rcites_print_df_rm(x$eu_decisions, col_rm = npr)
}

#' @method print spp_eu_leg_multi
#' @rdname print.spp
#' @export
print.spp_eu_leg_multi <- function(x, ...) {
    rcites_print_taxon_id(x$eu_listings$taxon_id)
    cat("\n")
    print.spp_eu_leg(x)
}



#' @method print spp_refs
#' @rdname print.spp
#' @export
print.spp_refs <- function(x, ...) {
    rcites_print_title("References ($references):", "\n")
    x$references$citation <- rcites_print_shorten(x$references$citation,
        40)
    rcites_print_df(x$references)
}

#' @method print spp_refs_multi
#' @rdname print.spp
#' @export
print.spp_refs_multi <- function(x, ...) {
    rcites_print_taxon_id(x$references$taxon_id)
    cat("\n")
    print.spp_refs(x)
}


#' @method print spp_taxon
#' @rdname print.spp
#' @export
print.spp_taxon <- function(x, ...) {
    gen <- paste0("General info - ", attributes(x)$taxonomy, " ($general):")
    rcites_print_title(gen, "\n")
    rcites_print_df(x$general)

    rcites_print_title("Classification ($higher_taxa):", "\n", "\n")
    rcites_print_df(x$higher_taxa)

    rcites_print_title("Synonyms ($synonyms):", "\n", "\n")
    rcites_print_df(x$synonyms)

    rcites_print_title("Common names ($common_names):", "\n", "\n")
    rcites_print_df(x$common_names)

    cat("\nInformation available:",
      paste(paste0("$", names(x)), collapse = ", "), "\n")
}
