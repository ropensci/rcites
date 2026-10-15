# Check that the structure of the Species+ API responses has not changed.
#
# For every endpoint used by rcites, this script:
#   1. requests the raw response and compares its fields with the expected
#      ones: a missing field is an error, a new field is only reported;
#   2. requests the parsed response and checks that rcites still returns the
#      expected classes and data frames.
#
# Only the structure is checked, never the values, as the data change over
# time. Requires the environment variable SPECIESPLUS_TOKEN.
#
# Usage: Rscript .github/scripts/check-api.R

library(rcites)

taxon_name <- "Loxodonta africana"
taxon_id <- "4521"

errors <- character(0)
notes <- character(0)

# GitHub annotations when run in a workflow, plain messages otherwise
on_gha <- nzchar(Sys.getenv("GITHUB_ACTIONS"))
report <- function(level, msg) {
  if (on_gha) {
    cat(sprintf("::%s::%s\n", level, msg))
  } else {
    cat(toupper(level), ": ", msg, "\n", sep = "")
  }
}
fail <- function(...) {
  msg <- paste0(...)
  errors <<- c(errors, msg)
  report("error", msg)
}
note <- function(...) {
  msg <- paste0(...)
  notes <<- c(notes, msg)
  report("warning", msg)
}

# union of the field names of a list of records
fields <- function(x) unique(unlist(lapply(x, names)))

check_fields <- function(label, found, expected) {
  if (!length(found)) {
    return(fail(label, ": no field returned"))
  }
  missing <- setdiff(expected, found)
  added <- setdiff(found, expected)
  if (length(missing)) {
    fail(label, ": missing field(s) ", paste(missing, collapse = ", "))
  }
  if (length(added)) {
    note(label, ": new field(s) ", paste(added, collapse = ", "))
  }
  invisible(NULL)
}

check_parsed <- function(label, x, cls, elements) {
  if (!inherits(x, cls)) {
    return(fail(label, ": expected class ", cls))
  }
  missing <- setdiff(elements, names(x))
  if (length(missing)) {
    fail(label, ": missing element(s) ", paste(missing, collapse = ", "))
  }
  not_df <- names(x)[!vapply(x, is.data.frame, logical(1))]
  if (length(not_df)) {
    fail(label, ": not a data frame: ", paste(not_df, collapse = ", "))
  }
  invisible(NULL)
}

# run a call, record an error (rather than stopping) if it fails
run <- function(label, expr) {
  cat("--", label, "\n")
  tryCatch(
    suppressMessages(expr),
    error = function(e) {
      fail(label, ": call failed: ", conditionMessage(e))
      NULL
    }
  )
}


## Expected structure --------------------------------------------------------

expected <- list(
  taxon_concept = c(
    "id",
    "full_name",
    "author_year",
    "rank",
    "name_status",
    "updated_at",
    "active",
    "cites_listing",
    "eu_listing",
    "higher_taxa",
    "common_names",
    "synonyms",
    "cites_listings"
  ),
  higher_taxa = c("kingdom", "phylum", "class", "order", "family"),
  common_names = c("name", "language"),
  tc_cites_listings = c(
    "id",
    "taxon_concept_id",
    "is_current",
    "appendix",
    "change_type",
    "effective_at",
    "annotation"
  ),
  distributions = c("id", "iso_code2", "name", "type", "tags", "references"),
  references = c("id", "citation", "is_standard"),
  cites_legislation = c("cites_listings", "cites_quotas", "cites_suspensions"),
  cites_listings = c(
    "id",
    "taxon_concept_id",
    "is_current",
    "appendix",
    "change_type",
    "effective_at",
    "annotation",
    "party"
  ),
  cites_quotas = c(
    "id",
    "taxon_concept_id",
    "quota",
    "publication_date",
    "notes",
    "url",
    "public_display",
    "is_current",
    "unit",
    "geo_entity"
  ),
  cites_suspensions = c(
    "id",
    "taxon_concept_id",
    "notes",
    "start_date",
    "is_current",
    "applies_to_import",
    "geo_entity",
    "start_notification"
  ),
  eu_legislation = c("eu_listings", "eu_decisions"),
  eu_listings = c(
    "id",
    "taxon_concept_id",
    "is_current",
    "annex",
    "change_type",
    "effective_at",
    "annotation"
  ),
  eu_decisions = c(
    "id",
    "taxon_concept_id",
    "notes",
    "start_date",
    "is_current",
    "eu_decision_type",
    "geo_entity",
    "start_event",
    "source",
    "term"
  )
)

tc_elements <- c(
  "all_id",
  "general",
  "higher_taxa",
  "accepted_names",
  "common_names",
  "synonyms"
)


## Taxon concepts ------------------------------------------------------------

