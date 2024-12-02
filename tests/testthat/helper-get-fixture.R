get_fixture <- function(fname) {
  readRDS(file.path(test_path(), "fixtures", paste0(fname, ".rds")))
}
