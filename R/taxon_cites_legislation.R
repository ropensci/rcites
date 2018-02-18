#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token.
#' The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}.
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#'
#' @return If type is one of listing, quota or suspension, returns a dataframe with respective information from the Species+ database. If type is all, returns a list with all Species+ database information.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/cites_legislation/index.html}
#'
#' @importFrom httr content stop_for_status
#' @importFrom data.table as.data.table rbindlist
#' @export
#'
#' @examples
#' # taxon_cites_legislation(token, tax_id = '4521')

taxon_cites_legislation <- function(token, tax_id) {
    # 
    url <- build_url(what = paste0("taxon_concepts/", tax_id, "/cites_legislation.json"))
    con <- sppplus_get(url, token)
    # check status
    stop_for_status(con)
    # parsed
    res <- content(con, "parsed")
    
    # output
    out <- as.list(rep("", length(res)))
    names(out) <- names(res)
    out[[1L]] <- rbindlist(lapply(res[[1L]], as.data.table), T, T)
    for (i in 2:3) out[[i]] <- as.data.table(do.call(rbind, (lapply(res[[i]], rbind))))
    # 
    out
}
