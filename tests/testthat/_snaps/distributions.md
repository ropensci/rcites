# spp_distributions() defaults work

    Code
      print(res)
    Output
      
      -- Distributions ($distributions): ---------------------------------------------
      # A tibble: 42 x 5
            id iso_code2 name              type    tags 
         <int> <chr>     <chr>             <chr>   <chr>
       1  1778 ML        Mali              COUNTRY ""   
       2  1923 GQ        Equatorial Guinea COUNTRY ""   
       3  4429 RW        Rwanda            COUNTRY ""   
       4  4491 GH        Ghana             COUNTRY ""   
       5  5628 SD        Sudan             COUNTRY ""   
       6  6724 ET        Ethiopia          COUNTRY ""   
       7  8995 GA        Gabon             COUNTRY ""   
       8 12983 AO        Angola            COUNTRY ""   
       9 15554 CM        Cameroon          COUNTRY ""   
      10 17060 BJ        Benin             COUNTRY ""   
      # ... with 32 more rows
      
      -- References ($references): ---------------------------------------------------
      # A tibble: 146 x 2
            id reference                       
         <int> <chr>                           
       1  1778 Kingdon, J., Happold [truncated]
       2  1923 Basilio, A. 1962. La [truncated]
       3  4429 Jackson, P. 1982. El [truncated]
       4  4429 Monfort, A. 1992. Pr [truncated]
       5  4491 Grubb, P., Jones, T. [truncated]
       6  4491 Jackson, P. 1982. El [truncated]
       7  5628 Hameed, S.M.A. and E [truncated]
       8  6724 Bolton, M. 1973. Not [truncated]
       9  6724 Largen, M. J. and Ya [truncated]
      10  6724 Meester, J. and Setz [truncated]
      # ... with 136 more rows

# spp_distributions() works when no info available

    Code
      print(res)
    Output
      
      -- Distributions ($distributions): ---------------------------------------------
      No records available.
      
      -- References ($references): ---------------------------------------------------
      No records available.

