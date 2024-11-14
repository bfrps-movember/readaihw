test_that("reading mental health admmissions datasets", {
  skip_if_offline()
  dataset_ids <- c(
    "904", "1329", "1336", "2735",
    "2742", "3515", "8115", "8202",
    "8289", "8983", "9658", "10349"
  )

  d_mental_health_adms <- read_dataset_ids(dataset_ids, tidy_data = FALSE) |>
    dplyr::filter(reporting_end_date <= "2022-06-30") |>
    dplyr::arrange(data_set_id)

  expect_snapshot(d_mental_health_adms)
  expect_s3_class(d_mental_health_adms, "data.frame")
})

test_that("tidying datasets works", {
  skip_if_offline()

  d_tidy <- read_dataset_ids(c(1, 2), tidy_data = TRUE)
  d_untidy <- read_dataset_ids(c(1, 2), tidy_data = FALSE)

  # tidy data should have fewer cols than untidy data
  expect_gt(ncol(d_untidy), ncol(d_tidy))


  d_tidy_with_different_measures <- read_dataset_ids(c(1, 8729), tidy_data = TRUE)
  # datasets with different outcome measures should keep the measure names/codes
  expect_gt(ncol(d_tidy_with_different_measures), ncol(d_tidy))
})
