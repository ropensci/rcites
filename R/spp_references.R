#' Get references for a given taxon concept
#'
#' Retrieve available references for a given taxon concept.
#'
#' @param taxon_id a vector of character strings containing species' taxon
#' concept identifiers (see [spp_taxonconcept()]).
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' <https://api.speciesplus.net/documentation>. Default is set to
#' `NULL` and requires the environment variable `SPECIESPLUS_TOKEN` to be
#' set directly in `Renviron`. Alternatively, [set_token()] can be used to set
#' `SPECIESPLUS_TOKEN` for the current session.
#' @param verbose a logical. Should extra information be reported on progress?
#' @param pause a duration (in second) to suspend execution for (see
#' [Sys.sleep()]). This was added cause the web API returns a 404 error too many
#' requests in a short time interval.
#' @param ... Further named parameters, see [httr::GET()].
#'
#' @return If `raw` is set to `TRUE` then an object of class `spp_raw` (or
#' `spp_raw_multi` if `length(taxon_id) > 1`) is returned which is essentially
#' a list of lists (see option `as = 'parsed'` in [httr::content()]).
#' Otherwise, an object of class `spp_refs` (or `spp_refs_multi` if
#' `length(taxon_id) > 1`) is returned which is a list of one
#' data frame:
#' * `references` that includes the identifier of the reference and the
#' corresponding citation.
#'
#' @references
#' <https://api.speciesplus.net/documentation/v1/references/index.html>
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # this calls will only work if a token is set and valid
#' res1 <- spp_references(taxon_id = '4521')
#' res2 <- spp_references(c('4521', '3210', '10255'))
#' res3 <- spp_references(taxon_id = '4521', raw = TRUE, verbose = FALSE,
#'  config = httr::progress())
#' }

spp_references <- function(taxon_id, raw = FALSE, token = NULL, verbose = TRUE,
    pause = 1, ...) {

    if (length(taxon_id) > 1) {
        out <- lapply(taxon_id, spp_references, raw = raw, token = token,
            verbose = verbose, pause = pause, ...)
        out <- rcites_combine_lists(out, taxon_id, raw)
    } else {
        # token check
        if (is.null(token))
            token <- rcites_getsecret()
        # id check
        if (rcites_checkid(taxon_id)) {
            out <- NULL
        } else {
            if (verbose)
                rcites_current_id(taxon_id)
            ## create url
            q_url <- rcites_url("taxon_concepts/", taxon_id, "/references.json")
            ## get_res
            tmp <- rcites_res(q_url, token, raw, verbose, ...)
            ## outputs
            if (raw) {
                out <- tmp
                class(out) <- c("list", "spp_raw")
            } else {
                out <- list()
                out$references <- rcites_simplify_decisions(tmp)
                class(out) <- c("spp_refs")
            }
        }
    }
    Sys.sleep(pause)
    out
}
