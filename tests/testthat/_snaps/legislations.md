# spp_cites_legislation() defaults work

    Code
      print(res)
    Output
      
      -- Cites listings ($cites_listings): -------------------------------------------
      # A tibble: 10 x 6
         id    taxon_concept_id is_current appendix change_type effective_at
         <chr> <chr>            <lgl>      <chr>    <chr>       <chr>       
       1 30344 4521             TRUE       I        +           2017-01-02  
       2 30115 4521             TRUE       II       +           2019-11-26  
       3 32160 4521             TRUE       II       R+          2019-11-26  
       4 32161 4521             TRUE       II       R+          2019-11-26  
       5 32156 4521             TRUE       II       R+          2019-11-26  
       6 32158 4521             TRUE       II       R+          2019-11-26  
       7 32154 4521             TRUE       II       R+          2019-11-26  
       8 32159 4521             TRUE       II       R+          2019-11-26  
       9 32157 4521             TRUE       II       R+          2019-11-26  
      10 32155 4521             TRUE       II       R+          2019-11-26  
      
      -- Cites quotas ($cites_quotas): -----------------------------------------------
      # A tibble: 38 x 10
         id    taxon_concept_id quota publication_date public_display is_current unit 
         <chr> <chr>            <chr> <chr>            <lgl>          <lgl>      <chr>
       1 25337 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       2 25348 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       3 25355 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       4 25358 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       5 25375 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       6 25390 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       7 25414 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       8 25431 4521             0     2021-02-03       TRUE           TRUE       <NA> 
       9 25554 4521             100   2021-02-03       TRUE           TRUE       <NA> 
      10 25555 4521             300   2021-02-03       TRUE           TRUE       <NA> 
      # ... with 28 more rows, and 3 more variables: geo_entity.iso_code2 <chr>,
      #   geo_entity.name <chr>, geo_entity.type <chr>
      Field(s) not printed:  notes, url 
      
      -- Cites suspensions ($cites_suspensions): -------------------------------------
      # A tibble: 13 x 8
         id    taxon_concept_id start_date is_current applies_to_import
         <chr> <chr>            <chr>      <lgl>      <lgl>            
       1 17621 4521             2014-08-11 TRUE       TRUE             
       2 17620 4521             2014-08-11 TRUE       TRUE             
       3 17686 4521             2014-10-10 TRUE       TRUE             
       4 18709 4521             2010-08-16 TRUE       TRUE             
       5 15983 <NA>             2011-01-19 TRUE       FALSE            
       6 22079 <NA>             2018-01-30 TRUE       FALSE            
       7 22076 <NA>             2018-01-22 TRUE       FALSE            
       8 22132 4521             2018-03-19 TRUE       FALSE            
       9 23168 <NA>             2019-07-04 TRUE       FALSE            
      10 24947 4521             2020-05-26 TRUE       TRUE             
      11 25328 4521             2020-12-11 TRUE       FALSE            
      12 26123 <NA>             2021-05-06 TRUE       FALSE            
      13 26275 4521             2018-06-01 TRUE       TRUE             
      # ... with 3 more variables: geo_entity.iso_code2 <chr>, geo_entity.name <chr>,
      #   geo_entity.type <chr>
      Field(s) not printed:  notes, start_notification.name, start_notification.date, start_notification.url 

