#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token. The query string
#' filters species+ data by taxon concept (e.g. species, genus, class).
#'
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}. Default is set to \code{NULL} and require the environment variable \code{SPPPLUS_TOKEN} to be set directly in \code{.Renviron} or for the session using \code{sppplus_login()}.
#' @param collapse_tags a string used to collapse tags. Default is set to \code{NULL} meaning that tags column's elements remains lists.
#' @param simplify a logical. Should the output be simplified? In other words should columns of data.table objects be unlisted when possible?
#'
#' @return A data table with all distribution information.
#'
#' @importFrom httr content stop_for_status
#' @importFrom data.table as.data.table
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/distributions/index.html}
#'
#' @export
#'
#' @examples
#' # taxon_distribution(tax_id = '4521')
#' # taxon_distribution(tax_id = '4521', collapse_tags = ' + ')

taxon_distribution <- function(tax_id, token = NULL, collapse_tags = NULL, simplify = FALSE) {
    # token check
    if (is.null(token)) 
        token = sppplus_getsecret()
    # 
    q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/distributions.json"))
    res <- sppplus_res(q_url, token)
    # get a data.table; tags and references are lists that the user can easily to
    # access
    out <- as.data.table(do.call(rbind, lapply(res, rbind)))
    if (!is.null(collapse_tags)) 
        out$tags <- lapply(out$tags, function(x) if (length(x) > 0) 
            paste(unlist(x), collapse = collapse_tags))
    ## 
    if (simplify) 
        sppplus_simplify(out)
    # output
    out
}
