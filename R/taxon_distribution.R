#' Get distributions data available for a given taxon concept.
#'
#' Retrieve distributions data available for a given taxon concept for which the
#' the taxon identifier is known.
#'
#' @param tax_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{sppplus_taxonconcept}}).
#' @param collapse_tags a string used to collapse tags. Default is set to \code{NULL} meaning that tags column's elements remains lists.
#' @param simplify a logical. Should the output be simplified? In other words,
#' should columns of data.table objects returned be unlisted when they are
#' lists made of single elements?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPPPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{sppplus_login()} can
#' be used to set \code{SPPPLUS_TOKEN} for the current session.
#'
#' @return A data table with all distribution information.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/distributions/index.html}
#'
#' @importFrom data.table as.data.table
#' @export
#'
#' @examples
#' \donttest{
#'  res1 <- taxon_distribution(tax_id = '4521')
#'  res2 <- taxon_distribution(tax_id = '4521', collapse_tags = ' + ', simplify = T)
#' }

taxon_distribution <- function(tax_id, collapse_tags = NULL, simplify = FALSE, token = NULL) {
    # token check
    if (is.null(token)) 
        token = sppplus_getsecret()
    # 
    q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/distributions.json"))
    res <- sppplus_res(q_url, token)
    # get a data.table; tags and references are lists.
    out <- as.data.table(do.call(rbind, lapply(res, rbind)))
    if (!is.null(collapse_tags)) 
        out$tags <- lapply(out$tags, function(x) if (length(x) > 0) 
            paste(unlist(x), collapse = collapse_tags))
    ## 
    if (isTRUE(simplify)) 
        sppplus_simplify(out)
    # output
    out
}
