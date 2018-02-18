#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using an authentication token. The query string
#' filters species+ data by taxon concept (e.g. species, genus, class)
#'
#' @param token Authentification token, see \url{https://api.speciesplus.net/documentation}.
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param type vector of character strings indicating the type of references requested, \code{taxonomic} or \code{distribution}.
#'
#' @return A list of data table with the desired references.
#'
#' @importFrom httr content stop_for_status
#' @importFrom data.table as.data.table data.table
#' @export
#'
#' @references
#' \url{https://api.speciesplus.net/documentation/v1/references/index.html}
#'
#' @examples
#' # taxon_references(token, tax_id = '4521')
#' # taxon_references(token, tax_id = '4521', type = 'taxonomic')

taxon_references <- function(token, tax_id = "4521", type = c("taxonomic", "distribution")) {
    # 
    type <- unique(type)
    stopifnot(all(type %in% c("taxonomic", "distribution")))
    # 
    out <- list()
    # 
    if ("taxonomic" %in% type) {
        q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/references.json"))
        res <- sppplus_res(q_url, token)
        out$taxonomic <- as.data.table(do.call(rbind, lapply(res, rbind)))
    }
    # 
    if ("distribution" %in% type) {
        q_url <- sppplus_url(paste0("taxon_concepts/", tax_id, "/distributions.json"))
        res <- sppplus_res(q_url, token)
        ref <- as.data.table(do.call(rbind, lapply(res, rbind)))
        out$distribution <- data.table(name = rep(unlist(ref$name), unlist(lapply(ref$references, 
            length))), reference = unlist(ref$references))
    }
    # output
    out
}
