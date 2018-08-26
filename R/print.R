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
    print(x$general)

    cat("\n\nClassification info:\n")
    print(x$higher_taxa)

    cat("\n\nClassification info:\n")
    print(x$synonyms)

    cat("\n\nClassification info:\n")
    print(x$accepted_names, 10)
}
