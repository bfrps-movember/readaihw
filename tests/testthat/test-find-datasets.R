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

test_that("read_dataset_ids() offline", {
  source(test_path("helper-get-fixture.R"))

  local_mocked_bindings(
    get_datasets = function(...) {
      get_fixture("get_datasets_untidy")
    },
    read_dataset_by_id = function(id) {
      get_fixture(glue::glue("dataset-{id}"))
    }
  )

  dataset_ids <- c(
    "904", "1329", "1336", "2735",
    "2742", "3515", "8115", "8202",
    "8289", "8983", "9658", "10349"
  )

  d_mental_health_adms <- httptest2::without_internet(read_dataset_ids(dataset_ids, tidy_data = FALSE)) |>
    dplyr::filter(reporting_end_date <= "2022-06-30") |>
    dplyr::arrange(data_set_id)

  expect_snapshot(d_mental_health_adms)
  expect_s3_class(d_mental_health_adms, "data.frame")

  mental_health_adms_with_caveats <- httptest2::without_internet(
    read_dataset_ids(dataset_ids, tidy_data = FALSE, return_caveats = TRUE)
  )
  expect_snapshot(mental_health_adms_with_caveats)
  expect_true(inherits(mental_health_adms_with_caveats, "list"))
})


test_that("read_dataset_by_id() offline", {
  source(test_path("helper-get-fixture.R"))

  local_mocked_bindings(
    call_myhosp_api = function(...) {
      get_fixture("dataset-904-api-resp")
    }
  )

  data_904 <- httptest2::without_internet(read_dataset_by_id("904"))

  # the response from the api is taken from fixture so this is testing
  # tidy_resp_to_df()
  expect_snapshot(data_904)
  expect_s3_class(data_904, "data.frame")
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
