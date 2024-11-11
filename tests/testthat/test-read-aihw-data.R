test_that("can read admissions data", {
  skip_if_offline()
  d_adms <- call_aihw_api("measure-downloads/myh-adm")

  # returns data
  expect_s3_class(d_adms, "data.frame")

  # has sensible names (having skipped the header)
  expect_false(any(stringr::str_detect(names(d_adms), "^x[0-9]")))
})
