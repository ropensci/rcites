We are extremely grateful to the reviewers (@noamross @mcsiple) for the time they spent on reviewing our package and for the quality of their comments that significantly contributed to improve `rcites`. We added both reviewers on the list of contributors in `DESCRIPTION` with the role "rev" and we would like to have their formal consent before the next CRAN release.

We have carefully addressed the reviewers' comments and added several features to our package following their suggestions. Given the nature and the number of changes we have made since the last version, we are considering the new version as a major release (the future CRAN release would be v1.0.0). Below we detail these changes.




## Changes in functions

### `data.table` is no longer a dependency

We agree with Noam Ross that the use of `data.table` was not particularly relevant for our package we therefore removed the dependencies to this package. This was handled in [#34](https://github.com/ibartomeus/rcites/pull/34).


### Reviewing functions outputs

As suggested by Noam Ross, all outputs are now S3 objects with specific print methods, gathered in `print.spp.R`. These objects are lists of data.frame of class `c("tbl_df", "tbl", "data.frame")`. Furthermore, we added a `raw` parameter (set to `FALSE` by default) to functions that retrieve data from the Species+ API. As argued by Noam Ross, this gives the opportunity to advanced users to parse the output themselves. Objects returned when `raw = TRUE` are of class `c("list", "spp_raw")` and a print method was borrowed from the example Noam Ross brought to our attention.


### New parameters to better include the API features

Our functions now integrate all parameters of the Species+ API, that is:

- `taxonomy` (NB the package now handles requests for the "CMS" data base), `with_descendants`, `language`, `updated_since`, `per_page`, `pages` (that enables to select any a set of pages) were added to `spp_taxonconcept()`,
- `scope` and `language` were added to `spp_eu_legislation()` and `spp_cites_legislation()`,
- `language` was added to `spp_distributions()`

### Bulk analysis

In order to allow the user to perform bulk analyses with `spp_taxonconcept()`,
we added an auto-pagination inside `spp_taxonconcept()`. The user is now
able to retrieve more than 500 entries at once (*i.e.* all entries of the data base when `query_taxon=""`). When more than one page must be fetched, a message is prompted (if `verbose` is set to `TRUE`). All these changes required a new set of tests handled in [#35](https://github.com/ibartomeus/rcites/pull/35).

The four remaining `spp_*` functions now support `taxon_id` with more than one
element. This was handled in [#36](https://github.com/ibartomeus/rcites/pull/36). If `taxon_id` has a length greater than 1 the outputs are slightly different. Basically, in such case, we `rbind` all data frames and add a column `taxon_id` to all of them. Such S3 object have class `*_multi` where `*` stands for the name of the class assigned for a single element.

A new vignette [Bulk analysis with rcites](https://ibartomeus.github.io/rcites/articles/bulk_analysis.html) shows how to use these new features.

### Addition of new helper functions and unit testing

All the changes mentioned above required a set of new helpers functions gathered in `zzz.R` as in the previous version. Also the unit testing has been extensively reviewed.





## Changes in the documentation

One general comment: we now use markdown to document the package (see https://cran.r-project.org/web/packages/roxygen2/vignettes/markdown.html).


### Functions parameters and outputs

All the new parameters have been carefully documented. We did our best to improve/simplify functions outputs. We put significant effort into making the description of parameters as clear as possible (this was handled in [#35](https://github.com/ibartomeus/rcites/pull/35)).

### `set_token()`

As noticed by Margaret Siple:

> Setting the token: set_token() example should note that token is entered as a character string if it is within the function, and without quotes (not a character object) when it's entered after the prompt.

This is now mentioned in the documentation of the argument `token` of `set_token()`, we have also slightly changed the message prompted:  

```r
readline("Enter your token without quotes: ")
```

### Helpers functions

> There are a lot of rcites_ functions within the package functions (e.g., rcites_getsecret() which is used in spp_taxonconcept()) which don't work on their own. Since the wrapper functions around them work, I think it's fine; I was just confused as to what they are.

We use these helpers functions to better structure our code, especially to avoid code redundancy. They are not parts of the package API but important for the developers of the package.

> I'm not sure what the rOpenSci guidelines are for these functions.

Good point! To us, it sounds like a common practice but we are happy to make
our code compliant to better practice!

### Vignettes

Magaret Siple noticed that:

> I love that code for making distribution maps is included in the vignette, but had some issues with the example. The mapping example in the vignette doesn't work- the following error occurs when running as.data.frame(spp_distributions("4521")):

We have rebuilt the vignettes and everything works fine. In order to have a comprehensive explanation of the package features, we now have three vignettes in total:

1. [Get started with rcites](https://ibartomeus.github.io/rcites/articles/get_started.html) introduces into the overall package and how to apply the key features.
2. [Study case: the African bush elephant (*Loxodonta africana*)](https://ibartomeus.github.io/rcites/articles/elephant.html) runs through different use examples of the package. More will be added bit by bit.
3. [Bulk analysis with rcites](https://ibartomeus.github.io/rcites/articles/bulk_analysis.html) illustrates how the package's bulk analysis features work.


#### Website

The pkgdown website has been rebuilt to integrate all the change (see
https://ibartomeus.github.io/rcites/index.html).





## Not implemented

Noam Ross had a fair point about the cache, it would be a very powerful feature. It is definitively a direction to go in a future major release (some skills remain to be learned though), in the meanwhile we made this suggestion a milestone (https://github.com/ibartomeus/rcites/milestone/1).
