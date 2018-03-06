#' Access taxon_concept data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token.
#' The query string filters species+ data by taxon concept (e.g. species, genus, class)
#'
#' @param query_taxon character string containing the query (e.g. species). Scientific taxa only.
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}. Default is set to \code{NULL} and require the environment variable \code{SPPPLUS_TOKEN} to be set directly in \code{.Renviron} or for the session using \code{sppplus_login()}.
#' @param appendix_only a logical statement. Should  for querying only the taxon and CITES appendix information. Default is set to \code{TRUE}.
#'
#' @return If \code{appendix_only} is \code{TRUE}, then a data table with a species'
#' taxon id and CITES appendix information is returned. Otherwise,
#' a object of class \code{data.table} with all Species+ taxon concept information
#' is returned.
#'
#' @importFrom data.table as.data.table
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html}
#'
#' @export
#' @examples
#' # Not run
#' # res <- sppplus_taxonconcept(query_taxon = 'Loxodonta africana', appendix_only = TRUE)
#' # res <- sppplus_taxonconcept(token = token, query_taxon = 'Homo sapiens')

sppplus_taxonconcept <- function(query_taxon, token = NULL, appendix_only = TRUE) {
    # token check
    if (is.null(token)) 
        token = sppplus_getsecret()
    # 2Bdone: add here a check to ensure is a valid name
    query <- gsub(pattern = " ", replacement = "%20", x = query_taxon)
    # 
    q_url <- sppplus_url(paste0("taxon_concepts.json", "?name=", query))
    res <- sppplus_res(q_url, token)
    
    if (!res$pagination$total_entries) {
        warning("taxon not listed in CITES")
        out <- NULL
    } else {
        tmp <- res$taxon_concept[[1L]]
        if (isTRUE(appendix_only)) {
            out <- as.data.frame(tmp[c("id", "full_name", "cites_listing")])
        } else {
            out <- tmp
            out$common_names <- do.call(rbind, (lapply(tmp$common_names, rbind)))
        }
    }
    ## output
    as.data.table(out)
}
