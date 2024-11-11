tidy_resp_to_df <- function(result){
  result |>
    purrr::map(unlist) |>
    dplyr::bind_rows() |>
    janitor::clean_names()
}

#' Title
#'
#' @return data
#' @export
#'
#' @examples
#' get_measure_categories()
get_measure_categories <- function() {
  res <- call_aihw_api("measure-categories")
  tidy_resp_to_df(res$result)
}

#' Title
#'
#' @return data
#' @export
#'
#' @examples
#' get_datasets()
get_datasets <- function() {
  res <- call_aihw_api("datasets")
  tidy_resp_to_df(res$result)
}

#' Title
#'
#' @return data
#' @export
#'
#' @examples
#' get_datasets()
get_measure_download_codes <- function() {
  res <- call_aihw_api("measure-downloads/measure-download-codes")
  tidy_resp_to_df(res$result)
}

#' insert title
#'
#' @param measure_category_code test
#' @param measure_code test
#' @param return_caveats test
#'
#' @return data
#' @export
#'
#' @examples
#' read_flat_data_extract(measure_category_code = "MYH-CANCER")
read_flat_data_extract <- function(measure_category_code, measure_code, return_caveats = FALSE) {
  max_rows <- 1000
  # if only measure_category_code is given:
  res <- call_aihw_api(paste0("flat-data-extract/", measure_category_code, "?skip=0&top=5"))

  total_rows <- res$result$pagination$total_results_available

  skips <- seq(from = 1, to = total_rows, by = max_rows) - 1
  tops <- purrr::map(skips, ~min(c(max_rows, total_rows - .x)))

  dframes <- purrr::map2(
    .x = skips, .y = tops,
    .f = ~call_flat_data_segment(
      url = paste0("flat-data-extract/", measure_category_code),
      skip = .x,
      top = .y
    )
  )

  dframes |>
    dplyr::bind_rows() |>
    tidy_flat_data_extract(return_caveats = return_caveats)
}

call_flat_data_segment <- function(url, skip, top) {
  res <- call_aihw_api(as.character(glue::glue("{url}?skip={skip}&top={top}")))
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



# read_flat_data_extract(measure_category_code = "MYH-CANCER")
#
# read_flat_data_extract(measure_code = "MYH-RM0004")
#
#
# if(FALSE) {
#   res <- call_aihw_api("measure-categories/myh-adm/measures")
#   tidy_resp_to_df(res$result)
#
#
#   res <- call_aihw_api("flat-data-extract/MYH-CANCER?skip=0&top=100")
#
#   res <- call_aihw_api("measures")
#   tidy_resp_to_df(res$result)
#
# }
