test_that("reading mental health admmissions datasets", {
  skip_if_offline()
  dataset_ids <- c(
    "904", "1329", "1336", "2735",
    "2742", "3515", "8115", "8202",
    "8289", "8983", "9658", "10349"
  )

  d_mental_health_adms <- read_dataset_ids(dataset_ids) |>
    dplyr::filter(reporting_end_date <= "2022-06-30") |>
    dplyr::arrange(data_set_id)

  expect_snapshot(d_mental_health_adms)
  expect_s3_class(d_mental_health_adms, "data.frame")
})
