tidy_resp_to_df <- function(result){
  result |>
    purrr::map(unlist) |>
    dplyr::bind_rows() |>
    janitor::clean_names()
}

#' Get set of measure categories which can be used in `read_flat_data_extract()`.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' get_measure_categories()
#' }
get_measure_categories <- function() {
  res <- call_aihw_api("measure-categories")
  tidy_resp_to_df(res$result)
}

#' Show available datasets.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' get_datasets()
#' }
get_datasets <- function() {
  res <- call_aihw_api("datasets")
  tidy_resp_to_df(res$result)
}

#' Get set of measure download codes that can be used in `get_measure_data()`.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' get_measure_download_codes()
#' }
get_measure_download_codes <- function() {
  res <- call_aihw_api("measure-downloads/measure-download-codes")
  tidy_resp_to_df(res$result)
}


#' Get data by measure download code.
#'
#' @param measure_download_code A measure download code. See `datasheet_code` in
#' `get_measure_download_codes()`.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' get_measure_data("myh-adm")
#' }
get_measure_data <- function(measure_download_code) {
  assertthat::assert_that(assertthat::is.string(measure_download_code))
  assertthat::assert_that(measure_download_code %in% get_measure_download_codes()$datasheet_code)

  call_aihw_api(paste0("measure-downloads/", measure_download_code))
}

#' Get data by measure category.
#'
#' @param measure_category_code A measure category code. See
#' `get_measure_categories()` for valid codes.
#' @param measure_code A measure code.
#' @param return_caveats A logical. Whether or not to return the caveats for
#' this data in a separate table. If `TRUE`, this will return a list with the
#' two tables.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' read_flat_data_extract(measure_category_code = "MYH-CANCER")
#' read_flat_data_extract(measure_category_code = "MYH-CANCER", measure_code = "MYH0001")
#' }
read_flat_data_extract <- function(measure_category_code, measure_code, return_caveats = FALSE) {
  assertthat::assert_that(assertthat::is.string(measure_category_code))
  assertthat::assert_that(measure_category_code %in% get_measure_categories()$measure_category_code)

  measure_code_str <- ""
  if(!missing(measure_code)) {
    assertthat::assert_that(assertthat::is.string(measure_code))

    # bit of an expensive assertion to make so have commented it out - hopefully
    # MyHospitals adds the measure_codes to the download-codes api sometime..

    # measure_codes <- read_flat_data_extract(measure_category_code)$measure_code
    # assertthat::assert_that(measure_code %in% measure_codes)

    measure_code_str <- paste0("&measure_code=", measure_code)
  }

  max_rows <- 1000

  res <- call_aihw_api(paste0("flat-data-extract/", measure_category_code, "?skip=0&top=5", measure_code_str))

  total_rows <- res$result$pagination$total_results_available

  skips <- seq(from = 0, to = total_rows - 1, by = max_rows)
  tops <- purrr::map(skips, ~min(c(max_rows, total_rows - .x)))

  dframes <- purrr::map2(
    .x = skips, .y = tops,
    .f = ~call_flat_data_segment(
      url = paste0("flat-data-extract/", measure_category_code),
      measure_code_str = measure_code_str,
      skip = .x,
      top = .y
    )
  )

  dframes |>
    dplyr::bind_rows() |>
    tidy_flat_data_extract(return_caveats = return_caveats)
}

call_flat_data_segment <- function(url, skip, top, measure_code_str) {
  res <- call_aihw_api(as.character(glue::glue("{url}?skip={skip}&top={top}{measure_code_str}")))
  tidy_resp_to_df(res$result$data)
}

tidy_flat_data_extract <- function(data, return_caveats) {
  if("caveat" %in% names(data)) {
    d_caveats <- data |>
      dplyr::select(caveat:dplyr::last_col()) |>
      dplyr::filter(!is.na(caveat))

    data <- data |>
      dplyr::select(1:caveat) |>
      dplyr::filter(is.na(caveat)) |>
      dplyr::select(-caveat)
  }

  if(return_caveats) {
    res <- list(data = data, d_caveats = d_caveats)
  } else {
    res <- data
  }

  res
}
