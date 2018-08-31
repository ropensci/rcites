#' Get distributions data available for a given taxon concept.
#'
#' Retrieve distributions data available for a given taxon concept for which the
#' the taxon identifier is known.
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
#' @param language vector of character strings indicating the language for the
#' names of distributions, values are taken among \code{en} (English),
#' \code{fr} (French) and \code{es} (Spanish). Default is \code{en}.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPECIESPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{set_token()} can
#' be used to set \code{SPECIESPLUS_TOKEN} for the current session.
#'
#' @return A data frame with all distribution information.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/distributions/index.html}
#'
#' @export
#'
#' @examples
#' \donttest{
#'  res1 <- spp_distributions(taxon_id = '4521')
#'  res2 <- spp_distributions(taxon_id = '4521', collapse_tags = ' + ')
#' }

spp_distributions <- function(taxon_id, language = "en", raw = FALSE, token = NULL) {
    # token check
    if (is.null(token)) 
        token <- rcites_getsecret()
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
        class(out) <- c("spp_cites_ref")
    }
    out
}
