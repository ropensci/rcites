#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token. The query string
#' filters species+ data by taxon concept (e.g. species, genus, class).
#'
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}.
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#'
#' @return If country_only is \code{TRUE}, returns a dataframe with taxon and country. If appendix_only is FALSE, returns a list with all distribution information.
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
#' # taxon_distribution(token, tax_id = '4521', country_only = TRUE)

taxon_distribution <- function(token, tax_id) {
    # 
    q_url <- sppplus_url(what = paste0("taxon_concepts/", tax_id, "/distributions.json"))
    con <- sppplus_get(q_url, token)
    # check status
    stop_for_status(con)
    # parsed
    res <- content(con, "parsed")
    # get a data.table; tags and references are lists that the user can easily to
    # access -- output
    as.data.table(do.call(rbind, lapply(res, rbind)))
}