raw <- run(
  "spp_taxonconcept(raw = TRUE)",
  spp_taxonconcept(taxon_name, raw = TRUE, verbose = FALSE)
)
if (!is.null(raw)) {
  check_fields("taxon_concepts", fields(raw), expected$taxon_concept)
  check_fields(
    "taxon_concepts/higher_taxa",
    fields(lapply(raw, `[[`, "higher_taxa")),
    expected$higher_taxa
  )
  check_fields(
    "taxon_concepts/common_names",
    fields(unlist(lapply(raw, `[[`, "common_names"), recursive = FALSE)),
    expected$common_names
  )
  check_fields(
    "taxon_concepts/cites_listings",
    fields(unlist(lapply(raw, `[[`, "cites_listings"), recursive = FALSE)),
    expected$tc_cites_listings
  )
}

res <- run(
  "spp_taxonconcept()",
  spp_taxonconcept(taxon_name, verbose = FALSE)
)
if (!is.null(res)) {
  check_parsed(
    "spp_taxonconcept()",
    res,
    "spp_taxon",
    c(tc_elements, "cites_listings")
  )
}

res <- run(
  "spp_taxonconcept(taxonomy = 'CMS')",
  spp_taxonconcept(taxon_name, taxonomy = "CMS", verbose = FALSE)
)
if (!is.null(res)) {
  check_parsed("spp_taxonconcept(taxonomy = 'CMS')", res, "spp_taxon", tc_elements)
}

# pagination
res <- run(
  "spp_taxonconcept(pages = 1:2)",
  spp_taxonconcept("", per_page = 5, pages = 1:2, verbose = FALSE)
)
if (!is.null(res)) {
  check_parsed("spp_taxonconcept(pages = 1:2)", res, "spp_taxon", tc_elements)
  if (nrow(res$all_id) != 10) {
    fail(
      "spp_taxonconcept(pages = 1:2): expected 10 entries, got ",
      nrow(res$all_id)
    )
  }
}


## Distributions -------------------------------------------------------------

raw <- run(
  "spp_distributions(raw = TRUE)",
  spp_distributions(taxon_id, raw = TRUE, verbose = FALSE)
)
if (!is.null(raw)) {
  check_fields("distributions", fields(raw), expected$distributions)
}

res <- run(
  "spp_distributions()",
  spp_distributions(taxon_id, verbose = FALSE)
)
if (!is.null(res)) {
  check_parsed(
    "spp_distributions()",
    res,
    "spp_distr",
    c("distributions", "references")
  )
}


## References ----------------------------------------------------------------

raw <- run(
  "spp_references(raw = TRUE)",
  spp_references(taxon_id, raw = TRUE, verbose = FALSE)
)
if (!is.null(raw)) {
  check_fields("references", fields(raw), expected$references)
}

res <- run("spp_references()", spp_references(taxon_id, verbose = FALSE))
if (!is.null(res)) {
  check_parsed("spp_references()", res, "spp_refs", "references")
}


## CITES legislation ---------------------------------------------------------

# scope = "all" so that every type of record is returned
raw <- run(
  "spp_cites_legislation(raw = TRUE)",
  spp_cites_legislation(taxon_id, scope = "all", raw = TRUE, verbose = FALSE)
)
if (!is.null(raw)) {
  check_fields("cites_legislation", names(raw), expected$cites_legislation)
  for (nm in intersect(names(raw), expected$cites_legislation)) {
    check_fields(
      paste0("cites_legislation/", nm),
      fields(raw[[nm]]),
      expected[[nm]]
    )
  }
}

res <- run(
  "spp_cites_legislation()",
  spp_cites_legislation(taxon_id, scope = "all", verbose = FALSE)
)
if (!is.null(res)) {
  check_parsed(
    "spp_cites_legislation()",
    res,
    "spp_cites_leg",
    expected$cites_legislation
  )
}


## EU legislation ------------------------------------------------------------

raw <- run(
  "spp_eu_legislation(raw = TRUE)",
  spp_eu_legislation(taxon_id, scope = "all", raw = TRUE, verbose = FALSE)
)
if (!is.null(raw)) {
  check_fields("eu_legislation", names(raw), expected$eu_legislation)
  for (nm in intersect(names(raw), expected$eu_legislation)) {
    check_fields(
      paste0("eu_legislation/", nm),
      fields(raw[[nm]]),
      expected[[nm]]
    )
  }
}

res <- run(
  "spp_eu_legislation()",
  spp_eu_legislation(taxon_id, scope = "all", verbose = FALSE)
)
if (!is.null(res)) {
  check_parsed(
    "spp_eu_legislation()",
    res,
    "spp_eu_leg",
    expected$eu_legislation
  )
}


## Summary -------------------------------------------------------------------

summary_md <- c(
  "## Species+ API structure check",
  "",
  if (length(errors)) {
    c(sprintf("### %d error(s)", length(errors)), "", paste("-", errors), "")
  } else {
    c("No breaking change detected.", "")
  },
  if (length(notes)) {
    c(sprintf("### %d new field(s)", length(notes)), "", paste("-", notes))
  }
)
summary_file <- Sys.getenv("GITHUB_STEP_SUMMARY")
if (nzchar(summary_file)) {
  cat(summary_md, file = summary_file, sep = "\n", append = TRUE)
}
cat("\n", summary_md, sep = "\n")

if (length(errors)) {
  quit(status = 1)
}
