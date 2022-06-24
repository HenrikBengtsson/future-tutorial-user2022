strict_sqrt <- function(x) {
  if (x < 0) {
    stop(errorCondition(
      paste("sqrt(x) with x < 0 not allowed:", x), 
      call = sys.call(),
      class = "strict_error")
    )
  }
  sqrt(x)
}
