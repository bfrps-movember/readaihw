# reading mental health admmissions datasets

    Code
      d_mental_health_adms
    Output
      # A tibble: 7,624 x 15
         data_set_id data_set_name       reported_measure_sum~1 reported_measure_sum~2
         <chr>       <chr>               <chr>                  <chr>                 
       1 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       2 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       3 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       4 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       5 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       6 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       7 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       8 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       9 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
      10 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
      # i 7,614 more rows
      # i abbreviated names:
      #   1: reported_measure_summary_measure_summary_measure_code,
      #   2: reported_measure_summary_measure_summary_measure_name
      # i 11 more variables: reported_measure_summary_reported_measure_code <chr>,
      #   reported_measure_summary_reported_measure_name <chr>,
      #   reporting_end_date <chr>, reporting_start_date <chr>, ...

# read_dataset_ids() offline

    Code
      d_mental_health_adms
    Output
      # A tibble: 7,624 x 15
         data_set_id data_set_name       reported_measure_sum~1 reported_measure_sum~2
         <chr>       <chr>               <chr>                  <chr>                 
       1 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       2 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       3 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       4 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       5 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       6 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       7 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       8 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
       9 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
      10 1329        ADM 2012-13 - Numb~ MYH0024                Number of admissions ~
      # i 7,614 more rows
      # i abbreviated names:
      #   1: reported_measure_summary_measure_summary_measure_code,
      #   2: reported_measure_summary_measure_summary_measure_name
      # i 11 more variables: reported_measure_summary_reported_measure_code <chr>,
      #   reported_measure_summary_reported_measure_name <chr>,
      #   reporting_end_date <chr>, reporting_start_date <chr>, ...

---

    Code
      mental_health_adms_with_caveats
    Output
      $caveats
      # A tibble: 2 x 8
        caveats_caveat_code caveats_caveat_display_value caveats_caveat_footnote      
        <chr>               <chr>                        <chr>                        
      1 X52                 <5                           If an admissions count is le~
      2 X01                 <5                           <NA>                         
      # i 5 more variables: caveats_caveat_name <chr>,
      #   suppressions_suppression_code <chr>,
      #   suppressions_suppression_display_value <chr>,
      #   suppressions_suppression_footnote <chr>,
      #   suppressions_suppression_name <chr>
      
      $data
      # A tibble: 8,367 x 15
         data_set_id data_set_name       reported_measure_sum~1 reported_measure_sum~2
         <chr>       <chr>               <chr>                  <chr>                 
       1 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       2 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       3 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       4 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       5 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       6 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       7 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       8 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
       9 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
      10 904         ADM 2011-12 - Numb~ MYH0024                Number of admissions ~
      # i 8,357 more rows
      # i abbreviated names:
      #   1: reported_measure_summary_measure_summary_measure_code,
      #   2: reported_measure_summary_measure_summary_measure_name
      # i 11 more variables: reported_measure_summary_reported_measure_code <chr>,
      #   reported_measure_summary_reported_measure_name <chr>,
      #   reporting_end_date <chr>, reporting_start_date <chr>, ...
      

# read_dataset_by_id() offline

    Code
      data_904
    Output
      # A tibble: 660 x 16
         data_set_id measure_code reported_measure_code reporting_unit_summary_repor~1
         <chr>       <chr>        <chr>                 <chr>                         
       1 904         MYH0024      MYH-RM0216            H0012                         
       2 904         MYH0024      MYH-RM0216            H0013                         
       3 904         MYH0024      MYH-RM0216            H0014                         
       4 904         MYH0024      MYH-RM0216            H0015                         
       5 904         MYH0024      MYH-RM0216            H0016                         
       6 904         MYH0024      MYH-RM0216            H0017                         
       7 904         MYH0024      MYH-RM0216            H0018                         
       8 904         MYH0024      MYH-RM0216            H0019                         
       9 904         MYH0024      MYH-RM0216            H0020                         
      10 904         MYH0024      MYH-RM0216            H0021                         
      # i 650 more rows
      # i abbreviated name: 1: reporting_unit_summary_reporting_unit_code
      # i 12 more variables: reporting_unit_summary_reporting_unit_name <chr>,
      #   reporting_unit_summary_reporting_unit_type_reporting_unit_type_code <chr>,
      #   reporting_unit_summary_reporting_unit_type_reporting_unit_type_name <chr>,
      #   value <chr>, caveats_caveat_code <chr>, caveats_caveat_display_value <chr>,
      #   caveats_caveat_footnote <chr>, caveats_caveat_name <chr>, ...

