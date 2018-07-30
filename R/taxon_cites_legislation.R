#' Get current CITES appendix listings and reservations.
#'
#' Retrieve current CITES appendix listings and reservations, CITES quotas, and
#' CITES suspensions for a given taxon concept.
#'
#' @param tax_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{sppplus_taxonconcept}}).
#' @param type vector of character strings indicating type of legislation information requested, values are taken among \code{listing}, \code{quota} and \code{suspension}. Default includes the three of them.
#' @param simplify a logical. Should the output be simplified? In other words,
#' should columns of data.table objects returned be unlisted when they are
#' lists made of single elements?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPPPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{sppplus_login()} can
#' be used to set \code{SPPPLUS_TOKEN} for the current session.
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
#' \donttest{
#' res1 <- taxon_cites_legislation(tax_id = '4521')
#' res2 <- taxon_cites_legislation(tax_id = '4521', type ='listings')
#' }

taxon_cites_legislation <- function(tax_id, type = c("listings", "quotas", "suspensions"), 
    simplify = FALSE, token = NULL) {
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
        if (isTRUE(simplify)) 
            lapply(out[1L], sppplus_simplify)
    }
    ## 
    for (i in 2:3) {
        if (nmt[i] %in% type) {
            out[[i]] <- as.data.table(do.call(rbind, (lapply(res[[i]], rbind))))
            if (isTRUE(simplify)) 
                lapply(out[i], sppplus_simplify)
        }
    }
    # 
    out[paste0("cites_", type)]
}
