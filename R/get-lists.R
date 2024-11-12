#' Get mappings and locations for hospitals.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' get_hospital_mappings()
#' }
get_hospital_mappings <- function() {
  call_aihw_api("reporting-units-downloads/mappings")
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
