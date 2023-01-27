#' Get current CITES appendix listings and reservations
#'
#' Retrieve current CITES appendix listings and reservations, CITES quotas, and
#' CITES suspensions for a given taxon concept.
#'
#' @param taxon_id a vector of character strings containing species' taxon
#' concept identifiers (see [spp_taxonconcept()]).
#' @param scope vector of character strings indicating the time scope of
#' legislation, values are taken among `current`, `historic` and `all`. Default
#' is `current`.
#' @param language vector of character strings indicating the language for the
#' text of legislation notes, values are taken among `en` (English),
#' `fr` (French) and `es` (Spanish). Default is `en`.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' <https://api.speciesplus.net/documentation>. Default is set to
#' `NULL` and requires the environment variable `SPECIESPLUS_TOKEN` to be
#' set directly in `Renviron`. Alternatively, [set_token()] can
#' be used to set `SPECIESPLUS_TOKEN` for the current session.
#' @param verbose a logical. Should extra information be reported on progress?
#' @param pause a duration (in second) to suspend execution for (see
#' [Sys.sleep()]). This was added cause the web API returns a 404 error too many
#' requests in a short time interval.
#' @param ... Further named parameters, see [httr::GET()].
#'
#' @return If `raw` is set to `TRUE` then an object of class `spp_raw` (or
#' `spp_raw_multi` if `length(taxon_id) > 1`) is returned which is essentially
#' a list of lists (see option `as = 'parsed'` in [httr::content()]).
#' Otherwise, an object of class `spp_cites_leg` (or `spp_cites_leg_multi` if
#' `length(taxon_id)>1`) is returned which is a list of three data frames:
#'  1. `cites_listings`: lists CITES annex listings EU suspensions,
#'  2. `cites_quotas`: lists CITES quotas,
#'  3. `cites_suspensions`: lists CITES suspensions.
#'
#' @references
#' <https://api.speciesplus.net/documentation/v1/cites_legislation/index.html>
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # this calls will only work if a token is set and valid
#' res1 <- spp_cites_legislation(taxon_id = 4521)
#' res2 <- spp_cites_legislation(taxon_id = c('4521', '3210', '10255'))
#' res3 <- spp_cites_legislation(taxon_id = 4521, scope = 'all',
#' verbose = FALSE, config=httr::verbose())
#' res4 <- spp_cites_legislation(taxon_id = 4521, language = 'fr')
#' }

spp_cites_legislation <- function(taxon_id, scope = "current", language = "en",
    raw = FALSE, token = NULL, verbose = TRUE, pause = 1, ...) {
    if (length(taxon_id) > 1) {
        out <- lapply(taxon_id, spp_cites_legislation, scope = scope,
            language = language, raw = raw, token = token, verbose = verbose,
            pause = pause, ...)
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
            # set query string
            query_string <- paste(c(rcites_lang(language), rcites_scope(scope)),
                collapse = "&")
            if (query_string != "")
                query_string <- paste0("?", query_string)
            ## create url
            q_url <- rcites_url("taxon_concepts/", taxon_id,
              "/cites_legislation.json", query_string)
            ## get results
            tmp <- rcites_res(q_url, token, raw, verbose, ...)
            ## outputs
            if (raw) {
                out <- tmp
                class(out) <- c("list", "spp_raw")
            } else {
                out <- list()
                out$cites_listings <- rcites_simplify_listings(
                    tmp$cites_listings)
                out$cites_quotas <- rcites_simplify_decisions(
                    tmp$cites_quotas)
                out$cites_suspensions <- rcites_simplify_decisions(
                    tmp$cites_suspensions)
                class(out) <- c("spp_cites_leg")
            }
        }
    }
    Sys.sleep(pause)
    out
}
