# rcites 0.1.1.9000

- new features:
  - `spp_taxonconcept()`
  - outputs:
    - spp_raw

- add function parameters:

  - `taxonomy`, `with_descendants`, `language`, `updated_since`, `per_page`,
  `seq_page`, `raw`, `verbose` in `spp_taxonconcept()`
  - `scope` and `language` to `spp_cites_legislation()`
  - `scope` and `language` to `spp_eu_legislation()`
  - `language` to `spp_distribution()`

- change function names:

  - `set_token()` instead of sppplus_login
  - `spp_taxonconcept()` instead of sppplus_taxonconcept
  - `spp_cites_legislation()` instead of taxon_cites_legislation
  - `spp_eu_legislation()` instead of taxon_eu_legislation
  - `spp_distribution()` instead of taxon_distribution
  - `spp_references()` instead of taxon_references
  - `rcites_simplify()` instead of sppplus_simplify
  - `rcites_ instead()` of sppplus_ for helper functions

- follow `goodpractice`:

  - use '<-' for assignment instead of '=',
  - omit "Date" in DESCRIPTION,
  - avoid 1:length(...), 1:nrow(...), 1:ncol(...),
  - remove ‘jsonlite’ from DESCRIPTION.


# rcites 0.1.0

First release

## Features

- spp_taxonconcept( ): [access the Speciesplus taxon concept](https://api.speciesplus.net/documentation/v1/taxon_concepts/index.html)
- spp_cites_legislation( ): [access CITES legislation data](https://api.speciesplus.net/documentation/v1/cites_legislation/index.html)
- spp_eu_legislation( ): [access EU legislation data](https://api.speciesplus.net/documentation/v1/eu_legislation/index.html)
- spp_distribution( ): [access a taxon distribution data](https://api.speciesplus.net/documentation/v1/distributions/index.html)
- spp_references( ): [access a listing reference data](https://api.speciesplus.net/documentation/v1/references/index.html)
