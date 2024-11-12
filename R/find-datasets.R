#' Find the available measures within a measure category.
#'
#' @param measure_category_code A measure category code. See
#' `get_measure_categories()` for a list.
#' @param trim Whether or not to exclude the potentially unecessary variables.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' get_measures_from_category("MYH-CANCER")
#' }
get_measures_from_category <- function(measure_category_code, trim = TRUE) {
  url <- as.character(glue::glue("measure-categories/{measure_category_code}/measures"))
  d <- call_aihw_api(url)$result |>
    tidy_resp_to_df()

  if (trim) {
    d <- d |>
      dplyr::select(measure_code, measure_name, units = units_units_name)
  }

  d
}


#' Read (multiple) datasets by id
#'
#' @param ids id of the dataset. See `get_datasets()`.
#' @param return_caveats A logical. Whether or not to return the caveats for
#' this data in a separate table. If `TRUE`, this will return a list with the
#' two tables.
#'
#' @return data
#' @export
#'
#' @examples
#' \donttest{
#' read_dataset_ids(c(1, 2))
#' }
read_dataset_ids <- function(ids, return_caveats = FALSE) {
  d_datasets <- get_datasets() |>
    dplyr::filter(data_set_id %in% ids)

  if (any(!ids %in% d_datasets$data_set_id)) {
    missing_ids <- ids[!ids %in% d_datasets$data_set_id] |>
      paste0(collapse = ", ")
    warning(glue::glue("IDs passed were not valid (available in `get_datasets()`): {missing_ids}"))
  }

  dframes <- d_datasets$data_set_id |>
    purrr::map(read_dataset_by_id) |>
    dplyr::bind_rows() |>
    tidy_flat_data_extract(return_caveats = return_caveats)

  dplyr::left_join(d_datasets, dframes, by = "data_set_id")
}


read_dataset_by_id <- function(id) {
  url <- as.character(glue::glue("datasets/{id}/data-items"))
  call_aihw_api(url)$result |> tidy_resp_to_df()
}
