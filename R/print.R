#' Print the result of a Species+ API call
#'
#' @param x The result object.
#' @param ... Ignored.
#' @return The JSON result.
#'
#' @importFrom jsonlite prettify toJSON
#' @export
#' @method print spp_raw

print.spp_raw <- function(x, ...) {
    print(toJSON(unclass(x), pretty = TRUE, auto_unbox = TRUE))
}
