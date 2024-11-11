#' Base URL for the MyHospitals API
base_url <- "https://myhospitalsapi.aihw.gov.au/api/v1/"

get_api_urls <- function() {
  c(
    "caveats",
    "datasets",
    "measure-downloads",
    "reporting-unit-downloads",
    "simple-downloads/download-codes",
    "measure-categories",
    "measures",
    "reported-measure-categories",
    "reported-measures",
    "reporting-unit-types"
  )
}

#' Call the AIHW API
#'
#' @param api_url url
#'
#' @return something useful, usually a `data.frame`
#' @export
#'
#' @examples
#' \donttest{
#' call_aihw_api("measure-downloads/myh-adm")
#' }
call_aihw_api <- function(api_url) {
  # Create the base request
  req <- httr2::request(paste0(base_url, api_url))

  # Choose the appropriate method and perform the request
  resp <- httr2::req_perform(req)

  # Check for errors based on the status code
  resp_check_status(resp)

  if (is_body_xlsx(resp)) {
    fpath <- write_resp(resp)
    return(read_aihw_xlsx(fpath))
  }

  # Return the parsed content of the response
  httr2::resp_body_json(resp)
}

# Example usage:
# result <- call_api("datasets")
#
# result$result |> map(unlist) |> bind_rows() |> View()
#
# res2 <- call_api("datasets/2/data-items")
#
# res3 <- call_api("measure-downloads/measure-download-codes")

# res4 <- call_aihw_api("measure-downloads/myh-adm")
