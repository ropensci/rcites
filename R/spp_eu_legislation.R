#' Get current EU annex listings, SRG opinions, and EU suspensions.
#'
#' Retrieve current EU annex listings, SRG opinions, and EU suspensions for a
#' given taxon concept (identifier must be known).
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
#' @param type vector of character strings indicating type of legislation information requested, values are taken among \code{listing}, \code{quota} and \code{suspension}. Default includes the three of them.
#' @param simplify a logical. Should the output be simplified? In other words,
#' should columns of data.table objects returned be unlisted when they are
#' lists made of single elements?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPECIESPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{set_token()} can
#' be used to set \code{SPECIESPLUS_TOKEN} for the current session.
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
#' \donttest{
#' res1 <- spp_eu_legislation(taxon_id = '4521')
#' res2 <- spp_eu_legislation(taxon_id = '4521', type ='listings')
#' res3 <- spp_eu_legislation(taxon_id = '4521', type ='listings', simplify = T)
#' }

spp_eu_legislation <- function(taxon_id, type = c("listings", "decisions"), simplify = FALSE, 
    token = NULL) {
    # token
    if (is.null(token)) 
        token <- rcites_getsecret()
    # 
    type <- unique(type)
    stopifnot(all(type %in% c("listings", "decisions")))
    # 
    q_url <- rcites_url("taxon_concepts/", taxon_id, "/eu_legislation.json")
    res <- rcites_res(q_url, token)
    # output
    out <- lapply(res, function(x) as.data.table(do.call(rbind, (lapply(x, rbind)))))
    ## 
    out <- out[paste0("eu_", type)]
    ## 
    if (isTRUE(simplify)) 
        lapply(out, rcites_simplify)
    ## 
    out
}
