#' Get distributions data available for a given taxon concept.
#'
#' Retrieve distributions data available for a given taxon concept for which the
#' the taxon identifier is known.
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see [spp_taxonconcept()]).
#' @param language vector of character strings indicating the language for the
#' names of distributions, values are taken among `en` (English),
#' `fr` (French) and `es` (Spanish). Default is `en`.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' <https://api.speciesplus.net/documentation>. Default is set to
#' `NULL` and requires the environment variable `SPECIESPLUS_TOKEN` to be
#' set directly in `Renviron`. Alternatively, \code{set_token()} can
#' be used to set `SPECIESPLUS_TOKEN` for the current session.
#'
#' @return If `raw` is set to `TRUE` then an object of class `spp_raw` is returned
#' which is essentially the list of lists (see option `as = 'parsed'` in [httr::content()]).
#' Otherwise, an object of class `spp_distr` is returned which is a list of two
#' data frames:
#' 1. `distributions`: lists distributions for a given taxon concept,
#' 2. `references`: lists the corresponding references.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/distributions/index.html}
#'
#' @export
#'
#' @examples
#' \donttest{
#'  res1 <- spp_distributions(taxon_id = '4521')
#'  res2 <- spp_distributions(taxon_id = '4521', raw = TRUE)
#'  res3 <- spp_distributions(taxon_id = '4521', language = 'fr')
#' }

spp_distributions <- function(taxon_id, language = "en", raw = FALSE, token = NULL) {
    # token check
    if (is.null(token)) 
        token <- rcites_getsecret()
    # id check
    rcites_checkid(taxon_id)
    # set query_string
    tmp <- rcites_lang(language)
    if (!is.null(tmp)) 
        tmp <- paste0("?", tmp)
    q_url <- rcites_url("taxon_concepts/", taxon_id, "/distributions.json", 
        tmp)
    # get results
    res <- rcites_res(q_url, token)
    ## outputs
    if (raw) {
        out <- res
        class(out) <- c("list", "spp_raw")
    } else {
        out <- rcites_simplify_distributions(res)
        class(out) <- c("spp_distr")
    }
    out
}
