#' Get references for a given taxon concept
#'
#' Retrieve available references for a given taxon concept.
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
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
#' \url{https://api.speciesplus.net/documentation/v1/references/index.html}
#'
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_references(taxon_id = '4521')
#' }

spp_references <- function(taxon_id, raw = FALSE, token = NULL) {
    # token check
    if (is.null(token))
        token <- rcites_getsecret()
    ## create url
    q_url <- rcites_url("taxon_concepts/", taxon_id, "/references.json")
    ## get_res
    tmp <- rcites_res(q_url, token)
    ## outputs
    if (raw) {
        out <- tmp
        class(out) <- c("list", "spp_raw")
    } else {
        out <- list()
        out$references <- rcites_simplify_decisions(tmp)
        class(out) <- c("spp_cites_ref")
    }
    #
    out
}
