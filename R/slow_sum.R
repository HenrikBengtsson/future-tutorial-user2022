slow_sum <- function(x) {
  sum <- 0
  for (kk in seq_along(x)) {
    sum <- sum + x[kk]
    Sys.sleep(0.1)  # emulate 0.1 second cost per addition
  }
  sum
}
