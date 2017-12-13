#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param tax_id character string containing the taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param type character string indicating type of legislation information requested. One of listing, quota, suspension and all. Default is listing.
#' @return data frame or list...
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList
#' @importFrom XML xmlToDataFrame
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'insert your token here')
#' # taxon_cites_legislation(cnx, tax_id = '4521', type = 'listing')

taxon_cites_legislation <- function(cnx, tax_id = "4521", type = "listing") {
#    if (is.null(tax_id)) {
#        tax <- sppplus_taxonconcept(cnx, query = query_taxon, appendix_only = TRUE)
#    } else {
#        tax <- data.frame(tax_id = tax_id)
#    }
  
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax_id, "/cites_legislation.xml", sep = ""), 
                   httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))

    temp2 <- xmlParse(temp)
    temp2 <- xmlRoot(temp2)

    if ( !(type %in% c("listing", "quota", "suspension", "all"))) {
      message("select type of legislation: listing, quota, suspension or all")
      } else {
        
        if (type == "listing") {
          listing_api <- xmlToDataFrame(unlist(temp2[[1]]["cites-listing"]))
          rowno <- c(1:nrow(listing_api))
          listing_df <- data.frame(matrix(NA, ncol = 9, nrow = length(rowno)))
          names(listing_df) <- c("id", "taxon_concept_id", "is_current", "appendix", "change_type", "effective_at", "party", "annotation", "hash_annotation")
          listing_df$taxon_concept_id <- listing_api$`taxon-concept-id`
          listing_df$appendix <- listing_api$appendix
          listing_df$effective_at <- listing_api$`effective-at`
          listing_df$annotation <- listing_api$annotation
          listing_df$hash_annotation <- listing_api$hash_annotation
          for (r in rowno) {
                if (is.na(listing_api[r,"party"]) == T) {
                  } else {
                    party <- xmlToDataFrame(unlist(temp2[[1]][[r]]["party"]))
                    listing_df[r,"party"] <- as.character(party$`iso-code2`)
                  }
          }
          listing_df <- listing_df[-c(1,3,5)]
          listing_df
          } else {
            
            if (type == "quota") {
              if (is.null(unlist(temp2[[2]]["cites-quota"])) == TRUE) {
                message("no current quotas in place for this species")
                } else {
                  quota <- xmlToDataFrame(unlist(temp2[[2]]["cites-quota"]))
                  quota[,10] <- as.character(quota[,10])
                  rowno <- c(1:nrow(quota))
                  for (r in rowno) {
                    if (is.na(quota[r,10]) == T) {
                    } else {
                      geoentity <- xmlToDataFrame(unlist(temp2[[2]][[r]]["geo-entity"]))
                      names(geoentity) <- c("iso2", "name", "type")
                      quota[r,10] <- as.character(geoentity$iso2)
                    }
                  }
                  quota <- quota[c(2,4,10,3,5)]
                  quota[,1] <- as.character(quota[,1])
                  quota[,2] <- as.character(quota[,2])
                  quota[,4] <- as.character(quota[,4])
                  quota[,5] <- as.character(quota[,5])
                  names(quota) <- c("tax_id", "date", "iso2", "quota", "notes")
                  quota
                  }
              } else {
                
                if (type == "suspension") {
                  if (is.null(unlist(temp2[[3]]["cites-suspension"])) == TRUE) {
                    message("no current suspensions in place for this species")
                    } else {
                      suspension <- xmlToDataFrame(unlist(temp2[[3]]["cites-suspension"]))
                      suspension[,7] <- as.character(suspension[,7])
                      suspension[,8] <- as.character(suspension[,8])
                      rowno <- c(1:nrow(suspension))
                      for (r in rowno) {
                        if (is.na(suspension[r,7]) == T) {
                        } else {
                          geoentity <- xmlToDataFrame(unlist(temp2[[3]][[r]]["geo-entity"]))
                          names(geoentity) <- c("iso2", "name", "type")
                          suspension[r,7] <- as.character(geoentity$iso2)
                        }
                      }
                      for (r in rowno) {
                        if (is.na(suspension[r,8]) == T) {
                        } else {
                          notification <- xmlToDataFrame(unlist(temp2[[3]][[r]]["start-notification"]))
                          suspension[r,8] <- as.character(notification$name)
                        }
                      }
                      suspension <- suspension[c(2,4,7,8,3)]
                      names(suspension) <- c("tax_id", "date", "iso2", "notification", "notes")
                      suspension
                      }
                  } else {
                    
                    if (type == "all") {
                      xmlToList(temp)
                    }
                  }
              }
          }
      }
}
