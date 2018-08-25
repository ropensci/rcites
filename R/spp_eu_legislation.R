#' Get current EU annex listings, SRG opinions, and EU suspensions.
#'
#' Retrieve current EU annex listings, SRG opinions, and EU suspensions for a
#' given taxon concept (identifier must be known).
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
#' @param type vector of character strings indicating the type of legislation 
#' information requested, values are taken among \code{listings} and \code{decisions}. 
#' Default includes the two of them.
#' @param scope vector of character strings indicating the time scope of legislation, 
#' values are taken among \code{current}, \code{historic} and \code{all}. 
#' Default is \code{current}.
#' @param language vector of character strings indicating the language for the 
#' text of legislation notes, values are taken among \code{en} (English), 
#' \code{fr} (French) and \code{es} (Spanish). Default is \code{en}.
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

spp_eu_legislation <- function(taxon_id, 
                               type = c("listings", "decisions"),
                               scope = c("current", "historic", "all"),
                               language = c("en", "fr", "es"),
                               simplify = FALSE, 
                               token = NULL) {
    # token
    if (is.null(token)) 
        token <- rcites_getsecret()
    # 
    type <- unique(type)
    stopifnot(all(type %in% c("listings", "decisions")))
    # set query_string
    scope <- match.arg(scope)
    if (scope == "current"){sc <- NULL}
    if (scope == "historic"){sc <- "scope=historic"}
    if (scope == "all"){sc <- "scope=all"}
    language <- match.arg(language)
    if (scope == "en"){la <- NULL}
    if (scope == "fr"){la <- "language=fr"}
    if (scope == "es"){la <- "language=es"}
    query_string <- paste0(
      if(is.null(sc) & is.null(la)){} else {"?"}, 
      sc, 
      if(!is.null(sc) & !is.null(la)){"&"} else {}, 
      la)
    #
    q_url <- rcites_url(paste0("taxon_concepts/", taxon_id, "/eu_legislation.json", query_string))
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
