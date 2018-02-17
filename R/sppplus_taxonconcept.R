#' Access taxon_concept data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}.
#' The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param token connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param query_taxon character string containing the query (e.g. species). Scientific taxa only.
#' @param appendix_only logical statement for querying only the taxon and CITES appendix information. Default is set to \code{TRUE}.
#'
#' @return If appendix_only is \code{TRUE}, returns a dataframe with a species' taxon id and CITES appendix information. If appendix_only is FALSE, returns a list with all Species+ taxon concept information.
#'
#' @importFrom httr content stop_for_status
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html}
#'
#' @export
#' @examples
#' # sppplus_taxonconcept(token = token, query_taxon = 'Loxodonta africana', appendix_only = TRUE)
#' # sppplus_taxonconcept(token = token, query_taxon = 'Homo sapiens', appendix_only = TRUE)

sppplus_taxonconcept <- function(token, query_taxon = "Loxodonta africana", appendix_only = TRUE, format = "json") {
    # we can add here a check to ensure is a valid name
    query <- gsub(pattern = " ", replacement = "%20", x = query_taxon)
    #
    url <- build_url(what = paste0("taxon_concepts.", format, "?name=", query))
    con <- sppplus_get(url, token)
    # check status
    stop_for_status(con)
    # parsed
    res <- content(con, "parsed")

    if (!res$pagination$total_entries) {
        warning("taxon not listed in CITES")
        out <- NULL
    } else {
        tmp <- res$taxon_concept[[1L]]
        if (appendix_only == TRUE) {
          out <- as.data.frame(tmp[c('id', 'full_name', 'cites_listing')])
        } else {
          out <- tmp
          out$common_names <- do.call(rbind, (lapply(tmp$common_names, rbind)))
        }
    }
    out
}
