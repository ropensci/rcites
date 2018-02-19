#' Access to EU legislation data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token.
#'
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}.
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param type vector of character strings indicating type of legislation information requested, values are taken among \code{listing}, \code{quota} and \code{suspension}. Default includes the three of them.
#' @param simplify a logical. Should the output be simplified? In other words should columns of data.table objects be unlisted when possible?
#'
#' @return A list of one or two data.tables.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/eu_legislation/index.html}
#'
#' @importFrom httr content stop_for_status
#' @importFrom data.table as.data.table
#' @export
#'
#' @examples
#' # taxon_eu_legislation(token, tax_id = '4521')
#' # taxon_eu_legislation(token, tax_id = '4521', type ='listings')

taxon_eu_legislation <- function(token, tax_id, type = c("listings", "decisions"), 
    simplify = FALSE) {
    # 
    type <- unique(type)
    stopifnot(all(type %in% c("listings", "decisions")))
    # 
    q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/eu_legislation.json"))
    res <- sppplus_res(q_url, token)
    # output
    out <- lapply(res, function(x) as.data.table(do.call(rbind, (lapply(x, rbind)))))
    ## 
    out <- out[paste0("eu_", type)]
    ## 
    if (simplify) 
        lapply(out, sppplus_simplify)
    ## 
    out
}
