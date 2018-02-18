#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token. The query string
#' filters species+ data by taxon concept (e.g. species, genus, class)
#'
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}.
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#'
#' @return If type is one of taxonomic or distribution, returns a dataframe with respective references from the Species+ database. If type is distribution, check \code{\link[citesr]{taxon_distribution}} for country notes.
#'
#' @importFrom httr content stop_for_status
#' @importFrom data.table as.data.table
#' @export
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/references/index.html}
#'
#' @examples
#' # taxon_references(token, tax_id = '4521')

taxon_references <- function(token, tax_id = "4521") {
    # 
    q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/references.json"))
    res <- sppplus_res(q_url, token)
    # output
    as.data.table(do.call(rbind, lapply(res, rbind)))
}
