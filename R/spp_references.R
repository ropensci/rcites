#' Get references for a given taxon concept
#'
#' Retrieve available references for a given taxon concept.
#'
#' @param taxon_id character string containing a species' taxon concept identifier
#' (see \code{\link[rcites]{spp_taxonconcept}}).
#' @param type vector of character strings indicating the type of references
#' requested, \code{taxonomic} or \code{distribution}.
#' @param simplify a logical. Should the output be simplified? In other words,
#' should columns of data.table objects returned be unlisted when they are
#' lists made of single elements?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPECIESPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{set_token()} can
#' be used to set \code{SPECIESPLUS_TOKEN} for the current session.
#'
#' @return A list of data.table objects, one per type requested.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/references/index.html}
#'
#'
#' @importFrom data.table as.data.table data.table
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_references(taxon_id = '4521')
#' res2 <- spp_references(taxon_id = '4521', type = 'taxonomic', simplify = T)
#' }

spp_references <- function(taxon_id, 
                           type = c("taxonomic", "distribution"), 
                           simplify = FALSE, 
                           token = NULL) {
    # token check
    if (is.null(token)) 
        token <- rcites_getsecret()
    # 
    type <- unique(type)
    stopifnot(all(type %in% c("taxonomic", "distribution")))
    # 
    out <- list()
    # 
    if ("taxonomic" %in% type) {
        q_url <- rcites_url(paste0("taxon_concepts/", taxon_id, "/references.json"))
        res <- rcites_res(q_url, token)
        out$taxonomic <- as.data.table(do.call(rbind, lapply(res, rbind)))
    }
    # 
    if ("distribution" %in% type) {
        q_url <- rcites_url(paste0("taxon_concepts/", taxon_id, "/distributions.json"))
        res <- rcites_res(q_url, token)
        ref <- as.data.table(do.call(rbind, lapply(res, rbind)))
        out$distribution <- data.table(name = rep(unlist(ref$name), unlist(lapply(ref$references, 
            length))), reference = unlist(ref$references))
    }
    ## 
    if (isTRUE(simplify)) 
        lapply(out, rcites_simplify)
    # output
    out
}
