# spp_taxonconcept() defaults work

    Code
      print(res)
    Output
      
      -- General info - CITES ($general): --------------------------------------------
      # A tibble: 1 x 8
        id    full_name       autho~1 rank  name_~2 updated_at          active cites~3
      * <chr> <chr>           <chr>   <chr> <chr>   <dttm>              <lgl>  <chr>  
      1 4521  Loxodonta afri~ (Blume~ SPEC~ A       2022-10-25 10:29:30 TRUE   I/II   
      # ... with abbreviated variable names 1: author_year, 2: name_status,
      #   3: cites_listing
      
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
      # A tibble: 52 x 3
            id name              language
         <int> <chr>             <chr>   
       1  4521 slon africký      SK      
       2  4521 afriški slon      SL      
       3  4521 Ndovo             SW      
       4  4521 Tembo             SW      
       5  4521 Haathi            UR      
       6  4521 Elefante          PT      
       7  4521 Elefante-africano PT      
       8  4521 Słoń afrykański   PL      
       9  4521 Slon              RU      
      10  4521 Elefant           NO      
      # ... with 42 more rows
      
      Information available: $all_id, $general, $higher_taxa, $accepted_names, $common_names, $synonyms, $cites_listings 

