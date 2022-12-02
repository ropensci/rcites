This is a minor release that mainly improves tests (following the recent changes 
in vcr) and improve code format as well as the set_token() function.

## Problems fixed 

* In the latest submission, the command `R CMD check --as-cran --run-donttest rcites_1.3.0.tar.gz`
was stuck in a infinite while loop (a token was expected to be set and was not). 
I fixed this problem, I use a for loop with 5 attempts. I also removed the line 
in the example, the documentation of the function is clear enough about this feature. 
* After re-reading some of the CRAN policy about examples, I have added a comment to every \donttest that are used to example why they won't work.
* I ran the command `R CMD check --as-cran --run-donttest rcites_1.3.0.tar.gz`
and it worked (took < 3min to run locally).

## Test environments

* GitHub Actions, Ubuntu 20.04.5: R-oldrel,
* GitHub Actions, Ubuntu 20.04.5: R-release,
* GitHub Actions, Ubuntu 20.04.5: R-devel,
* GitHub Actions, macOS 11.7.1: R-release,
* GitHub Actions, macOS 11.7.1: R-devel,
* GitHub Actions, Microsoft Windows Server 2022 (10.0.20348): R-release,
* GitHub Actions, Microsoft Windows Server 2022 (10.0.20348): R-devel,
* GitHub Actions, Microsoft Windows Server 2022 (10.0.20348): R-release,
* win-builder (R-release and R-devel),
* local Ubuntu 22.04 (Kernel: 5.15.0-53-generic x86_64), R-4.2.2


## R CMD check results.

0 ERRORs | 0 WARNINGs | 0 NOTES.


## Downstream dependencies

There are currently no downstream dependencies for this package.
