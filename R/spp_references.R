#' Get references for a given taxon concept
#'
#' Retrieve available references for a given taxon concept.
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' <https://api.speciesplus.net/documentation>. Default is set to
#' `NULL` and requires the environment variable `SPECIESPLUS_TOKEN` to be
#' set directly in `Renviron`. Alternatively, [set_token()] can be used to set
#' `SPECIESPLUS_TOKEN` for the current session.
#'
#' @return If `raw` is set to `TRUE` then an object of class `spp_raw` is returned
#' which is essentially the list of lists (see option `as = "parsed"` in [httr::content()]).
#' Otherwise an object of class `spp_refs` is returned which is a list of one
#' data frame:
#' * `references` that includes the identifier of the reference and the
#' corresponding citation.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/references/index.html}
#'
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_references(taxon_id = '4521')
#' res2 <- spp_references(taxon_id = '4521', raw = TRUE)
#' }

spp_references <- function(taxon_id, raw = FALSE, token = NULL) {
    # token check
    if (is.null(token))
        token <- rcites_getsecret()
    # id check
    rcites_checkid(taxon_id)
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
        class(out) <- c("spp_refs")
    }
    #
    out
}
