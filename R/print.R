#' print
#'
#' Print the result of a Species+ API call
#'
#' @param x The result object.
#' @param ... Ignored.
#'
#' @return The JSON result.
#'
#' @importFrom jsonlite prettify toJSON
#' @export
#' @method print spp_raw

print.spp_raw <- function(x, ...) {
    print(toJSON(unclass(x), pretty = TRUE, auto_unbox = TRUE))
}


#' @describeIn print Print method for object of class `spp_taxon`
#' @export
#' @method print spp_taxon
print.spp_taxon <- function(x, ...) {

    rcites_print_title("General info:", "\n")
    rcites_print_df(x$general)

    rcites_print_title("Classification:", "\n", "\n")
    rcites_print_df(x$higher_taxa)

    rcites_print_title("Synonyms:", "\n", "\n")
    rcites_print_df(x$synonyms)

    rcites_print_title("Common names:", "\n", "\n")
    rcites_print_df(x$common_names)

    cat("\nInformation available:", paste(paste0("$", names(x)), collapse = ", "),
        "\n")
}


#' @describeIn print Print method for object of class `spp_eu_leg`
#' @export
#' @method print spp_eu_leg
print.spp_eu_leg <- function(x, ...) {

    rcites_print_title("EU listings ($eu_listings):", "\n")
    rcites_print_df_rm(x$eu_listings, col_rm = c("annotation", "hash_annotation"))

    rcites_print_title("EU decisions ($eu_decisions):", "\n", "\n")
    npr <- c("notes", "eu_decision_type.description", "start_event.url")
    rcites_print_df_rm(x$eu_decisions, col_rm = npr)
}


#' @describeIn print Print method for object of class `spp_cites_leg`
#' @export
#' @method print spp_cites_leg
print.spp_cites_leg <- function(x, ...) {

    rcites_print_title("Cites listings ($cites_listings):", "\n")
    rcites_print_df_rm(x$cites_listings, col_rm = c("annotation", "hash_annotation"))

    rcites_print_title("Cites quotas ($cites_quotas):", "\n", "\n")
    rcites_print_df_rm(x$cites_quotas, col_rm = c("notes", "url"))

    rcites_print_title("Cites suspensions ($cites_suspensions):", "\n",
        "\n")
    rcites_print_df_rm(x$cites_suspensions, col_rm = c("notes", paste0("start_notification.",
        c("name", "date", "url"))))
}



#' @describeIn print Print method for object of class `spp_refs`
#' @export
#' @method print spp_refs
print.spp_refs <- function(x, ...) {
    rcites_print_title("References ($references):", "\n")
    rcites_print_df(x$references)
}


#' @describeIn print Print method for object of class `spp_refs`
#' @export
#' @method print spp_refs
print.spp_distr <- function(x, ...) {
    rcites_print_title("Distributions ($distributions):", "\n")
    rcites_print_df(x$distributions)

    rcites_print_title("References ($references):", "\n", "\n")
    rcites_print_df_rm(x$references)
}
