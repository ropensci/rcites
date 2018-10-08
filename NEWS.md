# rcites 0.1.1.9000

- new features:

  - `spp_taxonconcept()` now includes an auto-pagination that allows to retrieve
  all entries for queries that have more than 500 results;
  - Functions `spp_*` now returns S3 objects:
    - `spp_taxonconcept()` returns an object of class `spp_taxon`;
    - `spp_cites_legislation()` returns an object of class `spp_cites_leg`  or `spp_cites_leg_multi`;
    - `spp_eu_legislation()` returns an object of class `spp_eu_leg` or `spp_eu_leg_multi`;
    - `spp_distributions()` returns an object of class `spp_distr` or `spp_distr_multi`;
    - `spp_references()` returns an object of class `spp_refs` or `spp_refs_multi`;
  - Moreover:
    - `spp_raw` class is defined for all functions including the argument `raw`,
    it returns the parsed output from the API as a list object.   



- add function parameters:

  - `taxonomy`, `with_descendants`, `language`, `updated_since`, `per_page`,
  `seq_page`, `raw`, `verbose` in `spp_taxonconcept()`
  - `scope`, `language` and `raw` to `spp_cites_legislation()`
  - `scope`, `language` and `raw` to `spp_eu_legislation()`
  - `language` and `raw` to `spp_distributions()`

- change function names:

  - `set_token()` instead of `sppplus_login()`
  - `spp_taxonconcept()` instead of `sppplus_taxonconcept()`
  - `spp_cites_legislation()` instead of `taxon_cites_legislation()`
  - `spp_eu_legislation()` instead of `taxon_eu_legislation()`
  - `spp_distributions()` instead of `taxon_distribution()`
  - `spp_references()` instead of `taxon_references()`
  - `rcites_simplify()` instead of `sppplus_simplify()`
  - `rcites_` instead of `sppplus_` for helper functions

- follow `goodpractice`:

  - use '<-' for assignment instead of '=',
  - omit "Date" in DESCRIPTION,
  - avoid 1:length(...), 1:nrow(...), 1:ncol(...),


# rcites 0.1.0

First release

## Features

- spp_taxonconcept( ): [access the Speciesplus taxon concept](https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html)
- spp_cites_legislation( ): [access CITES legislation data](https://api.speciesplus.net/documentation/v1/cites_legislation/index.html)
- spp_eu_legislation( ): [access EU legislation data](https://api.speciesplus.net/documentation/v1/eu_legislation/index.html)
- spp_distributions( ): [access a taxon distribution data](https://api.speciesplus.net/documentation/v1/distributions/index.html)
- spp_references( ): [access a listing reference data](https://api.speciesplus.net/documentation/v1/references/index.html)
