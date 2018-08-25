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
#' res2 <- spp_taxonconcept(query_taxon = 'Loxodonta africana', raw = TRUE)
#' res3 <- spp_taxonconcept(query_taxon = 'Amazilia versicolor')
#' res4 <- spp_taxonconcept(query_taxon = 'Crotalus durissus')
#' }

spp_taxonconcept <- function(query_taxon, token = NULL, raw = FALSE) {
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
        # auto pagination to be added here if (pag>1) rcites_autopagination()
        # should be stored in tmp$taxon_concepts
        if (raw) {
            out <- tmp$taxon_concepts
            class(out) <- c("list", "spp_raw")
        } else {
            tmp <- tmp$taxon_concepts
            ## special cases
            sp_nm <- c("synonyms", "higher_taxa", "common_names",
              "cites_listing",  "cites_listings", "accepted_names")
            ## output
            out <- list()
            out$all_id <- data.frame(do.call(rbind, lapply(tmp,
                function(x) unlist(x[!names(x) %in% sp_nm]))))
            out$all_id$updated_at <- as.POSIXlt(out$all_id$updated_at,
                format = "%Y-%m-%dT%H:%M:%OS")
            out$all_id$active <- as.logical(out$all_id$active)
            ##
            id <- which(out$all_id$active)
            out$general <- out$all_id[out$all_id$active,]
            out$general$cites_listing <- unlist(lapply(tmp[id], function(x) x$cites_listing))
            class(out$all_id) <- c("tbl_df", "tbl", "data.frame")
            class(out$general) <- c("tbl_df", "tbl", "data.frame")

            ## special cases
            ## add id
            out$higher_taxa <- rcites_simplify_taxon(tmp[id], "higher_taxa", F)
            out$synonyms <- rcites_simplify_taxon(tmp[id], name = "synonyms")
            out$common_names <- rcites_simplify_taxon(tmp[id], name = "common_names")
            out$cites_listings <- rcites_simplify_taxon(tmp[id], name = "cites_listings")

            ##
            class(out) <- c("spp_taxon")
        }
    }
    #
    out
}



rcites_simplify_taxon <- function(x, name, use_rbind = TRUE) {
  if (use_rbind) {
    tmp <- lapply(x, function(y) rcites_simplifylist_rbind(y[[name]]))
  } else {
    tmp <- lapply(x, function(y) rcites_simplifylist_cbind(y[[name]]))
  }
  out <- data.frame(do.call(rbind, tmp))
  class(out) <- c("tbl_df", "tbl", "data.frame")
  out
}
