#' Get current EU annex listings, SRG opinions, and EU suspensions.
#'
#' Retrieve current EU annex listings, SRG opinions, and EU suspensions for a
#' given taxon concept (identifier must be known).
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
#' @param scope vector of character strings indicating the time scope of legislation,
#' values are taken among \code{current}, \code{historic} and \code{all}.
#' Default is \code{current}.
#' @param language vector of character strings indicating the language for the
#' text of legislation notes, values are taken among \code{en} (English),
#' \code{fr} (French) and \code{es} (Spanish). Default is \code{en}.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPECIESPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{set_token()} can
#' be used to set \code{SPECIESPLUS_TOKEN} for the current session.
#'
#' @return A list of objects, one per type requested.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/eu_legislation/index.html}
#'
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_eu_legislation(taxon_id = '4521')
#' res2 <- spp_eu_legislation(taxon_id = '4521', scope = 'historic')
#' res3 <- spp_eu_legislation(taxon_id = '4521', scope = 'all', language='fr')
#' }

spp_eu_legislation <- function(taxon_id, scope = "current", language = "en",
    raw = FALSE, token = NULL) {
    ## token check
    if (is.null(token))
        token <- rcites_getsecret()
    ## create query_string
    query_string <- paste(c(rcites_lang(language), rcites_scope(scope)),
        collapse = "&")
    if (query_string != "")
        query_string <- paste0("?", query_string)
    ## create url
    q_url <- rcites_url("taxon_concepts/", taxon_id, "/eu_legislation.json",
        query_string)
    ## get_res
    tmp <- rcites_res(q_url, token)

    ## outputs
    if (raw) {
        out <- tmp
        class(out) <- c("list", "spp_raw")
    } else {
        out <- list()
        out$eu_listings <- rcites_simplify_listings(tmp$eu_listings)
        out$eu_decisions <- rcites_simplify_decisions(tmp$eu_decisions)
        class(out) <- c("spp_eu_leg")
    }
    ##
    out
}
