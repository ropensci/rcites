#' Access legislation data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token.
#' The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}. Default is set to \code{NULL} and require the environment variable \code{SPPPLUS_TOKEN} to be set directly in \code{.Renviron} or for the session using \code{sppplus_login()}.
#' @param type vector of character strings indicating type of legislation information requested, values are taken among \code{listing}, \code{quota} and \code{suspension}. Default includes the three of them.
#' @param simplify a logical. Should the output be simplified? In other words, should columns of data.table objects returned be unlisted when they are actualist list made of single elements?
#'
#' @return A list of data.table objects, one per type requested.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/cites_legislation/index.html}
#'
#' @importFrom data.table as.data.table rbindlist
#' @export
#'
#' @examples
#' # not run
#' # res1 <- taxon_cites_legislation(tax_id = '4521')
#' # res2 <- taxon_cites_legislation(tax_id = '4521', type ='listings')
#' #

taxon_cites_legislation <- function(tax_id, token = NULL, type = c("listings", "quotas", 
    "suspensions"), simplify = FALSE) {
    # check token
    if (is.null(token)) 
        token = sppplus_getsecret()
    # 
    stopifnot(all(type %in% c("listings", "quotas", "suspensions")))
    type <- unique(type)
    nmt <- c("listings", "quotas", "suspensions")
    # 
    q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/cites_legislation.json"))
    res <- sppplus_res(q_url, token)
    # output
    out <- lapply(res, function(x) "")
    if ("listings" %in% type) {
        out[[1L]] <- rbindlist(lapply(res[[1L]], as.data.table), TRUE, TRUE)
        if (simplify) 
            lapply(out[1L], sppplus_simplify)
    }
    ## 
    for (i in 2:3) {
        if (nmt[i] %in% type) {
            out[[i]] <- as.data.table(do.call(rbind, (lapply(res[[i]], rbind))))
            if (simplify) 
                lapply(out[i], sppplus_simplify)
        }
    }
    # 
    out[paste0("cites_", type)]
}
