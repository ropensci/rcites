#' Get taxon concepts for a search term.
#'
#' @description
#' Retrieve the taxon concept of a specific taxon (scientific name).
#'
#' @param query_taxon a character string containing the query (e.g. species).
#' Scientific taxa only (max 255 characters).
#' @param taxonomy filter taxon concepts by taxonomy, accepts either 'CITES' or
#' 'CMS' as its value. Defaults set to 'CITES'.
#' @param with_descendants a logical. Should the search by name be broadened to
#' include higher taxa?
#' @param language filter languages returned for common names. Value should be a
#' vector of sting including one or more country codes. Default is set to `NULL`,
#' showing all available languages.
#' @param updated_since a timestamp. Only entries updated after (and including)
#' this timestamp will be pulled.
#' @param per_page a integer that indicates how many objects are returned per
#' page for paginated responses. Default set to 500 which is the maximum.
#' @param seq_page a vector of integer that contains page numbers. Default is
#' set to `NULL`, i.e. all pages are accessed.
#' @param raw a logical. Should raw data be returned?
#' @param token a character string containing the authentification token, see
#' \url{https://api.speciesplus.net/documentation}. Default is set to
#' \code{NULL} and requires the environment variable \code{SPECIESPLUS_TOKEN} to be
#' set directly in \code{Renviron}. Alternatively, \code{set_token()} can
#' be used to set \code{SPECIESPLUS_TOKEN} for the current session.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @return
#' If `raw=TRUE`, then a object of class `spp_raw` is returned, which is essentially
#' a list of lists. If `raw=FALSE`, then a object of class `spp_taxon` is returned,
#' it is a collection of seven data frames:
#' 1. `all_id`: general information for all entries, including non-active taxon concepts,
#' 2. `general`: includes general information for active taxon concepts,
#' 3. `higher_taxa`: includes taxonomy information,
#' 4. `accepted_names`: list of accepted names (only for synonyms),
#' 5. `common_names`: list of common names (only for accepted names),
#' 6. `synonyms`: list of synonyms (only for accepted names),
#' 7. `cites_listing`: list of current CITES listings with annotations (missing if `taxonomy == 'CMS'`).
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html}
#'
#' @export
#'
#' @examples
#' \donttest{
#' res1 <- spp_taxonconcept(query_taxon = 'Loxodonta africana')
#' res2 <- spp_taxonconcept(query_taxon = 'Amazilia versicolor', raw = TRUE)
#' res3 <- spp_taxonconcept(query_taxon = '', taxonomy = 'CMS', seq_page = 1:5, language = 'EN')
#' res4 <- spp_taxonconcept(query_taxon = '', seq_page = c(44))
#' }

spp_taxonconcept <- function(query_taxon, taxonomy = "CITES", with_descendants = FALSE, 
    language = NULL, updated_since = NULL, per_page = 500, seq_page = NULL, 
    raw = FALSE, token = NULL, verbose = TRUE) {
    # taxonomy check
    taxonomy <- match.arg(taxonomy, c("CITES", "CMS"))
    # token check
    if (is.null(token)) 
        token <- rcites_getsecret()
    # request
    if (is.null(seq_page)) {
        f_page <- 1
    } else {
        seq_page <- sort(unique(as.integer(seq_page)))
        f_page <- unique(seq_page[1L])
    }
    q_url <- rcites_taxonconcept_request(query_taxon, token, taxonomy, 
        with_descendants, f_page, per_page, updated_since, language)
    # results
    tmp <- rcites_res(q_url, token)
    # number of pages
    pag <- rcites_numberpages(tmp$pagination)
    # 
    if (!pag) {
        warning("Taxon not listed.")
        return(NULL)
    } else {
        if (pag > 1) {
            if (is.null(seq_page)) {
                seq_page <- seq_len(pag)
            } else {
                seq_page <- seq_page[seq_page <= pag]
            }
            if (length(seq_page) > 1) {
                res <- rcites_autopagination(q_url, per_page, seq_page[-1L], 
                  pag, token, verbose)
                tmp2 <- c(tmp$taxon_concepts, do.call(c, lapply(res, function(x) x$taxon_concepts)))
            } else tmp2 <- tmp$taxon_concepts
        } else tmp2 <- tmp$taxon_concepts
        # outputs
        if (raw) {
            class(tmp2) <- c("list", "spp_raw")
            return(tmp2)
        } else {
            ## special cases
            sp_nm <- c("synonyms", "higher_taxa", "common_names", "cites_listing", 
                "cites_listings", "accepted_names")
            ## output
            out <- list()
            out$all_id <- rcites_taxonconcept_allentries(tmp2, sp_nm)
            out$all_id$updated_at <- as.POSIXlt(out$all_id$updated_at, 
                format = "%Y-%m-%dT%H:%M:%OS")
            out$all_id$active <- as.logical(out$all_id$active)
            ## extract active only
            id <- which(out$all_id$active)
            out$general <- out$all_id[out$all_id$active, ]
            
            ## Classification
            out$higher_taxa <- rcites_taxonconcept_higher_taxa(tmp2[id], 
                out$general$id)
            ## Names
            out$accepted_names <- rcites_taxonconcept_special_cases(tmp2[!id], 
                name = "accepted_names", out$all_id$id[!id])
            out$common_names <- rcites_taxonconcept_special_cases(tmp2[id], 
                name = "common_names", out$general$id)
            out$synonyms <- rcites_taxonconcept_special_cases(tmp2[id], 
                name = "synonyms", out$general$id)
            
            ## Extra output if taxonomy is set to CITES
            if (taxonomy == "CITES") {
                out$general$cites_listing <- unlist(lapply(tmp2[id], function(x) x$cites_listing))
                out$cites_listings <- rcites_taxonconcept_special_cases(tmp2[id], 
                  name = "cites_listings", out$general$id)
            }
            
            class(out$general) <- class(out$all_id) <- c("tbl_df", "tbl", 
                "data.frame")
            ## 
            class(out) <- c("spp_taxon")
        }
    }
    # 
    out
}
