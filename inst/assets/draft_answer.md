We are grateful to the reviewers for the time they spent on reviewing our package and for the quality of their comments that significantly contributed to
improve our package. We added both reviewers on the list of contributors
in `DESCRIPTION` with the role "rev" and we would like to have their formal
consent before the next CRAN release.

=> KC: should we offer more than "rev"?

We have carefully addressed the reviewers' comments and added several new
features to our package following their suggestions. Given the nature and the
number of changes we have made since the last version, we are considering
the new version as a major release (the future CRAN release would be v1.0.0).


## Changes in functions

### data.table is no longer imported

We agree with Noam Ross that the use of `data.table` was not particularly relevant for our package we therefore removed the dependencies to this package. This was handled in [#34](https://github.com/ibartomeus/rcites/pull/34).

### Reviewing functions outputs

As suggested by Noam Ross, all outputs are now S3 objects with specific print methods, gathered in `print.R`. These objects are lists of data.frame of class `c("tbl_df", "tbl", "data.frame")`. Furthermore we added a `raw` parameter (set to `FALSE` by default) to functions that retrieve data from the Species+ API. As argued by Noam Ross, this gives the opportunity to advanced users to parse the output themselves. Objects returned when `raw = TRUE` are of class `c("list", "spp_raw")` and a print method was borrowed from the example Noam Ross brought to our attention.


### New parameters to better include the API features

Our functions now integrate all parameters of the Species+ API, meaning:

- `taxonomy` (the package now handles requests for the "CMS" data base), `with_descendants`, `language`, `updated_since`, `per_page`, `pages` (that enables to select any a set of pages) were added to `spp_taxonconcept()`,
- `scope` and `language` were added to `spp_eu_legislation()` and `spp_cites_legislation()`,
- `language` was added to `spp_distributions()`


### Bulk analysis

In order to allow the user to perform bulk analysis using `spp_taxonconcept()`
we build an auto-pagination into the  `spp_taxonconcept()`, the user is now
able to retrieve more than 500 entries at once (*i.e.* all entries of the data base when `query_taxon=""`). When more than one page must be fetched a message is prompted
(if `verbose` is set to `TRUE`).





All the changes mentioned above required a new set of tests handled in #

### Addition of new helpers and unit testing

All the changes mentioned above required a couple of new helpers functions gathered in `zzz.R`
as in the previous version. Also the unit testing has been extensively reviewed.




## Changes in documentation

All the new parameters have been carefully documented. We did our best to improve
the functions outputs (this was handled in [#35](https://github.com/ibartomeus/rcites/pull/35)).
We now use markdown to document the package (see https://cran.r-project.org/web/packages/roxygen2/vignettes/markdown.html)
The website has been rebuilt.

### `set_token()`

As noticed by Margaret Siple:

> Setting the token: set_token() example should note that token is entered as a character string if it is within the function, and without quotes (not a character object) when it's entered after the prompt.

This is now mentioned in the documentation of the argument `token` of `set_token()`, we have also slightly changed the message prompted:  

```r
readline("Enter your token without quotes: ")
```


### Helpers functions

> There are a lot of rcites_ functions within the package functions (e.g., rcites_getsecret() which is used in spp_taxonconcept()) which don't work on their own. Since the wrapper functions around them work, I think it's fine; I was just confused as to what they are.

These are helpers functions we use to better structure our code as they avoid
code redundancy. There are not part of the package API but important for
developers of the package.

> I'm not sure what the rOpenSci guidelines are for these functions.

Good point! To us, it sounds like a common practice but we are happy to make
our code compliant to better practice!



### Vignettes

Magaret Siple noticed that:

> I love that code for making distribution maps is included in the vignette, but had some issues with the example. The mapping example in the vignette doesn't work- the following error occurs when running as.data.frame(spp_distributions("4521")):

We have now rebuild the vignettes and it works.
