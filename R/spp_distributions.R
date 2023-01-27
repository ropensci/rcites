#' Get distributions data available for a given taxon concept
#'
#' Retrieve distributions data available for a given taxon concept for which the
#' the taxon identifier is known.
#'
#' @param taxon_id a vector of character strings containing species'
#' taxon concept identifiers (see [spp_taxonconcept()]).
#' @param language vector of character strings indicating the language for the
#' names of distributions, values are taken among `en` (English),
#' `fr` (French) and `es` (Spanish). Default is `en`.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' <https://api.speciesplus.net/documentation>. Default is set to
#' `NULL` and requires the environment variable `SPECIESPLUS_TOKEN` to be
#' set directly in `Renviron`. Alternatively, \code{set_token()} can
#' be used to set `SPECIESPLUS_TOKEN` for the current session.
#' @param verbose a logical. Should extra information be reported on progress?
#' @param pause a duration (in second) to suspend execution for (see
#' [Sys.sleep()]). This was added cause the web API returns a 404 error too many
#' requests in a short time interval.
#' @param ... Further named parameters, see [httr::GET()].
#'
#' @return If `raw` is set to `TRUE` then an object of class `spp_raw` (or
#' `spp_raw_multi` if `length(taxon_id)>1`) is returned which is essentially
#' a list of lists (see option `as = 'parsed'` in [httr::content()]).
#' Otherwise, an object of class `spp_distr` (or `spp_distr_multi` if
#' `length(taxon_id) > 1`) is returned which is a list of two data frames:
#' 1. `distributions`: lists distributions for a given taxon concept,
#' 2. `references`: lists the corresponding references.
#' In case `taxon_id` includes several elements
#'
#' @references
#' <https://api.speciesplus.net/documentation/v1/distributions/index.html>
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  # this calls will only work if a token is set and valid
#'  res1 <- spp_distributions(taxon_id = '4521')
#'  res2 <- spp_distributions(taxon_id = c('4521', '3210', '10255'))
#'  res3 <- spp_distributions(taxon_id = '4521', raw = TRUE)
#'  res4 <- spp_distributions(taxon_id = '4521', language = 'fr',
#'  verbose = FALSE, config = httr::progress())
#' }

spp_distributions <- function(taxon_id, language = "en", raw = FALSE,
    token = NULL, verbose = TRUE, pause = 1, ...) {

    if (length(taxon_id) > 1) {
        out <- lapply(taxon_id, spp_distributions, language = language,
            raw = raw, token = token, verbose = verbose, pause = pause, ...)
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
            tmp <- rcites_lang(language)
            if (!is.null(tmp))
                tmp <- paste0("?", tmp)
            q_url <- rcites_url("taxon_concepts/", taxon_id,
              "/distributions.json", tmp)
            # get results
            res <- rcites_res(q_url, token, raw, verbose, ...)
            # outputs
            if (raw) {
                out <- res
                class(out) <- c("list", "spp_raw")
            } else {
                out <- rcites_simplify_distributions(res)
                class(out) <- c("spp_distr")
            }
        }
    }
    Sys.sleep(pause)
    out
}
