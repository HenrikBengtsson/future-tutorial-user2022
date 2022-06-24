slow_sqrt <- function(X) {
  p <- progressr::progressor(along = X)
  lapply(X, function(x) {
    Sys.sleep(0.1)
    p(message = sprintf("x=%g", x))
    sqrt(x)
  })
}
