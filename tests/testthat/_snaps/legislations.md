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
       5 32159 4521             TRUE       II       R+          2019-11-26  
       6 32157 4521             TRUE       II       R+          2019-11-26  
       7 32155 4521             TRUE       II       R+          2019-11-26  
       8 32156 4521             TRUE       II       R+          2019-11-26  
       9 32154 4521             TRUE       II       R+          2019-11-26  
      10 32158 4521             TRUE       II       R+          2019-11-26  
      
      -- Cites quotas ($cites_quotas): -----------------------------------------------
      # A tibble: 38 x 10
         id    taxon_con~1 quota publi~2 publi~3 is_cu~4 unit  geo_e~5 geo_e~6 geo_e~7
         <chr> <chr>       <chr> <chr>   <lgl>   <lgl>   <chr> <chr>   <chr>   <chr>  
       1 26662 4521        180   2022-0~ TRUE    TRUE    <NA>  NA      Namibia COUNTRY
       2 27025 4521        0     2022-0~ TRUE    TRUE    <NA>  CM      Camero~ COUNTRY
       3 26972 4521        0     2022-0~ TRUE    TRUE    <NA>  AO      Angola  COUNTRY
       4 26984 4521        0     2022-0~ TRUE    TRUE    <NA>  BJ      Benin   COUNTRY
       5 27019 4521        0     2022-0~ TRUE    TRUE    <NA>  BF      Burkin~ COUNTRY
       6 27033 4521        0     2022-0~ TRUE    TRUE    <NA>  TD      Chad    COUNTRY
       7 27017 4521        800   2022-0~ TRUE    TRUE    <NA>  BW      Botswa~ COUNTRY
       8 27029 4521        0     2022-0~ TRUE    TRUE    <NA>  CF      Centra~ COUNTRY
       9 27042 4521        0     2022-0~ TRUE    TRUE    <NA>  CG      Congo   COUNTRY
      10 27037 4521        0     2022-0~ TRUE    TRUE    <NA>  MW      Malawi  COUNTRY
      # ... with 28 more rows, and abbreviated variable names 1: taxon_concept_id,
      #   2: publication_date, 3: public_display, 4: is_current,
      #   5: geo_entity.iso_code2, 6: geo_entity.name, 7: geo_entity.type
      Field(s) not printed:  notes, url 
      
      -- Cites suspensions ($cites_suspensions): -------------------------------------
      # A tibble: 13 x 8
         id    taxon_concept_id start_date is_current applie~1 geo_e~2 geo_e~3 geo_e~4
         <chr> <chr>            <chr>      <lgl>      <lgl>    <chr>   <chr>   <chr>  
       1 17621 4521             2014-08-11 TRUE       TRUE     US      United~ COUNTRY
       2 17620 4521             2014-08-11 TRUE       TRUE     US      United~ COUNTRY
       3 17686 4521             2014-10-10 TRUE       TRUE     US      United~ COUNTRY
       4 18709 4521             2010-08-16 TRUE       TRUE     ZW      Zimbab~ COUNTRY
       5 15983 <NA>             2011-01-19 TRUE       FALSE    DJ      Djibou~ COUNTRY
       6 22079 <NA>             2018-01-30 TRUE       FALSE    DJ      Djibou~ COUNTRY
       7 22076 <NA>             2018-01-22 TRUE       FALSE    LR      Liberia COUNTRY
       8 22132 4521             2018-03-19 TRUE       FALSE    AU      Austra~ COUNTRY
       9 23168 <NA>             2019-07-04 TRUE       FALSE    SO      Somalia COUNTRY
      10 24947 4521             2020-05-26 TRUE       TRUE     CN      China   COUNTRY
      11 25328 4521             2020-12-11 TRUE       FALSE    IL      Israel  COUNTRY
      12 26275 4521             2018-06-01 TRUE       TRUE     HK      Hong K~ TERRIT~
      13 27577 <NA>             2022-04-05 TRUE       FALSE    GN      Guinea  COUNTRY
      # ... with abbreviated variable names 1: applies_to_import,
      #   2: geo_entity.iso_code2, 3: geo_entity.name, 4: geo_entity.type
      Field(s) not printed:  notes, start_notification.name, start_notification.date, start_notification.url 

