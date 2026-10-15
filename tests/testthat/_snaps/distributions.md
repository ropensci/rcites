# spp_distributions() defaults work

    Code
      print(res)
    Output
      
      -- Distributions ($distributions): ---------------------------------------------
      # A tibble: 27 x 5
            id iso_code2 name         type    tags 
         <int> <chr>     <chr>        <chr>   <chr>
       1  1778 ML        Mali         COUNTRY ""   
       2  4429 RW        Rwanda       COUNTRY ""   
       3  5628 SD        Sudan        COUNTRY ""   
       4  6724 ET        Ethiopia     COUNTRY ""   
       5 15554 CM        Cameroon     COUNTRY ""   
       6 19004 MZ        Mozambique   COUNTRY ""   
       7 21296 ZW        Zimbabwe     COUNTRY ""   
       8 22598 BW        Botswana     COUNTRY ""   
       9 25648 ZA        South Africa COUNTRY ""   
      10 34325 BF        Burkina Faso COUNTRY ""   
      # i 17 more rows
      
      -- References ($references): ---------------------------------------------------
      # A tibble: 108 x 2
            id reference                       
         <int> <chr>                           
       1  1778 Kingdon, J., Happold [truncated]
       2  4429 Jackson, P. 1982. El [truncated]
       3  4429 Monfort, A. 1992. Pr [truncated]
       4  5628 Hameed, S.M.A. and E [truncated]
       5  6724 Bolton, M. 1973. Not [truncated]
       6  6724 Largen, M. J. and Ya [truncated]
       7  6724 Meester, J. and Setz [truncated]
       8 15554 Bauer, H. and Kari,  [truncated]
       9 15554 Blanc, J.J., Thoules [truncated]
      10 15554 Bowden, C. G. R. 198 [truncated]
      # i 98 more rows

# spp_distributions() works when no info available

    Code
      print(res)
    Output
      
      -- Distributions ($distributions): ---------------------------------------------
      No records available.
      
      -- References ($references): ---------------------------------------------------
      No records available.

