# spp_cites_legislation() defaults work

    Code
      print(res)
    Output
      
      -- Cites listings ($cites_listings): -------------------------------------------
      # A tibble: 5 x 6
        id    taxon_concept_id is_current appendix change_type effective_at
        <chr> <chr>            <lgl>      <chr>    <chr>       <chr>       
      1 40054 4521             TRUE       I        +           2026-03-05  
      2 39737 4521             TRUE       II       +           2026-03-05  
      3 40306 4521             TRUE       II       R+          2026-03-05  
      4 40305 4521             TRUE       II       R+          2026-03-05  
      5 40308 4521             TRUE       II       R+          2026-03-05  
      
      -- Cites quotas ($cites_quotas): -----------------------------------------------
      # A tibble: 28 x 10
         id    taxon_concept_id quota publication_date public_display is_current unit 
         <chr> <chr>            <chr> <chr>            <lgl>          <lgl>      <chr>
       1 32274 4521             100   2025-12-23       TRUE           TRUE       <NA> 
       2 32510 4521             1000  2026-02-06       TRUE           TRUE       <NA> 
       3 32520 4521             74    2026-02-17       TRUE           TRUE       <NA> 
       4 32561 4521             160   2026-02-17       TRUE           TRUE       <NA> 
       5 33587 4521             180   2026-03-10       TRUE           TRUE       <NA> 
       6 33733 4521             300   2026-04-07       TRUE           TRUE       <NA> 
       7 34005 1708             0     2026-04-07       TRUE           TRUE       <NA> 
       8 34074 1708             0     2026-04-07       TRUE           TRUE       <NA> 
       9 34075 1708             0     2026-04-07       TRUE           TRUE       <NA> 
      10 34083 1708             0     2026-04-07       TRUE           TRUE       <NA> 
      # i 18 more rows
      # i 3 more variables: geo_entity.iso_code2 <chr>, geo_entity.name <chr>,
      #   geo_entity.type <chr>
      Field(s) not printed:  notes, url 
      
      -- Cites suspensions ($cites_suspensions): -------------------------------------
      # A tibble: 8 x 8
        id    taxon_concept_id start_date is_current applies_to_import
        <chr> <chr>            <chr>      <lgl>      <lgl>            
      1 17686 4521             2014-10-10 TRUE       TRUE             
      2 18709 4521             2010-08-16 TRUE       TRUE             
      3 22132 4521             2018-03-19 TRUE       FALSE            
      4 23168 <NA>             2019-07-04 TRUE       FALSE            
      5 24947 4521             2020-05-26 TRUE       TRUE             
      6 25328 4521             2020-12-11 TRUE       FALSE            
      7 26275 4521             2018-06-01 TRUE       TRUE             
      8 29503 4521             2024-01-08 TRUE       FALSE            
      # i 3 more variables: geo_entity.iso_code2 <chr>, geo_entity.name <chr>,
      #   geo_entity.type <chr>
      Field(s) not printed:  notes, start_notification.name, start_notification.date, start_notification.url 

