#' Access legislation data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token.
#' The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}. Default is set to \code{NULL} and require the environment variable \code{SPPPLUS_TOKEN} to be set directly in \code{.Renviron} or for the session using \code{sppplus_login()}.
#' @param type vector of character strings indicating type of legislation information requested, values are taken among \code{listing}, \code{quota} and \code{suspension}. Default includes the three of them.
#'
#' @return A list of the data.table requested.
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
#' # taxon_cites_legislation(token, tax_id = '4521', type ='listings')

taxon_cites_legislation <- function(token = NULL, tax_id, type = c("listings", "quotas", 
    "suspensions")) {
    # token check
    if (is.null(token)) 
        token = sppplus_getsecret()
    # 
    type <- unique(type)
    stopifnot(all(type %in% c("listings", "quotas", "suspensions")))
    # 
    q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/cites_legislation.json"))
    res <- sppplus_res(q_url, token)
    # output
    out <- lapply(res, function(x) "")
    out[[1L]] <- rbindlist(lapply(res[[1L]], as.data.table), T, T)
    for (i in 2:3) out[[i]] <- as.data.table(do.call(rbind, (lapply(res[[i]], rbind))))
    ## 
    out[paste0("cites_", type)]
}
