#' Access taxon_concept data from CITES species+ API
#'
#' @description
#' Queries CITES Species+ API using an authentication token.
#' The query string filters CITES/Species+ data by taxon concept (e.g. species,
#' genus, class).
#'
#' @param query_taxon a character string containing the query (e.g. species). Scientific taxa only.
#' @param appendix_only a logical. If \code{TRUE} then taxon identifier and the
#' CITES appendix information are the only data returned (default is \code{FALSE}).
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPPPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively \code{sppplus_login()} can
#' be used to set \code{SPPPLUS_TOKEN} for the current session.
#'
#' @return
#' If \code{appendix_only} is \code{TRUE}, then a data frame with a species'
#' taxon id and CITES appendix information is returned. Otherwise, a list of
#' objects of class \code{data.table} with all CITES Species+ taxon_concept
#' information is returned. Importantly enough, this functions returns the
#' taxon concept identifier that is required by the \code{taxon_*()} functions.
#'
#' @importFrom data.table as.data.table :=
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html}
#'git
#' @export
#' @examples
#' # Not run:
#' # res1 <- sppplus_taxonconcept(query_taxon = 'Loxodonta africana')
#' # res2 <- sppplus_taxonconcept(query_taxon = 'Loxodonta africana', appendix_only = TRUE)

sppplus_taxonconcept <- function(query_taxon, appendix_only = FALSE, token = NULL) {
    # token check
    if (is.null(token)) 
        token = sppplus_getsecret()
    # 2Bdone: add here a check to ensure is a valid name
    query <- gsub(pattern = " ", replacement = "%20", x = query_taxon)
    # 
    q_url <- sppplus_url(paste0("taxon_concepts.json", "?name=", query))
    res <- sppplus_res(q_url, token)
    
    if (!res$pagination$total_entries) {
        warning("taxon not listed")
        out <- NULL
    } else {
        if (isTRUE(appendix_only)) {
            tmp <- res$taxon_concepts[[1L]]
            out <- as.data.table(tmp[c("id", "full_name", "cites_listing")])
        } else {
            out <- list()
            out$all <- as.data.table(do.call(rbind, lapply(res$taxon_concepts, rbind)))
            # 
            if ("synonyms" %in% names(out$all)) {
                out$synonyms <- as.data.table(do.call(rbind, out$all$synonyms[[1L]]))
                out$all[, `:=`("synonyms", NULL)]
            }
            if ("common_names" %in% names(out$all)) {
                out$common_names <- as.data.table(do.call(rbind, out$all$common_names[[1L]]))
                out$all[, `:=`("common_names", NULL)]
            }
            if ("higher_taxa" %in% names(out$all)) {
                out$higher_taxa <- as.data.table(do.call(cbind, out$all$higher_taxa))
                out$all[, `:=`("higher_taxa", NULL)]
            }
        }
    }
    # 
    out
}
