#' Access distribution data from CITES species+ API
#'
#' Queries CITES species+ API using connection generated from \code{\link[citesr]{sppplus_connect}}. The query string filters species+ data by taxon concept (e.g.species, genus, class)
#'
#' @param cnx species+ connection information (see \code{\link[citesr]{sppplus_connect}}).
#' @param tax_id character string containing a species' taxon id (e.g. 4521), which is returned by \code{\link[citesr]{sppplus_taxonconcept}}.
#' @param type character string indicating type of legislation information requested. One of listing, quota, suspension and all. Default is listing.
#' @return If type is one of listing, quota or suspension, returns a dataframe with respective information from the Species+ database. If type is all, returns a list with all Species+ database information.
#'
#' @importFrom RCurl getURI
#' @importFrom XML xmlToList xmlToDataFrame xmlParse xmlRoot
#'
#' @export
#' @examples
#' # cnx <- sppplus_connect(token = 'insert your token here')
#' # taxon_cites_legislation(cnx, tax_id = '4521', type = 'listing')

taxon_cites_legislation <- function(cnx, tax_id = "4521", type = "listing") {
    temp <- getURI(url = paste(cnx[[1]], "taxon_concepts/", tax_id, "/cites_legislation.xml",
        sep = ""), httpheader = paste("X-Authentication-Token: ", cnx[[2]], sep = ""))

    temp2 <- xmlParse(temp)
    temp2 <- xmlRoot(temp2)

    if (!(type %in% c("listing", "quota", "suspension", "all"))) {
        message("select type of legislation: listing, quota, suspension or all")
    } else {

        if (type == "listing") {
            listing_api <- xmlToDataFrame(unlist(temp2[[1]]["cites-listing"]))
            rowno <- c(1:nrow(listing_api))
            listing_df <- data.frame(matrix(NA, ncol = 9, nrow = length(rowno)))
            names(listing_df) <- c("id", "taxon_concept_id", "is_current", "appendix",
                "change_type", "effective_at", "party", "annotation", "hash_annotation")
            listing_df$taxon_concept_id <- listing_api$`taxon-concept-id`
            listing_df$appendix <- listing_api$appendix
            listing_df$effective_at <- listing_api$`effective-at`
            listing_df$annotation <- listing_api$annotation
            # party
            for (r in rowno) {
                if (is.na(listing_api[r, "party"]) == TRUE) {
                } else {
                  party <- xmlToDataFrame(unlist(temp2[[1]][[r]]["party"]))
                  listing_df[r, "party"] <- as.character(party$`iso-code2`)
                }
            }
            # hash-annotation
            if (is.null(listing_api$`hash-annotation`) == TRUE) {
            } else {
                for (r in rowno) {
                  if (is.na(listing_api[r, "hash-annotation"]) == TRUE) {
                  } else {
                    hash <- xmlToDataFrame(unlist(temp2[[1]][[r]]["hash-annotation"]))
                    listing_df[r, "hash_annotation"] <- as.character(hash$note)
                  }
                }
            }
            listing_df <- listing_df[-c(1, 3, 5, 9)]
            listing_df
        } else {

            if (type == "quota") {
                if (is.null(unlist(temp2[[2]]["cites-quota"])) == TRUE) {
                  message("no current quotas in place for this species")
                } else {
                  quota_api <- xmlToDataFrame(unlist(temp2[[2]]["cites-quota"]))
                  rowno <- c(1:nrow(quota_api))
                  quota_df <- data.frame(matrix(NA, ncol = 9, nrow = length(rowno)))
                  names(quota_df) <- c("id", "taxon_concept_id", "quota", "publication_date",
                    "notes", "url", "is_current", "unit", "geo_entity")
                  quota_df$taxon_concept_id <- quota_api$`taxon-concept-id`
                  quota_df$quota <- quota_api$quota
                  quota_df$publication_date <- quota_api$`publication-date`
                  quota_df$notes <- quota_api$notes
                  # unit
                  if (is.null(quota_api$`hash-annotation`) == TRUE) {
                  } else {
                    for (r in rowno) {
                      if (is.na(quota_api[r, "unit"]) == T) {
                      } else {
                        unit <- xmlToDataFrame(unlist(temp2[[2]][[r]]["unit"]))
                        quota_df[r, 8] <- as.character(unit$code)
                      }
                    }
                  }
                  # geo-entity
                  for (r in rowno) {
                    if (is.na(quota_api[r, "geo-entity"]) == T) {
                    } else {
                      geoentity <- xmlToDataFrame(unlist(temp2[[2]][[r]]["geo-entity"]))
                      quota_df[r, 9] <- as.character(geoentity$`iso-code2`)
                    }
                  }
                  quota_df <- quota_df[-c(1, 6, 7, 8)]
                  quota_df
                }
            } else {

                if (type == "suspension") {
                  if (is.null(unlist(temp2[[3]]["cites-suspension"])) == TRUE) {
                    message("no current suspensions in place for this species")
                  } else {
                    suspension_api <- xmlToDataFrame(unlist(temp2[[3]]["cites-suspension"]))
                    rowno <- c(1:nrow(suspension_api))
                    suspension_df <- data.frame(matrix(NA, ncol = 9, nrow = length(rowno)))
                    names(suspension_df) <- c("id", "taxon_concept_id", "notes",
                      "start_date", "is_current", "geo_entity", "applies_to_import",
                      "notification", "notification_url")
                    suspension_df$taxon_concept_id <- suspension_api$`taxon-concept-id`
                    suspension_df$notes <- suspension_api$notes
                    suspension_df$start_date <- suspension_api$`start-date`
                    # geo-entity
                    for (r in rowno) {
                      if (is.na(suspension_api[r, 7]) == T) {
                      } else {
                        geoentity <- xmlToDataFrame(unlist(temp2[[3]][[r]]["geo-entity"]))
                        suspension_df[r, 6] <- as.character(geoentity$`iso-code2`)
                      }
                    }
                    # start-notification
                    for (r in rowno) {
                      if (is.na(suspension_api[r, 8]) == T) {
                      } else {
                        notification <- xmlToDataFrame(unlist(temp2[[3]][[r]]["start-notification"]))
                        suspension_df[r, 8] <- as.character(notification$name)
                        suspension_df[r, 9] <- as.character(notification$url)
                      }
                    }
                    suspension_df <- suspension_df[-c(1, 5, 7)]
                    suspension_df
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
