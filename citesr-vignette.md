---
title: "citesr vignette"
author: "citesr team"
date: "11 December 2017"
output: html_document
---

## Set up a connection to the species plus database

To set up a connection to the Species+/CITES database you will need an authentication token. You can get a token from [here](http://api.speciesplus.net/users/sign_up) by registering as a user of the Species+/CITES API. 

After creating the user account and getting a token, you can make the function 'sppplus_connect', for connecting with the Species+/CITES database. 

After creating this function, assign cnx using this command: ```{r echo=FALSE} cnx <- sppplus_connect(token = 'fill-in-your-token-here')```


## 

