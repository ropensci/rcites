This is a minor release, several bugs have been fixed and spp_*() functions gain a new argument *pause* to prevent functions from throwing errors caused by too many calls to the web API (which, for some reason, caused http 404 errors).

## Test environments

* MacOSX 10.13.6 (on travis-ci), R-release,
* Ubuntu 14.04 (on travis-ci): R-oldrel,
* Ubuntu 16.04 (on travis-ci): R-release,
* Ubuntu 18.04 (on travis-ci): R-devel,
* Windows Server 2012 R2 x64 (on appveyor): R-release,
* win-builder (R-release and R-devel),
* local Debian 10 (4.19.0-8-amd64), R-3.6.3.


## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES.


## Downstream dependencies

There are currently no downstream dependencies for this package.
