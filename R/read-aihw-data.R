read_aihw_xlsx <- function(path) {
  d_top <- readxl::read_xlsx(path, n_max = 50, .name_repair = "unique_quiet")
  skip_n <- min(which(!is.na(d_top[2])))
  data <- readxl::read_xlsx(
    path = path,
    skip = skip_n,
    .name_repair = "unique_quiet"
  ) |>
    janitor::clean_names()

  data[, colSums(is.na(data)) < nrow(data)]
}

is_body_xlsx <- function(resp) {
  stringr::str_detect(httr2::resp_content_type(resp), "spreadsheetml.sheet")
}

write_resp <- function(resp, file = tempfile(fileext = "xlsx")) {
  writeBin(httr2::resp_body_raw(resp), file)
  file
}
