# spp_taxonconcept() defaults work

    Code
      print(res)
    Output
      
      -- General info - CITES ($general): --------------------------------------------
      # A tibble: 1 x 8
        id    full_name    author_year    rank  name_status updated_at          active
      * <chr> <chr>        <chr>          <chr> <chr>       <dttm>              <lgl> 
      1 4521  Loxodonta a~ (Blumenbach, ~ SPEC~ A           2021-10-13 13:12:58 TRUE  
      # ... with 1 more variable: cites_listing <chr>
      
      -- Classification ($higher_taxa): ----------------------------------------------
      # A tibble: 1 x 6
        id    kingdom  phylum   class    order       family      
        <chr> <chr>    <chr>    <chr>    <chr>       <chr>       
      1 4521  Animalia Chordata Mammalia Proboscidea Elephantidae
      
      -- Synonyms ($synonyms): -------------------------------------------------------
      # A tibble: 1 x 4
           id full_name          author_year      rank   
        <int> <chr>              <chr>            <chr>  
      1 37069 Loxodonta cyclotis (Matschie, 1900) SPECIES
      
      -- Common names ($common_names): -----------------------------------------------
      # A tibble: 37 x 3
            id name               language
         <int> <chr>              <chr>   
       1  4521 Ndovo              SW      
       2  4521 Tembo              SW      
       3  4521 Haathi             UR      
       4  4521 Elefante           PT      
       5  4521 Slon               RU      
       6  4521 Elefant            NO      
       7  4521 Olifant            NL      
       8  4521 Afrikaanse olifant NL      
       9  4521 Elefante africano  ES      
      10  4521 afrikansk elefant  SV      
      # ... with 27 more rows
      
      Information available: $all_id, $general, $higher_taxa, $accepted_names, $common_names, $synonyms, $cites_listings 

