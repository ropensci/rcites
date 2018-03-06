#' Access to EU legislation data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token.
#'
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}. Default is set to \code{NULL} and require the environment variable \code{SPPPLUS_TOKEN} to be set directly in \code{.Renviron} or for the session using \code{sppplus_login()}.
#' @param type vector of character strings indicating type of legislation information requested, values are taken among \code{listing}, \code{quota} and \code{suspension}. Default includes the three of them.
#' @param simplify a logical. Should the output be simplified? In other words should columns of data.table objects be unlisted when possible?
#'
#' @return  A list of data.table objects, one per type requested.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/eu_legislation/index.html}
#'
#' @importFrom data.table as.data.table
#' @export
#'
#' @examples
#' # res1 <- taxon_eu_legislation(tax_id = '4521')
#' # res2 <- taxon_eu_legislation(tax_id = '4521', type ='listings')

taxon_eu_legislation <- function(tax_id, token = NULL, type = c("listings", "decisions"), 
    simplify = FALSE) {
    # token
    if (is.null(token)) 
        token = sppplus_getsecret()
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
