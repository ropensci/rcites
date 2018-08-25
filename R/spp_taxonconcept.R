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
#' @param raw a logical. Should raw data be returned?
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
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_taxonconcept(query_taxon = 'Loxodonta africana')
#' res2 <- spp_taxonconcept(query_taxon = 'Loxodonta africana', appendix_only = TRUE)
#' res3 <- spp_taxonconcept(query_taxon = 'Amazilia versicolor')
#' res4 <- spp_taxonconcept(query_taxon = 'Amazilia')
#' }

spp_taxonconcept <- function(query_taxon, appendix_only = FALSE, token = NULL, raw = FALSE) {
    # token check
    if (is.null(token)) 
        token <- rcites_getsecret()
    query <- gsub(pattern = " ", replacement = "%20", x = query_taxon)
    # 
    q_url <- rcites_url("taxon_concepts.json", "?name=", query)
    tmp <- rcites_res(q_url, token)
    pag <- rcites_numberpages(tmp$pagination)
    # empty output
    if (!pag) {
        warning("Taxon not listed.")
        out <- NULL
    } else {
        if (raw) {
            out <- tmp$taxon_concepts
            class(out) <- c("list", "spp_raw")
        } else {
            sp_nm <- c("higher_taxa", "common_names", "synonyms", "cites_listings", 
                "cites_listing", "accepted_names")
            out <- do.call(rbind, lapply(tmp$taxon_concepts, function(x) unlist(x[!names(x) %in% 
                sp_nm])))
            # special cases return extra data frame sp_nm <- c('higher_taxa', 'common_names',
            # 'synonyms', 'cites_listings', 'cites_listing', 'accepted_names') vc_nm <-
            # unique(unlist(lapply(tmp2, names))) vc_nm <- vc_nm[! vc_nm %in% sp_nm] out <-
            # lapply( lapply(tmp2, function(x) x[names(x) %in% vc_nm]), function(x) rbind(x,
            # setdiff(vc_nm, names(x)) ))
            class(out) <- c("tbl_df", "tbl", "data.frame", "spp_tax")
            ## 
        }
    }
    # 
    out
}
