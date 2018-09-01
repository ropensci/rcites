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

    cat("General info:\n")
    rcites_print_df(x$general)

    cat("\nClassification info:\n")
    rcites_print_df(x$higher_taxa)

    cat("\nSynonyms:\n")
    rcites_print_df(x$synonyms)

    cat("\nCommon names:\n")
    rcites_print_df(x$common_names)

    cat("\nInformation available:", paste(paste0("$", names(x)), collapse = ", "), 
        "\n")
    # add a note of what's available
}


#' @describeIn print Print method for object of class `spp_eu_leg`
#' @export
#' @method print spp_eu_leg
print.spp_eu_leg <- function(x, ...) {

    cat("EU listings ($eu_listings):\n")
    rcites_print_df_rm(x$eu_listings, col_rm = c("annotation", "hash_annotation"))

    cat("\nEU decisions ($eu_decisions):\n")
    npr <- c("notes", "eu_decision_type.description", "start_event.url")
    rcites_print_df_rm(x$eu_decisions, col_rm = npr)
    # add a note of what's available
}


#' @describeIn print Print method for object of class `spp_cites_leg`
#' @export
#' @method print spp_cites_leg
print.spp_cites_leg <- function(x, ...) {

    cat("Cites listings ($cites_listings):\n")
    rcites_print_df_rm(x$cites_listings, col_rm = c("annotation", "hash_annotation"))

    cat("\nCites quotas ($cites_quotas):\n")
    rcites_print_df_rm(x$cites_quotas, col_rm = c("notes", "url"))

    cat("\nCites suspensions ($cites_suspensions):\n")
    rcites_print_df_rm(x$cites_suspensions, col_rm = c("notes", paste0("start_notification.",
        c("name", "date", "url"))))
}



#' @describeIn print Print method for object of class `spp_refs`
#' @export
#' @method print spp_refs
print.spp_refs <- function(x, ...) {
    cat("References ($references):\n")
    rcites_print_df(x$references)
}


#' @describeIn print Print method for object of class `spp_refs`
#' @export
#' @method print spp_refs
print.spp_distr <- function(x, ...) {
    cat("Distributions ($distributions):\n")
    rcites_print_df(x$distributions)

    cat("\nReferences ($references):\n")
    rcites_print_df_rm(x$references)
}
