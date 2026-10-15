# spp_taxonconcept() defaults work

    Code
      print(res)
    Output
      
      -- General info - CITES ($general): --------------------------------------------
      # A tibble: 1 x 9
        id    full_name       author_year rank  name_status updated_at          active
      * <chr> <chr>           <chr>       <chr> <chr>       <dttm>              <lgl> 
      1 4521  Loxodonta afri~ (Blumenbac~ SPEC~ A           2026-09-08 15:28:17 TRUE  
      # i 2 more variables: eu_listing <chr>, cites_listing <chr>
      
      -- Classification ($higher_taxa): ----------------------------------------------
      # A tibble: 1 x 6
        id    kingdom  phylum   class    order       family      
        <chr> <chr>    <chr>    <chr>    <chr>       <chr>       
      1 4521  Animalia Chordata Mammalia Proboscidea Elephantidae
      
      -- Synonyms ($synonyms): -------------------------------------------------------
      No records available.
      
      -- Common names ($common_names): -----------------------------------------------
      # A tibble: 53 x 3
            id name                  language
         <int> <chr>                 <chr>   
       1  4521 Haathi                UR      
       2  4521 Elefante              PT      
       3  4521 Ndovo                 SW      
       4  4521 Norsu                 FI      
       5  4521 afrikansk elefant     DA      
       6  4521 Elefant               NO      
       7  4521 Afrikanischer Elefant DE      
       8  4521 Elefante              EU      
       9  4521 Slon                  BG      
      10  4521 Elefante africano     IT      
      # i 43 more rows
      
      Information available: $all_id, $general, $higher_taxa, $accepted_names, $common_names, $synonyms, $cites_listings 

