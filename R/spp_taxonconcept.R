#' Get taxon concepts for a search term.
#'
#' @description
#' Retrieve the taxon concept of a specific taxon (scientific name).
#'
#' @param query_taxon a character string containing the query (e.g. species). Scientific taxa only (max 255 characters).
#' @param appendix_only a logical. If \code{TRUE} then taxon identifier and the
#' CITES appendix information are the only data returned (default is \code{FALSE}).
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPECIESPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively, \code{set_token()} can
#' be used to set \code{SPECIESPLUS_TOKEN} for the current session.
#'
#' @return
#' If \code{appendix_only} is \code{TRUE}, then a data frame with a species'
#' taxon id and CITES appendix information is returned. Otherwise, a list of
#' objects of class \code{data.table} with all CITES Species+ taxon_concept
#' information is returned. Importantly enough, this functions returns the
#' taxon concept identifier that is required by the \code{spp_*()} functions.
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html}
#'
#' @importFrom data.table as.data.table :=
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_taxonconcept(query_taxon = 'Loxodonta africana')
#' res2 <- spp_taxonconcept(query_taxon = 'Loxodonta africana', appendix_only = TRUE)
#' res3 <- spp_taxonconcept(query_taxon = 'Amazilia versicolor')
#' }

spp_taxonconcept <- function(query_taxon, appendix_only = FALSE, token = NULL) {
    # token check
    if (is.null(token)) 
        token <- rcites_getsecret()
    query <- gsub(pattern = " ", replacement = "%20", x = query_taxon)
    # 
    q_url <- rcites_url("taxon_concepts.json", "?name=", query)
    res <- rcites_res(q_url, token)
    
    if (!res$pagination$total_entries) {
        warning("Taxon not listed.")
        out <- NULL
    } else {
        nm <- c("id", "full_name", "author_year", "rank", "name_status", "updated_at", 
            "active", "cites_listing")
        tmp <- as.data.table(do.call(rbind, lapply(res$taxon_concepts, function(x) rbind(x[nm]))))
        # 
        rcites_simplify(tmp)
        # 
        if (isTRUE(appendix_only)) {
            out <- tmp
        } else {
            out <- list()
            out$all <- tmp
            tmp <- res$taxon_concepts[[1L]]
            # 
            if ("synonyms" %in% names(tmp)) {
                out$synonyms <- as.data.table(do.call(cbind, tmp$synonyms[[1L]]))
            }
            if ("common_names" %in% names(tmp)) {
                out$common_names <- as.data.table(do.call(cbind, tmp$common_names[[1L]]))
            }
            if ("higher_taxa" %in% names(tmp)) {
                out$higher_taxa <- as.data.table(do.call(cbind, tmp$higher_taxa))
            }
        }
    }
    # 
    out
}
