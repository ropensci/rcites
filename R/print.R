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


#' @describeIn print Print method for object of class spp_taxon
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

    # add a note of what's available
}


#' @describeIn print Print method for object of class spp_eu_leg
#' @export
#' @method print spp_eu_leg
print.spp_eu_leg <- function(x, ...) {

    cat("EU Listings:\n")
    rcites_print_df(x$eu_listings[, names(x$eu_listings) != "annotation"])
    cat("Field not printed: `annotation`\n")

    cat("\nEU decisions:\n")
    npr <- c("notes", "eu_decision_type.description", "start_event.url")
    rcites_print_df(x$eu_decisions[, !names(x$eu_decisions) %in% npr])
    id <- which(npr %in% names(x$eu_decisions))
    if (length(id)) cat("Field(s) not printed: ", paste(npr[id], collapse = ", "), "\n")
    # add a note of what's available
}
