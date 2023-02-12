This is a minor release that mainly improves tests (following the recent changes 
in vcr) and improves code format as well as the set_token() function.

## Problems fixed 

* Following up on your email of the 2022-12-14, I have replaced all `\donttest` 
tags by `\dontrun` because the token will not be set up, and so the same
error will keep on being triggered (error that led to the suggestion of this change). 


## Test environments

* GitHub Actions, Ubuntu 20.04.5: R-oldrel,
* GitHub Actions, Ubuntu 20.04.5: R-release,
* GitHub Actions, Ubuntu 20.04.5: R-devel,
* GitHub Actions, macOS 12.6.2: R-release,
* GitHub Actions, macOS 12.6.2: R-devel,
* GitHub Actions, Microsoft Windows Server 2022 (10.0.20348): R-oldrel,
* GitHub Actions, Microsoft Windows Server 2022 (10.0.20348): R-devel,
* GitHub Actions, Microsoft Windows Server 2022 (10.0.20348): R-release,
* win-builder (R-release and R-devel),
* local Ubuntu 22.04 (Kernel: 5.15.0-53-generic x86_64), R-4.2.2


## R CMD check results.

0 ERRORs | 0 WARNINGs | 0 NOTES.


## Downstream dependencies

There are currently no downstream dependencies for this package.
