#' Get current EU annex listings, SRG opinions, and EU suspensions
#'
#' Retrieve current EU annex listings, SRG opinions, and EU suspensions for a
#' given taxon concept (identifier must be known).
#'
#' @param taxon_id a vector of character strings containing species' taxon
#' concept identifiers (see [spp_taxonconcept()]).
#' @param scope vector of character strings indicating the time scope of
#' legislation, values are taken among `current`, `historic` and `all`.
#' Default is set to `current`.
#' @param language vector of character strings indicating the language for the
#' text of legislation notes, values are taken among `en` (English),
#' `fr` (French) and `es` (Spanish). Default is `en`.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' <https://api.speciesplus.net/documentation>. Default is set to
#' `NULL` and requires the environment variable `SPECIESPLUS_TOKEN` to be
#' set directly in `Renviron`. Alternatively, [set_token()] can
#' be used to set `SPECIESPLUS_TOKEN` for the current session.
#' @param pause a duration (in second) to suspend execution for (see
#' [Sys.sleep()]). This was added cause the web API returns a 404 error too many
#' requests in a short time interval.
#' @param verbose a logical. Should extra information be reported on progress?
#' @param ... Further named parameters, see [httr::GET()].
#'
#' @return If `raw` is set to `TRUE` then an object of class `spp_raw` (or
#' `spp_raw_multi` if `length(taxon_id)>1`) is returned which is essentially
#' a list of lists (see option `as = 'parsed'` in [httr::content()]).
#' Otherwise, an object of class `spp_eu_leg` (or `spp_eu_leg_multi` if
#' `length(taxon_id)>1`) is returned which is a list of two data frames:
#'  1. `eu_listings`: lists EU annex listings EU suspensions,
#'  2. `eu_decisions`: lists EU decisions
#'
#' @references
#' <https://api.speciesplus.net/documentation/v1/eu_legislation/index.html>
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # this calls will only work if a token is set and valid
#' res1 <- spp_eu_legislation(taxon_id = '4521')
#' res2 <- spp_eu_legislation(taxon_id = c('4521', '3210', '10255'))
#' res3 <- spp_eu_legislation(taxon_id = '4521', scope = 'historic')
#' res4 <- spp_eu_legislation(taxon_id = '4521', scope = 'all', language='fr',
#'  verbose = FALSE, config=httr::verbose())
#' }

spp_eu_legislation <- function(taxon_id, scope = "current", language = "en",
    raw = FALSE, token = NULL, verbose = TRUE, pause = 1, ...) {

    if (length(taxon_id) > 1) {
        out <- lapply(taxon_id, spp_eu_legislation, scope = scope,
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
              "/eu_legislation.json", query_string)
            ## get_res
            tmp <- rcites_res(q_url, token, raw, verbose, ...)
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
        }
    }
    Sys.sleep(pause)
    out
}
