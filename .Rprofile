if (interactive() && nzchar(Sys.getenv("R_TUTORIAL_HOME"))) {
  message(sprintf("The Future Tutorial at useR! 2022 (Running R %s)", getRversion()), appendLF = FALSE)
  setwd(Sys.getenv("R_TUTORIAL_HOME"))
  Sys.unsetenv("R_TUTORIAL_HOME")

  options(repos = c(
    CRAN = "https://cloud.r-project.org",
    BioCsoft = "https://bioconductor.org/packages/3.15/bioc",
    BioCann = "https://bioconductor.org/packages/3.15/data/annotation",
    BioCexp = "https://bioconductor.org/packages/3.15/data/experiment",
    BioCworkflows = "https://bioconductor.org/packages/3.15/workflows",
    BioCbooks = "https://bioconductor.org/packages/3.15/books"
  ))

  ## Install packages in parallel
  options(Ncpus = 4L)
  
  .load_all <- function() {
    suppressPackageStartupMessages({
      library(parallel)
      library(parallelly)
      library(future)
      library(future.apply)
      library(furrr)
      library(foreach)
      library(doFuture)
      library(purrr)
      library(plyr)
      library(progressr)
    })
    
    source("R/slow_sqrt.R")
    source("R/slow_sum.R")
    source("R/strict_sqrt.R")
  }

  ## Setup built-in HTTP daemon
  ## Always serve HTML help on the same port for a given version of R
  local({
    port <- sum(c(1e4, 100) * as.double(R.version[c("major", "minor")]))
    options(help.ports = port + 0:9)
  })
  
  ## Try to start HTML help server
  suppressMessages(try(tools::startDynamicHelp()))

  ## Display help in web browser
  options(help_type = "html")
  
  if (nzchar(Sys.which("xdg-open"))) options(browser = "xdg-open")

  ## Save the R command-line history upon exit
  .Last <- function() {
    if (base::interactive()) {
      file <- Sys.getenv("R_HISTFILE", ".Rhistory")
      try(utils::savehistory(file), silent = TRUE)
    }
  }

  if (isTRUE(as.logical(Sys.getenv("R_PRELOAD", "false")))) {
    .load_all()
    message("*")
  }
  message("")
}
