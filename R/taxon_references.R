#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param tax_id character string containing the taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param type character string indicating type of references requested. One of taxonomic and distribution. Default is taxonomic.
#' @return If type is one of taxonomic or distribution, returns a dataframe with respective references from the Species+ database. If type is distribution, check \code{\link[citesr]{taxon_distribution}} for country notes.
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList xmlToDataFrame xmlParse xmlRoot
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'insert your token here')
#' # taxon_references(cnx, tax_id = '4521', type = 'taxonomic')

taxon_references <- function(cnx, tax_id = "4521", type = "taxonomic") {
  if (!(type %in% c("taxonomic", "distribution"))) {
    message("select type of references: taxonomic or distribution")
    } else {
      if (type == "taxonomic") {
        temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax_id, "/references.xml",
                                   sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))
        temp2 <- xmlParse(temp)
        temp2 <- xmlRoot(temp2)
        if (length(temp2["api-taxon-references-view"]) == 0) {
          message("no taxonomic references for this species")
          } else {
            temp3 <- xmlToDataFrame(unlist(temp2["api-taxon-references-view"]))
            rowno <- c(1:nrow(temp3))
            taxonomic_refs <- data.frame(matrix(NA, ncol = 3, nrow = length(rowno)))
            names(taxonomic_refs) <- c("tax_id", "reference", "cites_standard")
            taxonomic_refs$tax_id <- as.character(tax_id)
            taxonomic_refs$reference <- temp3$citation
            taxonomic_refs$cites_standard <- temp3$`is-standard`
            for (r in rowno) {
              if (taxonomic_refs[r,3] == "true") {
                taxonomic_refs[r,3] <- paste("CITES standard reference")
                } else {
                  taxonomic_refs[r,3] <- paste("other reference")
                }
            }
            taxonomic_references <- taxonomic_refs
            taxonomic_references
            }
        }
      else {
        if (type == "distribution") {
                temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax_id, "/distributions.xml",
                                           sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))
                temp2 <- xmlParse(temp)
                temp2 <- xmlRoot(temp2)
                temp3 <- xmlToDataFrame(unlist(temp2["api-distributions-view"]))
                rowno <- c(1:nrow(temp3))
                didistribution_refs <- data.frame(matrix(NA, ncol = 2, nrow = length(rowno)))
                names(didistribution_refs) <- c("tax_id", "iso2")
                didistribution_refs$id <- as.character(tax_id)
                didistribution_refs$iso2 <- temp3$`iso-code2`
                p <- c(0)
                for (r in rowno) {
                  p_temp <- xmlToDataFrame(unlist(temp2[[r]][[6]]))
                  p <- c(p, c(nrow(p_temp)))
                  }
                distref_df <- data.frame(matrix(NA, ncol = max(p), nrow = 1))
                colno <- c(1:(max(p)))
                for (c in colno) {
                  names(distref_df)[c] <- paste("reference_", c, sep = "")
                  }
                didistribution_refs <- cbind(didistribution_refs, distref_df)
                for (r in rowno) {
                  if (length(xmlToDataFrame(unlist(temp2[[r]][[6]]))) == 0) {
                    } else {
                      p_temp <- xmlToDataFrame(unlist(temp2[[r]][[6]]))
                      refno <- c(1:nrow(p_temp))
                      for (l in refno) {
                        didistribution_refs[r,(l+2)] <- as.character(p_temp[l,1])
                      }
                    }
                  }
                distribution_references <- didistribution_refs
                distribution_references
        }
      }
    }
}
      