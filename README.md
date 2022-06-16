# Tutorial: An Introduction to Futureverse for Parallel Processing in R

* Where: online, useR! 2022 conference (June 20-24, 2022)
* When: Monday 2022-06-20 07:00-10:30 UTC-0700
* Length: 3.5 hours (including breaks)
* Number of participants: 40
* Instructor: Henrik Bengtsson, University of California, San Francisco, USA

## Abstract

In this tutorial, you will learn how to use the **future** framework to turn sequential R code into parallel R code with minimal effort. 

There are a few ways to parallelize R code. Some solutions come built-in with R (**parallel** package) and others are provided through R packages available on CRAN. The **future** framework, available on CRAN since 2015 and used by hundreds of R packages, is designed to unify and leverage common parallelization frameworks in R, to make new and existing R code faster with minimal effort by the developer.

The futureverse (<https://futureverse.org>) allows you, as the developer, to stay with your favorite programming style. For example, **future.apply** provides one-to-one alternatives to base R's `apply()` and `lapply()` functions, **furrr** provides alternatives to **purrr**'s `map()` functions, and **doFuture** provides support for using **foreach**'s `foreach() ...%dopar%` syntax. 

At the same time, the user can switch to a parallel backend of their choice -- e.g., they can parallelize on their local machine, across multiple local or remote machines, towards the cloud, or on a job-scheduler on a high-performance computing (HPC) cluster. As a developer, you do not have to worry about which backend the user picks -- your future-based code will remain the same regardless of the parallel backend.

PS. We will _not_ cover asynchronous Shiny programming using futures and promises in this tutorial.
