# Tutorial: An Introduction to Futureverse for Parallel Processing in R

* Where: online, useR! 2022 conference (June 20-24, 2022)
* When: Monday 2022-06-20 07:00-10:30 UTC-0700
* Length: 2.5 hours + 1.0 hour optional (including breaks)
* Instructor: Henrik Bengtsson, University of California, San Francisco, USA
* URL: https://user2022.r-project.org/program/tutorials/#futureverse-parallelization-in-r
* Event URL: https://www.accelevents.com/e/user2022/portal/workshops/260741

## Abstract

In this tutorial, you will learn how to use the **future** framework to turn sequential R code into parallel R code with minimal effort. 

There are a few ways to parallelize R code. Some solutions come built-in with R (**parallel** package) and others are provided through R packages available on CRAN. The **future** framework, available on CRAN since 2015 and used by hundreds of R packages, is designed to unify and leverage common parallelization frameworks in R, to make new and existing R code faster with minimal effort by the developer.

The futureverse (<https://futureverse.org>) allows you, as the developer, to stay with your favorite programming style. For example, **future.apply** provides one-to-one alternatives to base R's `apply()` and `lapply()` functions, **furrr** provides alternatives to **purrr**'s `map()` functions, and **doFuture** provides support for using **foreach**'s `foreach() ...%dopar%` syntax. 

At the same time, the user can switch to a parallel backend of their choice -- e.g., they can parallelize on their local machine, across multiple local or remote machines, towards the cloud, or on a job-scheduler on a high-performance computing (HPC) cluster. As a developer, you do not have to worry about which backend the user picks -- your future-based code will remain the same regardless of the parallel backend.

PS. We will _not_ cover asynchronous Shiny programming using futures and promises in this tutorial.

Acknowledgments: This tutorial and other work on futureverse is funded by Essential Open Source Software program ran by the Chan Zuckerberg Initiative (CZI EOSS #4).



## Objectives

After completing this tutorial, my hope is that you:

* find parallelization less magic

* find parallelization less intimidating

* feel comfortable parallelize your own R code

and understand how the **future** framework:

* significantly lowers the bar to get started with parallelization

* helps you avoid common mistakes and issues

* takes care of many things you otherwise have to worry about

* scales and is "future" proof

* keeps getting improved


## Preparing for this tutorial

* R version: R (>= 4.0.0) is recommended, but all of the tutorial should work with R (>= 3.5.0). R 4.2.0 was released on April 22, 2022.

* Operating system: Linux, macOS, or MS Windows

* Terminal, RStudio, Rgui, R.app, RStudio Cloud, ...: whichever you prefer


Ahead of time, before attending the tutorial, please install the following R packages:

```r
install.packages("future")         # ~ 30 sec
install.packages("future.apply")   # ~ 15 sec
install.packages("doFuture")       # ~ 15 sec
install.packages("doRNG")          # ~ 15 sec
install.packages("furrr")          # ~ 60 sec
install.packages("future.callr")   # ~ 30 sec
install.packages("progressr")      # ~ 15 sec
install.packages("progress")       # ~ 15 sec
```

The time estimates are when install the package from source on a fresh Linux R setup with a 1 Gbit/s internet connection.  It's faster when installing from binaries on macOS and MS Windows.

If you already have some of these installed, please make sure to they are up-to-date before starting this tutorial, i.e.

```r
update.packages()
```

If you have any issues, please reach out for help on <https://github.com/HenrikBengtsson/future-tutorial-user2022/discussions/>.
