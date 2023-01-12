--- 
title: "Tutorial: An Introduction to Futureverse for Parallel Processing in R"
author: "Henrik Bengtsson"
date: 2022-06-20
site: bookdown::bookdown_site
documentclass: book
url: https://www.futureverse.org
cover-image: figures/future_logo.png
description: N/A
link-citations: yes
github-repo: HenrikBengtsson/future-tutorial-useR2022
---

# Tutorial Overview {-}

* Title: **An Introduction to Futureverse for Parallel Processing in R**
* Where: online, useR! 2022 conference (June 20-24, 2022)
* When: Monday 2022-06-20 07:00-10:30 UTC-0700
* Length: 3.5 hours (including breaks)
* Instructor: Henrik Bengtsson, University of California, San Francisco, USA
* URL: <https://user2022.r-project.org/program/tutorials/#futureverse-parallelization-in-r>
* Event URL: <https://www.accelevents.com/e/user2022/portal/workshops/260741>
* Video recording: <https://www.youtube.com/watch?t=840&v=yTwPJyRP_bc> (from 0:14:00 until 3:50:30)
* Number of registered participants: 60 (full)

## Abstract {-}

In this tutorial, you will learn how to use the **[future]** framework to turn sequential R code into parallel R code with minimal effort. 

There are a few ways to parallelize R code. Some solutions come built-in with R (**parallel** package) and others are provided through R packages available on CRAN. The **[future]** framework, available on CRAN since 2015 and used by hundreds of R packages, is designed to unify and leverage common parallelization frameworks in R, to make new and existing R code faster with minimal effort by the developer.

The futureverse (<https://futureverse.org>) allows you, as the developer, to stay with your favorite programming style. For example, **[future.apply]** provides one-to-one alternatives to base R's `apply()` and `lapply()` functions, **[furrr]** provides alternatives to **[purrr]**'s `map()` functions, and **[doFuture]** provides support for using **[foreach]**'s `foreach() ...%dopar%` syntax. 

At the same time, the user can switch to a parallel backend of their choice -- e.g., they can parallelize on their local machine, across multiple local or remote machines, towards the cloud, or on a job-scheduler on a high-performance computing (HPC) cluster. As a developer, you do not have to worry about which backend the user picks -- your future-based code will remain the same regardless of the parallel backend.

PS. We will _not_ cover asynchronous Shiny programming using futures and promises in this tutorial.

Acknowledgements: This tutorial and other work on futureverse is funded by Essential Open Source Software programme ran by the Chan Zuckerberg Initiative (CZI EOSS #4).



## Objectives {-}

After completing this tutorial, my hope is that you:

* find parallelization less magic

* find parallelization less intimidating

* feel comfortable parallelize your own R code

and understand how the **[future]** framework:

* significantly lowers the bar to get started with parallelization

* helps you avoid common mistakes and issues

* takes care of many things you otherwise have to worry about

* scales and is "future" proof

* keeps getting improved


## Preparing for this tutorial {-}

* R version: R (>= 4.0.0) is recommended, but all of the tutorial should work with R (>= 3.5.0). R 4.2.0 was released on April 22, 2022.

* Operating system: Linux, macOS, or MS Windows

* Terminal, RStudio, Rgui, R.app, RStudio Cloud, ...: whichever you prefer


Ahead of time, before attending the tutorial, please install the following R packages:

```r
install.packages("future")         # ~ 30 secs
install.packages("future.apply")   # ~ 15 secs
install.packages("furrr")          # ~ 60 secs
install.packages("foreach")        # ~ 10 secs
install.packages("doFuture")       # ~ 15 secs
install.packages("doRNG")          # ~ 15 secs
install.packages("plyr")           # ~ 60 secs
install.packages("future.callr")   # ~ 30 secs
install.packages("progressr")      # ~ 15 secs
install.packages("progress")       # ~ 15 secs
```

The time estimates are when install the package from source on a fresh Linux R setup with a 1 Gbit/s internet connection.  It's faster when installing from binaries on macOS and MS Windows.

If you already have some of these installed, please make sure to they are up-to-date before starting this tutorial, i.e.

```r
update.packages()
```

If you have any issues, please reach out for help on <https://github.com/HenrikBengtsson/future-tutorial-user2022/discussions/>.


---------------------------------------------------------------------

# Hello and practicalities {-}

## Practicalities {-}

* Format: I will present and do live-coding walkthroughs. There will be no hands-on excercises or working breakout rooms. Feel free to follow along on your own computer

* Feel free to interrupt for questions at any time, especially so clarification questions. Think of it as a classroom tutorial! (not as an online presentation with questions only at the end)

* Feel free to use the Q&A in the conference system to ask questions (https://www.accelevents.com/e/user2022/portal/workshops/260741). I'll try to address them orally. Of course, if someone likes to answer a question in the Q&A, please feel free to do so

* Rule #1: There are no stupid questions. Period. True!  
  (In constrast, _not_ asking about things you wonder about, is a bit silly)

* Help needed during our live session: Please make me aware of new questions in the Q&A chat, if I miss them (I can only multitask so much)

* This tutorial is available on <https://github.com/HenrikBengtsson/future-tutorial-user2022/>

* After the session, feel free to ask more questions on <https://github.com/HenrikBengtsson/future-tutorial-user2022/discussions/>. I'll try my best to help you out there


## Agenda {-}

* (10 min): Hello and practicalities
* (20 min): **Part 1**: An Overview of The Futureverse
* (25 min): **Part 2**: The core **[future]** framework, e.g. `future()` and `value()`
* (10 min): break
* (30 min): **Part 3**: Map-reduce APIs, e.g. **[future.apply]**, **[furrr]**, and **[foreach]**
* (10 min): break
* (35 min): **Part 4**: What makes futures so easy to use? ("Business as usual")
* (10 min): break
* (20 min): **Part 5**: Reporting on progress updates
* (10 min): **Part 6**: Quick summary and comparison to other parallel frameworks
* (20 min): **Part 7**: Random numbers and reproducibility
* (20 min): Open discussion

Total time: 3.5 hours (including breaks)




## Polls {-}

Under 'Polls' in Accelevents (https://www.accelevents.com/e/user2022/portal/workshops/260741), please answer the following questions.


### Poll #1: How much do you know about parallelization in R? {-}

1. I'm new to parallelization in R

2. I've tried the basics (e.g. **parallel** or **[foreach]**), but that's it

3. I've already used the **[future]** framework and want to learn more

4. I have a good understand about the different parallelization solutions in R


### Poll #2: What is your main operating system when using R? {-}

1. Linux
2. macOS
3. MS Windows
4. Web based, e.g. RStudio Cloud
5. Other



### Poll #3: How do you run R? {-}

1. Terminal, e.g. `R`
2. RStudio
3. Rgui (MS Windows)
4. R.app (macOS)
5. VSCode (e.g. vscode-R)
6. Emacs (e.g. Emacs Speaks Statistics)
7. Other


### Poll #4: Do you have access to a cluster? {-}

1. Yes, ad-hoc cluster of local machines
2. Yes, ad-hoc cluster in the cloud
3. Yes, a high-performance compute (HPC) cluster with a job scheduler
4. Yes, something else
5. No
6. What does this even mean?


---------------------------------------------------------------------

# An Overview of The Futureverse

## Why do we parallelize?

Parallel & distributed processing can be used to:

* speed up processing (wall time)
* lower memory footprint (per machine)
* avoid data transfers (compute where data lives)
* other reasons, e.g. asynchronous UI/UX


## The future package (the core of it all)

![The hexlogo for the 'future' package adopted from original designed by Dan LaBar](figures/future_logo.png)

* A simple, unifying solution for parallel APIs
* "Write once, run anywhere"
* 100% cross platform, e.g. Linux, macOS, MS Windows
* Easy to install (< 0.5 MiB total); `install.packages("future")`
* Well tested, lots of CPU mileage, used in production
* Things should "just work"
* Design goal: keep as minimal as possible


## Quick intro: Evaluate R in the background

### Sequentially

```r
x <- 7
y <- slow(x)           # ~1 minute
z <- another(x)        # ~0.5 minute
                       # all done in ~1.5 minutes
```

### In parallel

```r
library(future)
plan(multisession)     # run things in parallel

x <- 7
f <- future(slow(x))   # ~1 minute (in background)   ‎
z <- another(x)        # ~0.5 minute (in current R session)
y <- value(f)          # get background results
                       # all done in ~1 minutes
```


## Quick intro: Parallel base-R apply

### Sequentially

```r
x <- 1:20
y <- lapply(x, slow)          # ~ 20 minutes
```

### In parallel

```r
library(future.apply)
plan(multisession, workers = 4)

x <- 1:20
y <- future_lapply(x, slow)   # ~ 5 minutes
```


## Quick intro: Parallel tidyverse apply

### Sequentially

```r
library(purrr)

x <- 1:20
y <- map(x, slow)          # ~20 minutes
```

### In parallel

```r
library(furrr)
plan(multisession, workers = 4)

x <- 1:20
y <- future_map(x, slow)   # ~5 minutes
```


## Quick intro: Parallel foreach

### Sequentially

```r
library(foreach)

x <- 1:20
y <- foreach(z = x) %do% slow(z)     # ~20 minutes
```

_Comment_: Technically, we want to use `y <- foreach(z = x) %do% local({ slow(x) })` here.


### In parallel

```r
library(doFuture)
registerDoFuture()
plan(multisession, workers = 4)

x <- 1:20
y <- foreach(z = x) %dopar% slow(z)  # ~5 minutes
```


## What is the Futureverse?

* A Unifying Parallelization Framework in R for Everyone

* Require only minimal changes to parallelize existing R code

* "Write once, Parallelize anywhere"

* Same code regardless of operating system and parallel backend

* Lower the bar to get started with parallelization

* Fewer decisions for the developer to make

* Stay with your favorite coding style

* Worry-free: globals, packages, output, warnings, errors just work

* Statistically sound: Built-in parallel random number generation (RNG)

* Correctness and reproducibilty of highest priority

* "Future proof": Support any new parallel backends to come


### Packages part of the Futureverse

Core API:

* **[future]**

Map-reduce API:

* **[future.apply]**

* **[furrr]**

* **[doFuture]** (used with **[foreach]**, **[plyr]**, and **[BiocParallel]**)

Parallel backends:

* **parallel** (local, MPI, (remote))

* **[future.callr]** (local)

* **[future.batchtools]** (HPC job schedulers)

* more to come

Additional packages:

* **[progressr]** (progress updates, also in parallel)


The first CRAN release was on 2015-06-19, but the initial seed toward building the framework was planted back in 2005. It all grew out of collaborative, real-world research needs of large-scale scientific computations in Genomics and Bioinformatics on all operating systems.


### Who is it for?

* Everyone using R

* Users with some experience in R, but no need to be an advanced R developer

* Anyone who wishes to run many slow, repetive tasks

* Any developer who want to support parallel processing without having to worry about the details and having to maintain parallel code

* Anyone who wishes to set up an _asynchronous_ Shiny app


### Who are using it?

* <https://www.futureverse.org/usage.html>



### What about its quality and stability?

* The **[future]** package on CRAN since 2015 (exactly 7 years ago)

* The API is stable and rarely changes

* Very few breaking changes since the start

* 225 CRAN packages rely on it (<https://www.futureverse.org/statistics.html>)

* Top-1% most downloaded package on CRAN (<https://www.futureverse.org/statistics.html>)

* Every release is well tested (<https://www.futureverse.org/quality.html>)

* I try to work closely with package developers, e.g. deprecation, or issues with design patterns


### Support

Please use:

* Website: <https://www.futureverse.org>

* Package help pages: <https://future.futureverse.org>, <https://future.apply.futureverse.org>, ...

* Discussions, questions and answers: <https://github.com/HenrikBengtsson/future/discussions>

* Bug reports: <https://github.com/HenrikBengtsson/future/issues>


### How to stay up-to-date

* Blog: <https://www.futureverse.org/blog.html> (feed on <https://www.jottr.org/>)

* Twitter: [#RStats](https://twitter.com/search?q=%23RStats) (often with [#parallel](https://twitter.com/search?q=%23RStats%20%23parallel) and [#HPC](https://twitter.com/search?q=%23RStats%20%23HPC))


---------------------------------------------------------------------

# The core Future API

## Three atomic building blocks

There are _three atomic building blocks_ that do everything we need:

* `f <- future(expr)` : evaluates an expression via a future (non-blocking, if possible)

* ` r <- resolved(f)` : TRUE if future is resolved, otherwise FALSE (non-blocking)

* `v <- value(f)` : the value of the future expression expr (blocking until resolved)


### Mental model: The Future API decouples a regular R assignment into two parts

Let's consider a regular assignment in R:

```r
v <- expr
```

To us, this assignment is single operator, but internally it's done in two steps:

1. R evaluates the expression `expr` on the right-hand side (RHS), and
2. assigns the resulting value to the variable `v` on the left-hand side (LHS).

We can think of the Future API as decoupling these two steps and giving us full access to them:

```r
f <- future(expr)
v <- value(f)
```

This decoupling is the key feature of all parallel processing!


Let's break this down using a simple example.  Consider the following, very slow, implementation of `sum()`;

```r
slow_sum <- function(x) {
  sum <- 0
  for (kk in seq_along(x)) {
    sum <- sum + x[kk]
    Sys.sleep(0.1)  # emulate 0.1 second cost per addition
  }
  sum
}
```

For example, if we call:

```r
x <- 1:100
v <- slow_sum(x)
v
#> [1] 5050
```

it takes ten seconds to complete.

We can evaluate this via a future running in the background as:

```r
library(future)
plan(multisession) # evaluate futures in parallel

x <- 1:100
f <- future(slow_sum(x))
v <- value(f)
```

When we call:

```r
f <- future(slow_sum(x))
```

then:

1. a future is created, comprising:
    - the R expression `slow_sum(x)`,
    - function `slow_sum()`, and 
    - integer vector `x`
2. These future components are sent to a parallel worker, which starts
   evaluating the R expression
3. The `future()` function returns immediately a reference `f` to the
   future, and before the future evaluation is completed

When we call:

```r
v <- value(f)
```

then:

1. the future asks the worker if it's ready or not (using `resolved()`
   internally)
2. if it is not ready, then it waits until it's ready (blocking)
3. when ready, the results are collected from the worker
4. the value of the expression is returned


As we saw before, there is nothing preventing us from doing other
things inbetween creating the future and asking for its value, e.g.

```r
## Create future
f <- future(slow_sum(x))

## We are free to do whatever we want while future is running, e.g.
z <- sd(x)

## Wait for future to be done
v <- value(f)
```


### Keep doing other things while waiting

We can use the `resolved()` function to check whether the future is
resolved or not.  If not, we can choose to do other things,
e.g. output a message:

```r
f <- future(slow_sum(x))

while (!resolved(f)) {
  message("Waiting ...")
  Sys.sleep(1.0)
}
message("Done!")

#> Waiting ...
#> Waiting ...
#> Waiting ...
#> ...
#> Waiting ...
#> Done!

v <- value(f)
v
#> [1] 5050
```

We can of course do other things than outputting messages, e.g. calculations and checking in on other futures.


### Evaluate several things in parallel

There's nothing preventing us from launching more than one future in the background.  For example, we can split the summation of `x` into two parts, calculate the sum of each part, and then combine the results at the end:

```r
x_head <- head(x, 50)
x_tail <- tail(x, 50)

v1 <- slow_sum(x_head)         ## ~5 secs (blocking)
v2 <- slow_sum(x_tail)         ## ~5 secs (blocking)
v <- v1 + v2
```

We can do the same in parallel:

```r
f1 <- future(slow_sum(x_head)) ## ~5 secs (in parallel)
f2 <- future(slow_sum(x_tail)) ## ~5 secs (in parallel)

## Do other things
z <- sd(x)

v <- value(f1) + value(f2)     ## ready after ~5 secs
```

We can launch as manual parallel futures as we have parallel workers, e.g.

```r
plan(multisession, workers = 8)
nbrOfWorkers()
#> [1] 8

plan(multisession, workers = 2)
nbrOfWorkers()
#> [1] 2
```

If we launch more than this, then the call to `future()` will block
until one of the workers are free again, e.g.

```r
plan(multisession, workers = 2)
nbrOfWorkers()
#> [1] 2

f1 <- future(slow_sum(x_head))
f2 <- future(slow_sum(x_tail))
f3 <- future(slow_sum(1:200))   ## <= blocks here

resolved(f1)
#> [1] TRUE
resolved(f2)
#> [1] TRUE
resolved(f3)
#> [1] FALSE
```


## Choosing parallel backend

* `plan()` - set how and where futures are evaluated

### sequential (default)

```r
plan(sequential)

f1 <- future(slow_sum(x_head)) # blocks until done
f2 <- future(slow_sum(x_tail)) # blocks until done

v <- value(f1) + value(f2)
```


### multisession: in parallel on local computer

```r
plan(multisession, workers = 2)

f1 <- future(slow_sum(x_head)) # in the background
f2 <- future(slow_sum(x_tail)) # in the background

v <- value(f1) + value(f2)
```

What's happening under the hood is(*):

```r
workers <- parallelly::makeClusterPSOCK(2)
plan(cluster, workers = workers)
```

which is very similar to:

```r
workers <- parallel::makePSOCKcluster(2)
plan(cluster, workers = workers)
```

(*) It actually does `makeClusterPSOCK(2, rscript_libs = .libPaths())`, which gives a smoother ride in some R setups, e.g. RStudio Connect.



### cluster: in parallel on multiple computers

If we have SSH access to other machines with R installed, we can do:

```r
hostnames <- c("pi", "remote.server.org")
plan(cluster, workers = hostnames)

f1 <- future(slow_sum(x_head)) # on either 'pi' or 'remote.server.org'
f2 <- future(slow_sum(x_tail)) # on either 'pi' or 'remote.server.org'

v <- value(f1) + value(f2)
```

What's happening under the hood is:

```r
hostnames <- c("pi", "remote.server.org")
workers <- parallelly::makeClusterPSOCK(hostnames)
plan(cluster, workers = workers)
```

where `makeClusterPSOCK()` connects to the different machines over SSH using pre-configured SSH keys and reverse tunneling of ports.


FYI, if you would try to do this with the **parallel** package, you need to:

1. know your public IP number
2. open up your incoming firewall (requires admin rights + security risk)
3. configure port forwarding from public IP number to your local machine (requires admin rights)

e.g.

```r
workers <- parallel::makePSOCKcluster(hostnames, master = my_public_ip)
```

This is one reason why the **[parallelly]** package was created - "it just works";

```r
workers <- parallelly::makeClusterPSOCK(hostnames)
```

![The 'parallelly' hexlogo](figures/parallelly_logo.png)

The **[parallelly]** package is a utility package, part of the futureverse.



### There are other parallel backends and more to come

#### future.callr - parallelize locally using callr

The **[callr]** package can evaluate R expressions in the background on your local computer.  The **[future.callr]** implements a future backend on top of **[callr]**, e.g.

```r
plan(future.callr::callr, workers = 4)
```

This works similarly to `plan(multisession, workers = 4)`, but has the benefit of being able to run more than 125 background workers, which is a limitation of R itself.



#### future.batchtools - parallelize using batchtools

The **[batchtools]** package is designed to evaluate R expressions via a, so called, job scheduler.  Job schedulers are commonly used on high-performance compute (HPC) clusters, where many users run at the same time.  The job scheduler allows them to request slots on the system, which often has tens or hundreds of compute nodes.  Common job schedulers are Slurm, SGE, and Torque.

The **[future.batchtools]** implements a future backend on top of **[batchtools]**, e.g.

```r
plan(future.batchtools::batchtools_slurm)
```

This will cause `future()` to be submitted to the job scheduler's queue.  When a slot is available, the job is processed on one of the many compute nodes, and when done, the results are stored to file.  Calling `value()` will read the results back into R.

This future backend has a greater latency, because everything has to be queued on a shared job queue.  This backend is useful for long running futures and for the huge throughput that an HPC environment can provide.


---------------------------------------------------------------------

## Motto and design philosophy

Maximize both the developer's and the end-user's control:

* Developer decides what to parallelize, e.g. `future()`

* User decided what parallel backend to use, e.g. `plan()`

Rule of thumb for developers: Don't make assumptions about the user's R environment, e.g. you might have a fast machine with 96 CPU cores, but they might have access to a large multi-machine compute cluster with thousands of cores.  So, let the user decide on the `plan()` and do _not_ set it inside your functions or packages.


## Demo: ggplot2 remotely

![](figures/demo-ggplot2.png)

```r
library(ggplot2)
library(future)
plan(cluster, workers = "remote.server.org")

f <- future({
  ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
})
 
gg <- value(f)
print(gg)
```


---------------------------------------------------------------------

# Map-reduce APIs

Map-reduce packages that work with the **[future]** framework:

* **[future.apply]**

* **[furrr]**

* **[foreach]** (with **[doFuture]**)

* **[plyr]** (with **[doFuture]**)

* **[BiocParallel]** (with **[doFuture]**)

Take-home message: **[future.apply]**, **[furrr]**, **[foreach]**, **[plyr]**, and **[BiocParallel]** (from Bioconductor.org) are siblings. Their goals are the same, but they provide alternative syntax for achieving them. They're all equally good with the same performance and limitations; use the one that you prefer.  It's no different than some people prefer to use base-R `lapply()`, while others prefer to use `purrr::map()`.


## Parallel alternatives to base-R apply functions

The **[future.apply]** package implements plug-and-play, parallel alternatives to base-R apply functions:

| base          | future.apply         |
|:--------------|:---------------------|
| `apply()`     | `future_apply()`     |
| `by()`        | `future_by()`        |
| `eapply()`    | `future_eapply()`    |
| `lapply()`    | `future_lapply()`    |
| `Map()`       | `future_Map()`       |
| `mapply()`    | `future_mapply()`    |
| `replicate()` | `future_replicate()` |
| `sapply()`    | `future_sapply()`    |
| `tapply()`    | `future_tapply()`    |
| `vapply()`    | `future_vapply()`    |

: The most common base-R apply functions and their parallel
  counterparts in the **future.apply** package. {#tbl-future.apply}


<!--
tbl_future_map("base", "future.apply")
-->

<!--
tbl_future_map <- function(pkg, future_pkg) {
  library(pkg, character.only = TRUE)
  library(future_pkg, character.only = TRUE)
  nss <- as.environment(sprintf("package:%s", pkg))
  nsf <- as.environment(sprintf("package:%s", future_pkg))
  ff <- ls(nsf, pattern = "^future_")
  ff <- grep("[.]", ff, value = TRUE, invert = TRUE)
  fs <- gsub("^future_", "", ff)
  keep <- sapply(fs, exists, envir = nss, inherits = FALSE)
  fs <- fs[keep]
  ff <- ff[keep]
  ff <- sprintf("%s()", ff)
  fs <- sprintf("%s()", fs)
  tbl <- data.frame(fs, ff)
  colnames(tbl) <- c(pkg, future_pkg)
  knitr::kable(tbl)
}
-->


### Example: base::lapply(X, FUN)

Let's introduce another slow function that calculates the square root very slowly:

```r
slow_sqrt <- function(x) {
  Sys.sleep(1.0)  ## 1 second emulated slowness
  sqrt(x)
}
```

If run use this with `lapply()` to calculate ten values, it takes 10 seconds:

```r
X <- 1:10
z <- lapply(X, slow_sqrt)  ## takes ~10 seconds
str(z)
#> List of 10
#>  $ : num 1
#>  $ : num 1.41
#>  $ : num 1.73
#>  ...
#>  $ : num 3.16
```

We can parallelize this using **[future.apply]** as:

```r
library(future.apply)
plan(multisession, workers = 4)

z <- future_lapply(X, slow_sqrt)
```

How long will this take?



#### Other future alternatives

Here are parallel alternative for achieving _identical_ results using **[furrr]**, and **[foreach]**, **[plyr]**, and **[BiocParallel]**, while using the **[doFuture]** adaptor.

```r
library(furrr)
plan(multisession, workers = 4)

z <- future_map(X, slow_sqrt)
```

```r
library(foreach)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- foreach(x = X) %dopar% { slow_sqrt(x) }
```

```r
library(plyr)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- llply(X, slow_sqrt, .parallel = TRUE)
```

```r
library(BiocParallel)
register(DoparParam(), default = TRUE)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- bplapply(X, slow_sqrt)
```


#### Non-future alternatives

Here are parallel alternative for achieving _identical_ results using the **parallel** package that comes built-in with R.

```r
library(parallel)
options(mc.cores = 4)

z <- mclapply(X, slow_sqrt)
```

```r
library(parallel)
cl <- makeCluster(4)
parallel::setDefaultCluster(cl)
parallel::clusterExport(varlist = "slow_sqrt")

z <- parLapply(X = X, fun = slow_sqrt)

stopCluster(cl)
```



### Example: base::vapply(X, FUN, FUN.VALUE)

```r
X <- 1:10
z <- vapply(X, slow_sqrt, FUN.VALUE = NA_real_)
str(z)
#> num [1:10] 1 1.41 1.73 2 2.24 ...
```

```r
library(future.apply)
plan(multisession, workers = 4)

z <- future_vapply(X, slow_sqrt, FUN.VALUE = NA_real_)
```


#### Other future alternatives

Here are parallel alternative for achieving _identical_ results using **[furrr]**, and **[foreach]** and **[plyr]**, while using the **[doFuture]** adaptor.

```r
library(furrr)
plan(multisession, workers = 4)

z <- future_map_dbl(X, slow_sqrt)
```

```r
library(foreach)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- foreach(x = X, .combine = c) %dopar% { slow_sqrt(x) }
```

```r
library(plyr)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- laply(X, slow_sqrt, .parallel = TRUE)
```


#### Non-future alternatives

Here are parallel alternative for achieving _identical_ results using the **parallel** package that comes built-in with R.

```r
library(parallel)
options(mc.cores = 4)

z <- mclapply(X, slow_sqrt)
z <- unlist(z, use.names = FALSE)
```

```r
library(parallel)
cl <- makeCluster(4)
parallel::setDefaultCluster(cl)
parallel::clusterExport(varlist = "slow_sqrt")

z <- parLapply(X = X, fun = slow_sqrt)
z <- unlist(z, use.names = FALSE)

stopCluster(cl)
```




### Example: base::mapply(X, Y, FUN)

```r
X <- 1:10
Y <- 10:1
z <- mapply(X, Y, FUN = function(x, y) { slow_sqrt(x * y) })
str(z)
#> [1] 3.162278 4.242641 4.898979 5.291503 5.477226
#> [6] 5.477226 5.291503 4.898979 4.242641 3.162278
```

```r
library(future.apply)
plan(multisession, workers = 4)

z <- future_mapply(X, Y, FUN = function(x, y) { slow_sqrt(x * y) })
```


#### Other future alternatives

Here are parallel alternative for achieving _identical_ results using **[furrr]**, and **[foreach]** and **[plyr]**, while using the **[doFuture]** adaptor.

```r
library(furrr)
plan(multisession, workers = 4)

z <- future_map2_dbl(X, Y, function(x, y) { slow_sqrt(x * y) })
```

```r
library(foreach)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- foreach(x = X, y = Y, .combine = c) %dopar% { 
  slow_sqrt(x * y) 
}
```

```r
library(plyr)
doFuture::registerDoFuture()
plan(multisession, workers = 4)

z <- maply(cbind(x = X, y = Y), 
           function(x, y) { slow_sqrt(x * y) },
           .expand = FALSE)
names(z) <- NULL
```


#### Non-future alternatives

Here are parallel alternative for achieving _identical_ results using the **parallel** package that comes built-in with R.

```r
library(parallel)
options(mc.cores = 4)

z <- mcmapply(X, Y, FUN = function(x, y) { slow_sqrt(x * y) })
```

```r
library(parallel)
cl <- makeCluster(4)
parallel::setDefaultCluster(cl)
parallel::clusterExport(varlist = "slow_sqrt")

z <- parApply(X = cbind(x = X, y = Y), MARGIN = 1L, 
              FUN = function(row) { slow_sqrt(row["x"] * row["y"]) })

stopCluster(cl)
```


## Parallel alternatives to purrr functions

<img alt="" src="figures/furrr_logo.png" style="width: 120px">
<p class="caption">The hexlogo for the 'furrr' package designed by ?? Kuhn</p>

The **[furrr]** package, by Davis Vaughan, implements plug-and-play, parallel alternatives to **[purrr]** functions:

|purrr            |furrr                   |
|:----------------|:-----------------------|
|imap()           |future_imap()           |
|imap_chr()       |future_imap_chr()       |
|imap_dbl()       |future_imap_dbl()       |
|imap_dfc()       |future_imap_dfc()       |
|imap_dfr()       |future_imap_dfr()       |
|imap_int()       |future_imap_int()       |
|imap_lgl()       |future_imap_lgl()       |
|imap_raw()       |future_imap_raw()       |
|invoke_map()     |future_invoke_map()     |
|invoke_map_chr() |future_invoke_map_chr() |
|invoke_map_dbl() |future_invoke_map_dbl() |
|invoke_map_dfc() |future_invoke_map_dfc() |
|invoke_map_dfr() |future_invoke_map_dfr() |
|invoke_map_int() |future_invoke_map_int() |
|invoke_map_lgl() |future_invoke_map_lgl() |
|invoke_map_raw() |future_invoke_map_raw() |
|iwalk()          |future_iwalk()          |
|map()            |future_map()            |
|map_at()         |future_map_at()         |
|map_chr()        |future_map_chr()        |
|map_dbl()        |future_map_dbl()        |
|map_dfc()        |future_map_dfc()        |
|map_dfr()        |future_map_dfr()        |
|map_if()         |future_map_if()         |
|map_int()        |future_map_int()        |
|map_lgl()        |future_map_lgl()        |
|map_raw()        |future_map_raw()        |
|map2()           |future_map2()           |
|map2_chr()       |future_map2_chr()       |
|map2_dbl()       |future_map2_dbl()       |
|map2_dfc()       |future_map2_dfc()       |
|map2_dfr()       |future_map2_dfr()       |
|map2_int()       |future_map2_int()       |
|map2_lgl()       |future_map2_lgl()       |
|map2_raw()       |future_map2_raw()       |
|modify()         |future_modify()         |
|modify_at()      |future_modify_at()      |
|modify_if()      |future_modify_if()      |
|pmap()           |future_pmap()           |
|pmap_chr()       |future_pmap_chr()       |
|pmap_dbl()       |future_pmap_dbl()       |
|pmap_dfc()       |future_pmap_dfc()       |
|pmap_dfr()       |future_pmap_dfr()       |
|pmap_int()       |future_pmap_int()       |
|pmap_lgl()       |future_pmap_lgl()       |
|pmap_raw()       |future_pmap_raw()       |
|pwalk()          |future_pwalk()          |
|walk()           |future_walk()           |
|walk2()          |future_walk2()          |

<!--
tbl_future_map("purrr", "furrr")
-->



---------------------------------------------------------------------

# Errors and output

Whe using the **[future]** framework, it's business as usual:

* Errors produced in parallel, are relayed as-is in the main R session
* Warnings produced in parallel, are relayed as-is in the main R session
* Messages produced in parallel, are relayed as-is in the main R session
* Any condition produced in parallel, are relayed as-is in the main R session
* Standard output produced in parallel, is relayed as-is in the main R session

It is only the **[future]** framework that does this. Other parallel
framework ignores warnings, messages, and standard output, and they
throw their own custom error when they detect errors.


## Business as usual: Exception handling ("dealing with errors")

* Errors produced in parallel, are relayed as-is in the main R session


### Example setup

The regular `sqrt()` function gives a warning if we try with a negative number, e.g.

```r
sqrt(-1)
#> [1] NaN
#> Warning message:
#> In sqrt(-1) : NaNs produced
```

If we want to be more strict, we could define:

```r
strict_sqrt <- function(x) {
  if (x < 0) {
    stop("sqrt(x) with x < 0 not allowed: ", x)
  }
  sqrt(x)
}
```

which gives:

```r
strict_sqrt(-1)
#> Error in strict_sqrt(-1) : sqrt(x) with x < 0 not allowed: -1
```

Let's see how this behaves with futures:

```r
f <- future(strict_sqrt(-1))

message("All good this far")
#> All good this far

v <- value(f)
#> Error in strict_sqrt(-1) : sqrt(x) with x < 0 not allowed: -1
```

Note how the error is signalled when we call `value()` - not when we call `future()`, which would not be possible because the latter starts the evaluation and returns immediately.

Because of this, regular exception handling applies, e.g.

```r
v <- tryCatch({
  value(f)
}, error = function(e) {
  message("An error occurred: ", conditionMessage(e))
  NA_real_
})
#> An error occurred: sqrt(x) with x < 0 not allowed: -1
v
#> [1] NA
```


### Exception handling works the same with map-reduce functions

Let's see how this behaves with different map-reduce functions.  If we use it with base R map-reduce functions, errors are produced like:

```r
X <- -1:2
y <- lapply(X, strict_sqrt)
#> Error in FUN(X[[i]], ...) : sqrt(x) with x < 0 not allowed: -1
```

We get a similar behavior with **[future.apply]**:

```r
library(future.apply)
plan(multisession, workers = 2)

y <- future_lapply(X, strict_sqrt)
#> Error in ...future.FUN(...future.X_jj, ...) : 
#>   sqrt(x) with x < 0 not allowed: -1
```

and **[furrr]**:

```r
library(furrr)
plan(multisession, workers = 2)

y <- future_map(X, strict_sqrt)
#> Error in ...furrr_fn(...) : sqrt(x) with x < 0 not allowed: -1
```

Take-home message: You can treat errors the same way as when running sequentially.

See Appendix [Exception handling by other parallel map-reduce APIs](#appendix-exception-handling-by-other-parallel-map-reduce-apis) for a comparison with other parallel solutions that does not rely on future-based, and for why the future solution is often more natural.


## Business as usual: Warnings

* Warnings produced in parallel, are relayed as-is in the main R session

When you use `warning()`, the warning message is signalled as a `warning` condition, very similar to how errors are signalled as `error` conditions. For example,

```r
x <- -1:2
y <- log(x)
#> Warning message:
#> In log(x) : NaNs produced
```

Futures capture `warning` conditions, which then are re-signalled by `value()`, e.g.

```r
x <- -1:2
f <- future(log(x))
y <- value(f)
#> Warning message:
#> In log(x) : NaNs produced
```

We can suppress warning using `suppressWarnings()`.  This works the same way regardless whether futures are used or not.  For example,

```r
y <- value(f)
#> Warning message:
#> In log(x) : NaNs produced

suppressWarnings(y <- value(f))
```

One can handle `warning` conditions using `withCallingHandlers()` and `globalCallingHandlers()` for maximum control what to do with them, but that's beyond this tutorial.


Just like errors, **[future]** map-reduce functions handles warnings consistently, e.g.

```r
library(future.apply)
plan(multisession, workers = 2)

X <- -1:2
y <- future_lapply(X, sqrt)
#> Warning message:
#> In ...future.FUN(...future.X_jj, ...) : NaNs produced
str(y)
#> List of 4
#>  $ : num NaN
#>  $ : num 0
#>  $ : num 1
#>  $ : num 1.41
```

Take-home message: You can treat warnings the same way as when running sequentially.

See Appendix [Condition handling by other parallel map-reduce APIs](#appendix-condition-handling-by-other-parallel-map-reduce-apis) for a comparison with other parallel solutions.  The future framework is the only solution where it works.


## Business as usual: Messages

* Messages produced in parallel, are relayed as-is in the main R session

When you use `message()`, the message are signalled the same way warnings and errors are signalled, and they eventually end up in the _standard error_ (stderr) stream - _not_ outputted to the standard output (stdout) stream. For example,

```r
z <- letters[1:8]
message("Number of letters: ", length(z))
#> Number of letters: 8
```

As with warnings and errors, futures capture `message` conditions, which then are re-signalled by `value()`, e.g.

```r
f <- future({
  z <- letters[1:8]
  message("Number of letters: ", length(z))
  z
})
y <- value(f)
#> Number of letters: 8
y
#> [1] "a" "b" "c" "d" "e" "f" "g" "h"
```

We can suppress messages using `suppressMessages()`.  This works the same way regardless whether futures are used or not.  For example,

```r
y <- value(f)
#> Number of letters: 8

suppressMessages(y <- value(f))
```

Just like for warnings and errors, **[future]** map-reduce functions handles messages consistently, e.g.

```r
library(future.apply)
plan(multisession, workers = 2)

X <- 1:3
y <- future_lapply(X, function(x) message("x = ", x))
x = 1
x = 2
x = 3
```

One can handle `message` conditions using `withCallingHandlers()` and `globalCallingHandlers()` for maximum control what to do with them, but that's beyond this tutorial.

Take-home message: You can treat messages the same way as when running sequentially.

See Appendix [Condition handling by other parallel map-reduce APIs](#appendix-condition-handling-by-other-parallel-map-reduce-apis) for a comparison with other parallel solutions.  The future framework is the only solution where it works.


## Business as usual: Standard output

* Standard output produced in parallel, is relayed as-is in the main R session

When you use `cat()`, `print()`, and `str()`, the message string is (by default) outputted to the _standard output_ (stdout) stream.  Note that this does _not_ rely on R's condition system, so use a completely different infrastructure than `message()`.

For example,

```r
z <- letters[1:8]
cat("Number of letters:", length(z), "\n")
#> Number of letters: 8
```

When using futures, any standard output is automatically captured and re-outputted by `value()`, e.g.


```r
f <- future({
  z <- letters[1:8]
  cat("Number of letters:", length(z), "\n")
  z
})
y <- value(f)
#> Number of letters: 8
y
#> [1] "a" "b" "c" "d" "e" "f" "g" "h"
```

Just like you can use `utils::capture.output()` to capture standard output from `cat()`, `print()`, `str()`, ..., you can use it to capture the output relayed by `value()`.  For example,

```r
stdout <- capture.output({
  y <- value(f)
})
y
#> [1] "a" "b" "c" "d" "e" "f" "g" "h"
stdout
#> [1] "Number of letters: 8 "
```


We can suppress standard output using `capture.output(..., file = nullfile())`.  This works the same way regardless whether futures are used or not.  For example,

```r
y <- value(f)
#> Number of letters: 8

capture.output(y <- value(f), file = nullfile())
```

Just like for conditions, **[future]** map-reduce functions handles standard ouput consistently, e.g.

```r
library(future.apply)
plan(multisession, workers = 2)

X <- 1:3
y <- future_lapply(X, function(x) cat("x =", x, "\n"))
x = 1
x = 2
x = 3
```

Take-home message: You can treat output the same way as when running sequentially.

See Appendix [Standard output by other parallel map-reduce APIs](#appendix-standard-output-by-other-parallel-map-reduce-apis) for a comparison with other parallel solutions that does not rely on future-based. The future-based solutions are the only ones that work correctly.



## Summary: All types of output is relayed

Above, we've learned how `message`, `warning`, and `error` conditions are relayed. This is actually true for all other classes of conditions.  We also learned that output sent to the standard output is relayed by futures. 

Here is a final example where we use most types of output:

```r
f <- future({
  cat("Hello world\n")
  message("Hi there")
  warning("whoops!")
  message("Please wait ...")
  log("a")
  message("Done")
})

value(f)
#> Hello world
#> Hi there
#> Please wait ...
#> Error in log("a") : non-numeric argument to mathematical function
#> In addition: Warning message:
#> In withCallingHandlers({ : whoops!
```


## Odds and ends

### What about standard error (stderr)?

R's support for capturing standard error (stderr) output is poor.  It can be done using:

```r
capture.output(..., type = "message")
```

However, I strongly advise against using it.  The reason is that `capture.output(..., type = "message")` cannot be nested, and the most recent call will always trump any existing stderr captures.  That is, if you capture standard error this way and call a function that does the same, the latter hijacks all capturing. _Importantly_, when it returns, remaining output to standard error will no longer be captured, despite your having requested it previously.  For more details, see <https://github.com/HenrikBengtsson/Wishlist-for-R/issues/55>.

_Conclusion:_ Always avoid `capture.output(..., type = "message")`, and never ever use it in package code!

_Warning: Above `type = "message"` should not be mistaken for `message()`. A more informative value would have been `type = "stderr"`._



# Reporting on progress updates

## Basic progress updates

![Three strokes writing three in Chinese](figures/three_in_chinese.gif)

The **[progressr]** package can be used to report on progress when using the **[future]** framework for parallelization.

```r
slow_sqrt <- function(X) {
  p <- progressr::progressor(along = X)
  lapply(X, function(x) {
    Sys.sleep(0.1)
    p()
    sqrt(x)
  })
}
```

Note how we do _not_ specify _how_ progress is reported or rendered. We just report on where we do progress.


If we call the above as-is, no progress is reported:

```r
X <- 1:50
y <- slow_sqrt(X)
```

With progress reporting:

```r
progressr::handlers(global = TRUE)

X <- 1:50
y <- slow_sqrt(X)
#  |====================                               |  40%
```


## Progress updates in parallel

Update to use `future_lapply()` instead of `lapply()`:

```r
slow_sqrt <- function(X) {
  p <- progressr::progressor(along = X)
  future.apply::future_lapply(X, function(x) {
    Sys.sleep(0.1)
    p(message = sprintf("x=%g", x)) # <= passing along a message
    sqrt(x)
  })
}
```

This works the same way when running sequentially:

```r
progressr::handlers(global = TRUE)
plan(sequential)

X <- 1:50
y <- slow_sqrt(X)
#  |====================                               |  40%
```

and when running in parallel:

```r
progressr::handlers(global = TRUE)
plan(multisession)

X <- 1:50
y <- slow_sqrt(X)
#  |====================                               |  40%
```

as well as running remotely:

```r
progressr::handlers(global = TRUE)
hostnames <- c("pi", "remote.server.org")
plan(cluster, workers = hostnames)

X <- 1:50
y <- slow_sqrt(X)
#  |====================                               |  40%
```

"Near-live" progress updates: Note that, even if there are only two parallel workers, and therefore two futures here, we will still recieve progress updates whilest these futures are busy processing all elements.  This works because the progress updates, signalled by `p()` above, are sent back to our main R session using background communication channels. These channels are frequently polled (by `resolved()` and `value()`) until the futures are completed, which is how we can relay and handle these progress updates in parallel.


## Customizing how progress is reported

You might have noticed I'm using the term "progress updates" and "progress reporting", rather than "progress bars".  The reason is that progress can be reported in many other ways than via visual progress bars, e.g. by audio, via the operating system's built-in notification framework, via email, etc.

Below is an example where we use the **[beepr]** package to play sounds as we progress. There are no visual cues of progress - just sound.

```r
progressr::handlers(global = TRUE)
progressr::handlers("beepr")

X <- 1:50
y <- slow_sqrt(X)
# 𝅘𝅥𝅮 ♫ . . . . . . . . . ♫
```

We can also combine multiple ways of reporting on progress, e.g. by combining audio from **[beepr]** and progress bars from the **[progress]** package:

```r
progressr::handlers(c("beepr", "progress"))
```

and also configure them in detail:

```r
library(progressr)
handlers(list(
  handler_progress(
    format   = ":spin :current/:total (:message) [:bar] :percent in :elapsed ETA: :eta",
    width    = 60,
    complete = "+"
  ),
  handler_beepr(
    finish   = "wilhelm"
  )
))
```

which gives:

```r
X <- 1:50
y <- slow_sqrt(X)
# \ 4/10 (x=32) [+++++++++>-------------]  40% in  1s ETA:  1s
```

If you use RStudio, you can report on progress via the RStudio Job interface:

```r
progressr::handlers("rstudio")
```


## Demo: Mandelbrot sets

![](figures/demo-mandelbrot-1.png)

```r
library(future)
plan(sequential)
options(future.demo.mandelbrot.region = 1L)

demo("mandelbrot", package = "progressr", ask = FALSE)
```

```r
library(future)
plan(multisession, workers = 4)
options(future.demo.mandelbrot.region = 1L)

demo("mandelbrot", package = "progressr", ask = FALSE)
```


```r
library(future)
plan(multisession, workers = 4)
options(future.demo.mandelbrot.region = 2L)

demo("mandelbrot", package = "progressr", ask = FALSE)
```

```r
library(future)
plan(multisession, workers = 4)
options(future.demo.mandelbrot.region = 2L)
options(future.demo.mandelbrot.delay = FALSE)

demo("mandelbrot", package = "progressr", ask = FALSE)
```

```r
library(future)
plan(multisession, workers = 8)
options(future.demo.mandelbrot.region = 3L)
options(future.demo.mandelbrot.delay = FALSE)

demo("mandelbrot", package = "progressr", ask = FALSE)
```


Source: https://github.com/HenrikBengtsson/progressr/blob/develop/demo/mandelbrot.R



# Quick summary and comparison to other parallel frameworks

## Feature comparisons

|                                   | future framework           | foreach with doFuture | BiocParallel with doFuture | parallel                          | foreach*    | BiocParallel* |
|:----------------------------------|:---------------------------|:----------------------|:---------------------------|:----------------------------------|:------------|:--------------|
| Exception handling                | ✓                          | ✓ (special)           | ✓ (special)                | ✓ (special)                       | ✓ (special) | ✓ (special)   |
| Warnings                          | ✓                          | ✓                     | ✓                          | no                                | no          | no            |
| Messages                          | ✓                          | ✓                     | ✓                          | no                                | no          | no            |
| Standard output                   | ✓                          | ✓                     | ✓                          | no                                | no          | no            |
| Parallel RNG                      | ✓                          | ✓ (special)           | ✓ (tedious)                | ✓ (manual)                        | ✓ (special) | ✓             |
| Progress updates                  | ✓ (near-live)              | ✓                     | ✓ (near-live)              | no                                | no          | ✓ (per task)  |
| Single-expression parallelization | ✓ (`future()` & `value()`) | no                    | no                         | ✓ (`mcparallel()` & `mcollect()`) | no          | no            |

(*) With any other parallel backend than a **[future]** one.

By "near-live" progress updates, we mean that progress is updated every time a worker is polled, which happens frequently.



## Parallel-backend comparisons

|                          | future framework   | foreach with doFuture | BiocParallel with doFuture | parallel | foreach* | BiocParallel*      |
|:-------------------------|:-------------------|:----------------------|:---------------------------|:---------|:---------|:-------------------|
| sequential               | ✓                  | ✓                     | ✓                          | no       | ✓        | ✓                  |
| parallel (forked)        | ✓                  | ✓                     | ✓                          | ✓        | ✓        | ✓                  |
| parallel (PSOCK)         | ✓                  | ✓                     | ✓                          | ✓        | ✓        | ✓                  |
| parallel (> 125 workers) | ✓ (**callr**)      | ✓ (**callr**)         | ✓ (**callr**)              | no       | no       | no                 |
| multiple machines        | ✓                  | ✓                     | ✓                          | ✓ (*)    | ✓ (**)   | ✓ (**)             |
| HPC job scheduler        | ✓ (**batchtools**) | ✓                     | ✓ (**batchtools**)         | no       | no       | ✓ (**batchtools**) |

(*) With `parallelly::makeClusterPSOCK()` it is easy to set up remote parallel workers over SSH. To do the same with `parallel::makePSOCKcluster()`, one needs to reconfigure the firewall.

(\**) One can use `registerDoParallel(workers)` where `workers <- parallelly::makeClusterPSOCK(...)` to use remote workers with **[foreach]**.  **[BiocParallel]** can use **[foreach]** via `DoparParam()`.



# Random numbers and reproducibility

When we draw random number in R, e.g.

```r
x <- rnorm(10)
```

the internals of R makes sure to follow best practices so that we get numbers that have "random" properties, e.g. knowing `x[1:9]` does not help us predict `x[10]`.  R uses a so called _random number generator_ (RNG) to generate random numbers.  More precisely, it uses a _pseudo_ RNG, because 100% true random numbers are really hard to get by.  An pseudo RNG is a deterministic RNG algorithm that produces a sequence of numbers that have good "random" properties.  Developing good pseudo RNGs is a research field in itself, which we won't cover in this tutorial, but what is worth mentioning is that R support several different kinds of RNGs, and the default one has carefully been chosen for us;

```r
> RNGkind()
[1] "Mersenne-Twister" "Inversion"        "Rejection"  
```

We can get reproducible random numbers by setting the RNG seed, e.g.

```r
set.seed(42)
rnorm(4)
#> [1]  1.3709584 -0.5646982  0.3631284  0.6328626
rnorm(4)
#> [1]  0.40426832 -0.10612452  1.51152200 -0.09465904
```

If we redo the above, we get an identical sequence of "random" numbers:

```r
set.seed(42)
rnorm(4)
#> [1]  1.3709584 -0.5646982  0.3631284  0.6328626
rnorm(4)
#> [1]  0.40426832 -0.10612452  1.51152200 -0.09465904
```

## Why is this important?

Random number generation (RNG) is important, because:

* many statistical methods rely on it for correctness,

* science rely on it for reproducibility.

If RNG produce "poor" random numbers, there is a risk we get invalid results.


When performing calculations and analyses in parallel, we cannot use the default RNG (Mersenne-Twister).  If we do, there is a risk that we end up with correlated random numbers across parallel workers, which then results in biased results and incorrect conclusions.  To solve this, other pseudo RNGs have been developed specifically for parallel processing:

* L'Ecuyer is a RNG that works well for parallel processing

```r
> RNGkind("L'Ecuyer-CMRG")
> RNGkind()
[1] "L'Ecuyer-CMRG" "Inversion"     "Rejection"
```


## Futures use proper parallel RNG

The **[future]** framework uses the L'Ecuyer parallel RNG.  It's all taken care of automatically. All you need to remember is to declare that your parallel code uses random numbers.  This you can do by specifying `seed = TRUE`, e.g.

```r
f <- future(rnorm(4), seed = TRUE)
```

Futures respects the random seed, and can therefore produce reproducible random numbers, e.g.

```r
set.seed(42)
f <- future(rnorm(4), seed = TRUE)
value(f)
#> [1] -1.6430042 -1.0003081 -0.3619149  0.1475366
```

```r
set.seed(42)
f <- future(rnorm(4), seed = TRUE)
value(f)
#> [1] -1.6430042 -1.0003081 -0.3619149  0.1475366
```

Comment: The random numbers produced with the same seed (here `42`) are _not_ identical when using the L'Ecuyer RNG as when using the Mersenne-Twister RNG.


### What happens if you forget to declare seed = TRUE?

If you don't specify `seed = TRUE`, and your future code end up using random numbers, then the **[future]** framework detects this and produces an informative wwarning that is hard to miss:

```r
f <- future(rnorm(4))
x <- value(f)
#> Warning message:
#> UNRELIABLE VALUE: Future ('<none>') unexpectedly generated random numbers 
without specifying argument 'seed'. There is a risk that those random numbers
are not statistically sound and the overall results might be invalid. To fix
this, specify 'seed=TRUE'. This ensures that proper, parallel-safe random
numbers are produced via the L'Ecuyer-CMRG method. To disable this check, use
'seed=NULL', or set option 'future.rng.onMisuse' to "ignore". 
```


### Random numbers with parallel map-reduce functions

The **[future.apply]** package use argument `future.seed = TRUE`, and the **[furrr]** package argument `.options = furrr_options(seed = TRUE)` for declaring that RNG is used.  For example,

```r
library(future.apply)
plan(multisession, workers = 2)

X <- 2:4
y <- future_lapply(X, rnorm, future.seed = TRUE)
str(y)
#> List of 3
#>  $ : num [1:2] -0.0265 -1.7324
#>  $ : num [1:3] 2.5456 -0.6127 -0.0912
#>  $ : num [1:4] -2.107 -1.304 0.229 0.775
```

It does _not_ matter what parallel backend you use, or number of parallel workers, the **[future]** framework guarantees numerically identical random numbers with the same random seed, e.g.

```r
library(future.apply)

X <- 2:4

plan(sequential)
set.seed(42)
y <- future_lapply(X, rnorm, future.seed = TRUE)
str(y)
#> List of 3
#>  $ : num [1:2] -0.169 -1.642
#>  $ : num [1:3] 0.649 1.193 0.542
#>  $ : num [1:4] 1.36 -1.85 -1.28 0.42
```

```r
plan(multisession, workers = 4)
set.seed(42)
y <- future_lapply(X, rnorm, future.seed = TRUE)
str(y)
#> List of 3
#>  $ : num [1:2] -0.169 -1.642
#>  $ : num [1:3] 0.649 1.193 0.542
#>  $ : num [1:4] 1.36 -1.85 -1.28 0.42
```

```r
plan(cluster, workers = c("pi", "remote.server.org"))
set.seed(42)
y <- future_lapply(X, rnorm, future.seed = TRUE)
str(y)
#> List of 3
#>  $ : num [1:2] -0.169 -1.642
#>  $ : num [1:3] 0.649 1.193 0.542
#>  $ : num [1:4] 1.36 -1.85 -1.28 0.42
```

As before, if you forget to declare your need for RNG, you'll get informative warnings about it;

```r
y <- future_lapply(X, rnorm)
Warning message:
UNRELIABLE VALUE: One of the 'future.apply' iterations ('future_lapply-1')
unexpectedly generated random numbers without declaring so. There is a risk
that those random numbers are not statistically sound and the overall results
might be invalid. To fix this, specify 'future.seed=TRUE'. This ensures that
proper, parallel-safe random numbers are produced via the L'Ecuyer-CMRG 
method. To disable this check, use 'future.seed = NULL', or set option 
'future.rng.onMisuse' to "ignore".
```



# Open discussion {-}




# Appendix

## Appendix: Exception handling by other parallel map-reduce APIs

The regular `sqrt()` function gives a warning if we try with a negative number, e.g.

```r
sqrt(-1)
#> [1] NaN
#> Warning message:
#> In sqrt(-1) : NaNs produced
```

If we want to be more strict, we can define:

```r
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
```

which gives:

```r
strict_sqrt(-1)
#> Error in strict_sqrt(-1) : sqrt(x) with x < 0 not allowed: -1
```

Let's see how this behaves with different map-reduce functions.  

Our reference, base-R `lapply()`:

```r
X <- -1:2
y <- lapply(X, strict_sqrt)
#> Error in FUN(X[[i]], ...) : sqrt(x) with x < 0 not allowed: -1
```

Details:

```r
tryCatch(y <- lapply(X, strict_sqrt), error = str)
#> List of 2
#>  $ message: chr "sqrt(x) with x < 0 not allowed: -1"
#>  $ call   : language FUN(X[[i]], ...)
#>  - attr(*, "class")= chr [1:3] "strict_error" "error" "condition"
```

**[future.apply]** (as expected):

```r
library(future.apply)
plan(multisession, workers = 2)

X <- -1:2
y <- future_lapply(X, strict_sqrt)
#> Error in ...future.FUN(...future.X_jj, ...) : 
#>   sqrt(x) with x < 0 not allowed: -1
```

Details:

```r
tryCatch(y <- future_lapply(X, strict_sqrt), error = str)
#> List of 2
#>  $ message: chr "sqrt(x) with x < 0 not allowed: -1"
#>  $ call   : language ...future.FUN(...future.X_jj, ...)
#>  - attr(*, "class")= chr [1:3] "strict_error" "error" "condition"
```

Note how the error message is preserved and also the error class (`strict_error`).


**[furrr]** (as expected):

```r
library(furrr)
plan(multisession, workers = 2)
y <- future_map(X, strict_sqrt)
#> Error in ...furrr_fn(...) : sqrt(x) with x < 0 not allowed: -1
```

Details:

```r
tryCatch(y <- future_map(X, strict_sqrt), error = str)
#> List of 2
#>  $ message: chr "sqrt(x) with x < 0 not allowed: -1"
#>  $ call   : language ...furrr_fn(...)
#>  - attr(*, "class")= chr [1:3] "strict_error" "error" "condition"
```

Note how the error message is preserved and also the error class (`strict_error`).


In contrast, **parallel** and `parLapply()`:

```r
library(parallel)
cl <- makePSOCKcluster(2)
clusterExport(cl, "strict_sqrt")

y <- parLapply(X, strict_sqrt, cl = cl)
#> Error in checkForRemoteErrors(val) : 
#>   one node produced an error: sqrt(x) with x < 0 not allowed: -1
```

Details:

```r
tryCatch(y <- parLapply(X, strict_sqrt, cl = workers), error = str)
#> List of 2
#>  $ message: chr "one node produced an error: sqrt(x) with x < 0 not allowed: -1"
#>  $ call   : language checkForRemoteErrors(val)
#>  - attr(*, "class")= chr [1:3] "simpleError" "error" "condition"
```

Note how:

1. the error message has changed
2. we lost the information on error class, i.e. `strict_error`


**parallel** and `mclapply()`:

```r
library(parallel)
options(mc.cores = 2)

y <- parallel::mclapply(X, strict_sqrt)
#> Warning message:
#> In parallel::mclapply(X, strict_sqrt) :
#>   all scheduled cores encountered errors in user code
```

Here we didn't even get an error - only a warning.  We have to inspect the results to detect errors, e.g.

```r
str(y)
#> List of 4
#>  $ : 'try-error' chr "Error in FUN(X[[i]], ...) : sqrt(x) with x < 0 not allowed: -1\n"
#>   ..- attr(*, "condition")=List of 2
#>   .. ..$ message: chr "sqrt(x) with x < 0 not allowed: -1"
#>   .. ..$ call   : language FUN(X[[i]], ...)
#>   .. ..- attr(*, "class")= chr [1:3] "strict_error" "error" "condition"
#>  $ : num 0
#>  $ : 'try-error' chr "Error in FUN(X[[i]], ...) : sqrt(x) with x < 0 not allowed: -1\n"
#>   ..- attr(*, "condition")=List of 2
#>   .. ..$ message: chr "sqrt(x) with x < 0 not allowed: -1"
#>   .. ..$ call   : language FUN(X[[i]], ...)
#>   .. ..- attr(*, "class")= chr [1:3] "strict_error" "error" "condition"
#>  $ : num 1.41
```

Do detect the errors, we have to scan the results;

```r
## Check for errors
is_error <- vapply(y, inherits, "try-error", FUN.VALUE = NA)
if (any(is_error)) {
  ## error objects are stored in attributes
  first_error <- attr(y[is_error][[1]], "condition")
  stop("Detected one or more errors: ", conditionMessage(first_error))
}
```

This a low-level, powerful feature, but it adds lots of friction and requires much more work to make sure things are correct.  We cannot just use the value of `mclapply(...)` as-is, but we need to postprocess it to make sure we catch any errors and handle them correctly.

Also:

1. Note how elements `X[2]` and `X[4]` where processed successfully. This is because they were process together on one of the parallel workers.
2. In contrast, `X[1]` and `X[3]` where processed by another worker, both together as `lapply(X[c(1,3)], strict_sqrt)`, which results in a "combined" for both.

Confusing? Yes!


**[foreach]**:

```r
library(foreach)
doFuture::registerDoFuture()
plan(multisession, workers = 2)

y <- foreach(x = X) %dopar% strict_sqrt(x)
#> Error in { : task 1 failed - "sqrt(x) with x < 0 not allowed: -1"
```

Just like with `parallel::parLapply()`, we lose important information on the error:

```r
tryCatch(y <- foreach(x = X) %dopar% strict_sqrt(x), error = str)
#> List of 2
#>  $ message: chr "task 1 failed - \"sqrt(x) with x < 0 not allowed: -1\""
#>  $ call   : language {     doFuture::registerDoFuture() ...
#>  - attr(*, "class")= chr [1:3] "simpleError" "error" "condition"
```

Note how:

1. the error message has changed
2. we lost the information on error class, i.e. `strict_error`

This is per design of `%dopar%` of the **foreach** package.



## Appendix: Condition handling by other parallel map-reduce APIs

Here will use warnings to illustrate how conditions are handled by the **[future]** framework, and how none of the other parallel frameworks handles them.  However, everything in this section apply also to messages, and any other non-error condition type signalled by R.

The regular `sqrt()` function gives a warning if we try with a negative number.  Let's see how this behaves with different map-reduce functions.  

Our reference, base-R `lapply()`:

```r
X <- -1:2
y <- lapply(X, sqrt)
#> Warning message:
#> In FUN(X[[i]], ...) : NaNs produced
```

Details:

```r
tryCatch(y <- lapply(X, sqrt), warning = str)
#> List of 2
#>  $ message: chr "NaNs produced"
#>  $ call   : language FUN(X[[i]], ...)
#>  - attr(*, "class")= chr [1:3] "simpleWarning" "warning" "condition"
```

**[future.apply]** (works as expected):

```r
library(future.apply)
plan(multisession, workers = 2)

X <- -1:2
y <- future_lapply(X, sqrt)
#> Warning message:
#> In ...future.FUN(...future.X_jj, ...) : NaNs produced
```

Details:

```r
tryCatch(y <- future_lapply(X, sqrt), warning = str)
#> List of 2
#>  $ message: chr "NaNs produced"
#>  $ call   : language ...future.FUN(...future.X_jj, ...)
#>  - attr(*, "class")= chr [1:3] "simpleWarning" "warning" "condition"
```


**[furrr]** (works as expected):

```r
library(furrr)
plan(multisession, workers = 2)

X <- -1:2
y <- future_map(X, sqrt)
#> Warning message:
#> In .Primitive("sqrt")(x) : NaNs produced
```

Details:

```r
tryCatch(y <- future_map(X, sqrt), warning = str)
#> List of 2
#>  $ message: chr "NaNs produced"
#>  $ call   : language .Primitive("sqrt")(x)
#>  - attr(*, "class")= chr [1:3] "simpleWarning" "warning" "condition"
```

**[foreach]** with **[doFuture]** (works as expected):

```r
library(foreach)
doFuture::registerDoFuture()
plan(multisession, workers = 2)

X <- -1:2
y <- foreach(x = X) %dopar% sqrt(x)
#> Warning message:
#> In sqrt(x) : NaNs produced
```

```r
tryCatch(y <- foreach(x = X) %dopar% sqrt(x), warning = str)
#> List of 2
#>  $ message: chr "NaNs produced"
#>  $ call   : language sqrt(x)
#>  - attr(*, "class")= chr [1:3] "simpleWarning" "warning" "condition"
```


**[foreach]** with **[doParallel]** (does not work):

```r
library(doParallel)
cl <- parallel::makeCluster(2)
registerDoParallel(cl)

X <- -1:2
y <- foreach(x = X) %dopar% sqrt(x)
```

Note, warnings are _not_ signalled.


**[foreach]** with **[doMC]** (does not work):

```r
library(doMC)
registerDoMC(2)

X <- -1:2
y <- foreach(x = X) %dopar% sqrt(x)
```

Note, warnings are _not_ signalled.



**parallel** and `parLapply()` (does not work):

```r
library(parallel)
cl <- makePSOCKcluster(2)

X <- -1:2
y <- parLapply(X, sqrt, cl = cl)
```

Note, warnings are _not_ signalled.


**parallel** and `mclapply()` (does not work):

```r
library(parallel)
options(mc.cores = 2)

X <- -1:2
y <- mclapply(X, sqrt)
```

Note, warnings are _not_ signalled.




## Appendix: Standard output by other parallel map-reduce APIs

TL;DR: It's only the **[future]** framework that captures and relays standard output in the main R session.

Our reference, base-R `lapply()`:

```r
X <- 1:3
void <- lapply(X, print)
#> [1] 1
#> [1] 2
#> [1] 3
```

```r
output <- capture.output(void <- lapply(X, print))
output
#> [1] "[1] 1" "[1] 2" "[1] 3"
```


**[future.apply]** (works as expected):

```r
library(future.apply)
plan(multisession, workers = 2)

X <- 1:3
void <- future_lapply(X, print)
#> [1] 1
#> [1] 2
#> [1] 3
```

```r
output <- capture.output(void <- future_lapply(X, print))
output
#> [1] "[1] 1" "[1] 2" "[1] 3"
```



**[furrr]** (works as expected):

```r
library(furrr)
plan(multisession, workers = 2)

X <- 1:3
void <- future_map(X, print)
#> [1] 1
#> [1] 2
#> [1] 3
```

```r
output <- capture.output(void <- future_map(X, print))
output
#> [1] "[1] 1" "[1] 2" "[1] 3"
```


**[foreach]** w/ **[doFuture]** (works as expected):

```r
library(doFuture)
registerDoFuture()
plan(multisession, workers = 2)

X <- 1:3
void <- foreach(x = X) %dopar% print(x)
#> [1] 1
#> [1] 2
#> [1] 3
```

```r
output <- capture.output({
  void <- foreach(x = X) %dopar% print(x)
})
output
#> [1] "[1] 1" "[1] 2" "[1] 3"
```


**[foreach]** w/ **[doParallel]** (doesn't work):

```r
library(doParallel)
cl <- parallel::makeCluster(2)
registerDoParallel(cl)

X <- 1:3
void <- foreach(x = X) %dopar% print(x)
```

```r
output <- capture.output({
  void <- foreach(x = X) %dopar% print(x)
})
output
#> character(0)
```

**[foreach]** w/ **[doMC]** (doesn't work):

```r
library(doMC)
registerDoMC(2)

X <- 1:3
void <- foreach(x = X) %dopar% print(x)
#> [1] 1
#> [1] 3
#> [1] 2
```

We did get some output, but not in order. As we will see next, it's actually only output to the same terminal but not to the R main session.  If you run this in RStudio, you may not see anything.  This means, there is nothing to capture;

```r
output <- capture.output({
  void <- foreach(x = X) %dopar% print(x)
})
output
#> character(0)
```

Thus, the output we _see_ above, does _not_ end up in our main R session.




**parallel** and `mclapply()` (doesn't work):

```r
library(parallel)
options(mc.cores = 2)

X <- 1:3
void <- mclapply(X, print)
#> [1] 1
#> [1] 3
#> [1] 2
```

We did get some output, but not in order. As we will see next, it's actually only output to the same terminal but not to the R main session.  If you run this in RStudio, you may not see anything.  This means, there is nothing to capture;

```r
output <- capture.output({
  void <- mclapply(X, print)
})
output
#> character(0)
```

Thus, the output we _see_ above, does _not_ end up in our main R session.



**parallel** and `parLapply()` (doesn't work):

```r
library(parallel)
cl <- makePSOCKcluster(2)

X <- 1:3
void <- parLapply(X, print, cl = cl)
```

No output, and nothing to capture;

```r
output <- capture.output({
  void <- parLapply(X, print, cl = cl)
})
output
#> character(0)
```

What about the `outfile = ""` trick?

```r
library(parallel)
cl <- makePSOCKcluster(2, outfile = "")

X <- 1:3
void <- parLapply(X, print, cl = cl)
#> [1] 1
#> [1] 2
#> [1] 3
```

It turns out also this only outputs to the terminal in which R is running.  If you run this in RStudio, you may not see anything.  This means, there is nothing to capture;

```r
output <- capture.output({
  void <- parLapply(X, print, cl = workers)
})
output
#> character(0)
```


## Appendix: Not everything can be parallelized

As explained in <https://future.futureverse.org/articles/future-4-non-exportable-objects.html>, not all types of objects can be sent to parallel workers.  Some objects only work in the R process they were first created in.  Below are example of object types from different R packages that cannot be exported to, or returned from, parallel workers.

| Package        | Examples of non-exportable types or classes                                    |
|:---------------|:-------------------------------------------------------------------------------|
| **base**       | connection (`externalptr`)                                                     |
| **DBI**        | DBIConnection (`externalptr`)                                                  |
| **inline**     | CFunc (`externalptr` of class DLLHandle)                                       |
| **keras**      | keras.engine.sequential.Sequential (`externalptr`)                             |
| **magick**     | magick-image (`externalptr`)                                                   |
| **ncdf4**      | ncdf4 (custom reference; _non-detectable_)                                     |
| **parallel**   | cluster and cluster nodes (`connection`)                                       |
| **raster**     | RasterLayer (`externalptr`; _not all_)                                         |
| **Rcpp**       | NativeSymbol (`externalptr`)                                                   |
| **reticulate** | python.builtin.function (`externalptr`), python.builtin.module (`externalptr`) |
| **rJava**      | jclassName (`externalptr`)                                                     |
| **ShortRead**  | FastqFile, FastqStreamer, FastqStreamerList (`connection`)                     |
| **sparklyr**   | tbl_spark (`externalptr`)                                                      |
| **terra**      | SpatRaster, SpatVector (`externalptr`)                                         |
| **udpipe**     | udpipe_model (`externalptr`)                                                   |
| **xgboost**    | xgb.DMatrix (`externalptr`)                                                    |
| **xml2**       | xml_document (`externalptr`)                                                   |



### Example: R connections can be exported to parallel workers

```r
library(future)
plan(multisession, workers = 2)

file <- tempfile()
con <- file(file, open = "wb")
cat("hello\n", file = con)
readLines(file)
#> [1] "hello"

f <- future({ cat("world\n", file = con); 42 })
v <- value(f)
readLines(file)
#> [1] "hello"    # <= Huh, where did 'world' end up?!?
```

It turns out that we are actually silently writing to another R connection on the parallel worker with the same connection index as our temporary file:

```r
as.integer(con)
#> [1] 3
```

```r
> showConnections()
  description                             class      mode  text     isopen  
3 "/tmp/hb/RtmpZMAQG0/file1ec6b03b87be50" "file"     "wb"  "binary" "opened"
4 "<-localhost:11362"                     "sockconn" "a+b" "binary" "opened"
5 "<-localhost:11362"                     "sockconn" "a+b" "binary" "opened"
  can read can write
3 "no"     "yes"    
4 "yes"    "yes"    
5 "yes"    "yes"  
```

This is really bad, because we might end up overwriting another file.  This is a limitation in R.  Here, R should ideally detect this and give an error.

If we create yet another connection, with a higher connection index:

```r
con2 <- file(file, open = "wb")
as.integer(con2)
#> [1] 6
```

and try to use that in parallel, we get:

```r
f <- future({ cat("world\n", file = con2); 42 })
v <- value(f)
#> Error in cat("world\n", file = con2) : invalid connection
```

This is because there is no connection on the worker with index 6.

Either, this is _not_ good.  This is a problem for all parallelization frameworks in R. There's no solution to this.


However, for troubleshooting, we can ask the **[future]** framework to look for non-exportable objects:

```r
options(future.globals.onReference = "error")
‎
f <- future({ cat("world", file = con2); 42 })
Error: Detected a non-exportable reference ('externalptr') in one of
the globals ('con2' of class 'file') used in the future expression
```

Note how the problem was detected _when creating the future_.  This prevents damage from happening.

This option is disabled by default, because:

1. there are some false positive, and
2. check is expensive



### Example: xml2 objects cannot be exported

```r
library(xml2)
xml <- read_xml("<body></body>")

f <- future({ xml_children(xml) })
value(f)
## Error: external pointer is not valid

str(xml)
## List of 2
##  $ node:<externalptr> 
##  $ doc :<externalptr> 
##  - attr(*, "class")= chr [1:2] "xml_document" "xml_node"
```

As before, we can set an R options for **[future]** to look for and report on these problems before trying to parallelize:

```r
library(future)
options(future.globals.onReference = "error")

library(xml2)
xml <- read_xml("<body></body>")

f <- future({ xml_children(xml) })
Error: Detected a non-exportable reference ('externalptr') in one of the
globals ('xml' of class 'xml_document') used in the future expression
```



## Appendix: Careful with forked parallization

The `parallel::mclapply()` function relies on _forked_ parallel processing provided by the operating system;

1. It works only on Linux and macOS
2. It does not work on MS Windows, where it falls back to a regular `lapply()` call

Because it uses forks, `parallel::mclapply()` is extremely easy to use.  For example, you never have to worry about global variables.  "It just works!"

The corresponding **[future]** backend is `multicore`, which use the same underlying code base as `mclapply()`.  In other words, using:

```r
library(future.apply)
plan(multicore, workers = 4)

X <- 1:100
z <- future_lapply(X, FUN = slow_sqrt)
```

is almost the same as using:

```r
library(parallel)
options(mc.cores = 4)

X <- 1:100
z <- mclapply(X, FUN = slow_sqrt)
```

but with the all the other benefits that comes with the **[future]** framework, e.g. errors, warnings, output, and random number generation.


**However**, it is not always safe to use forked parallelization; you really need to know when and when not to use it, which is complicated.

Simon Urbanek, author of `mclapply()` and R Core member, wrote:

> "Do NOT use `mcparallel()` in packages except as a non-default option that user can set ... Multicore is intended for HPC applications that need to use many cores for computing-heavy jobs, but it does not play well with RStudio and more importantly you [as the developer] don't know the resource available so only the user can tell you when it's safe to use."

In other words, you can only use it reliably in code that you have 100% control over, which is rarely the case, especially not for package authors.



## Appendix: Missing globals

Objects that needs to be exported to parallel workers are called
"globals". They are identified by automatically code inspection.  This
works most of the time, but there are cases were it might fail.  For
example, consider:

```r
a <- 1:3
b <- 4:7
c <- 3:5

my_sum <- function(var) { sum(get(var)) }
z <- my_sum(var = "a")
```

In this case, it is impossible for R to know _upfront_ that `var =
"a"` is going to be used to retrieve the value of a global variable.
Because of this, calling:

```r
f <- future(my_sum(var = "a"))
z <- value(f)
#> Error in get(var) : object 'a' not found
```

fails.


The solution is to guide the **[future]** framework to identify `a` as a global variable.  We can do this by adding a dummy use of `a`, e.g.

```r
f <- future({
  a  ## fake use of 'a'
  
  my_sum(var = "a")
})
z <- value(f)
```


### Example: glue::glue() - object not found

Here's another, more common example:

```r
library(glue)
a <- 42
s <- glue("The value of a is {a}.")
s
#> The value of a is 42.
```

If we run this in parallel as-is, the **[future]** framework won't be able to identify `a` as a needed object;

```r
library(glue)
library(future)
plan(multisession)

a <- 42
f <- future(glue("The value of a is {a}."))
s <- value(f)
Error in eval(parse(text = text, keep.source = FALSE), envir) : 
  object 'a' not found
```

As before, we can workaround it by:

```r
f <- future({
  a  ## fake use of 'a'
  
  glue("The value of a is {a}.")
})

s <- value(f)
s
#> The value of a is 42.
```


### Example: do.call()

Function `do.call()` can be used to call a function with a set of arguments.  For example,

```r
fcn <- sum
z <- do.call(fcn, args = list(1:10))
z
#> [1] 55
```

calls `fcn(1:10)` == `sum(1:10)`.  This works in parallel too:


```r
library(future)
plan(multisession)

fcn <- sum
f <- future(do.call(fcn, args = list(1:10)))
z <- value(f)
z
#> [1] 55
```

As an alternative to a function, `do.call()` also takes the _name_ of a function as input.  For example, we can also do:

```r
fcn <- sum
z <- do.call("fcn", args = list(1:10))
z
#> [1] 55
```

However, this is like the problem of using `get()`, as explained above.  If we try this in parallel, we get:

```r
library(future)
plan(multisession)

fcn <- sum
f <- future(do.call("fcn", args = list(1:10)))
z <- value(f)
#> Error in fcn(1:10) : could not find function "fcn"
```

We could declare by adding a dummy `fcn`, but it's much better to never pass the _name_ of a function (`"fcn"`) to `do.call()`; it's always much better to pass the function object (`fcn`) itself.


The same is true for apply functions, e.g. use:

```r
z <- lapply(1:10, FUN = sum)
```

but avoid:

```r
z <- lapply(1:10, FUN = "sum")
```


## Appendix: Don't assign to global environment

Assigning to variable outside of a function or in the global environments (e.g. `<<-` or `assign()`) does not work when running in parallel.  However, it extremely rare you need to do that.  Instead,

* If you find yourself using `<<-`, it's a strong hint that you should approach you problem in a different way!


For example, if you find yourself turning:

```r
res <- list()
for (ii in 1:3) {
  res[[ii]] <- letters[ii]
}
```

into:

```r
res <- list()
lapply(1:3, FUN = function(ii) {
  res[[ii]] <<- letters[ii]
})
```

then you should stop and think.  The correct solution is:

```r
res <- lapply(1:3, FUN = function(ii) {
  letters[ii]
})
```

This can easily be parallelize by replace `lapply()` with `future_lapply()` from the **[future.apply]** package.


## Appendix: foreach() is not a for-loop

An common example of the problem explained in Appendix: [Don't assign
to global environment](#appendix-dont-assign-to-global-environment)
happens when using **[foreach]** to turn a for-loop into a `foreach()`
call.  As before, if you find yourself needing to use `<<-` in order
to turn:

```r
res <- list()
for (ii in 1:3) {
  res[[ii]] <- letters[ii]
}
```

into

```r
library(doFuture)
registerDoFuture()
plan(multisession)

res <- list()
foreach(ii = 1:3) %dopar% {
  res[[ii]] <<- letters[ii]
}
```

then the `<<-` is a strong indication that this should not be done and it won't work, especially when running in parallel.  If you try to run the above in parallel, you will get:

```r
Error in { : task 1 failed - "object 'res' not found"
```

If you try to export `res`, e.g.

```r
res <- list()
foreach(ii = 1:3, .export = "res") %dopar% {
  res[[ii]] <<- letters[ii]
}
```

you'll find that `res` is not populated;

```r
res
#> list()
```

The mistake is believing that `foreach()` is a replacement to a for-loop.  It is not.  Repeat after me:

* `foreach() %dopar% { ... }` is _not_ a for-loop!
* `foreach() %dopar% { ... }` is _not_ a for-loop!
* `foreach() %dopar% { ... }` is _not_ a for-loop!

Don't feel bad if you thought this - you're not alone, not the first and not the last person to think this. It's a very common misconception and it's the name that makes it so tempting to believe it.

Instead, `foreach()` is much closer to an `lapply()` call;

* `foreach() %dopar% { ... }` is just like `lapply()` or `future_lapply()`
* `foreach() %dopar% { ... }` is just like `lapply()` or `future_lapply()`
* `foreach() %dopar% { ... }` is just like `lapply()` or `future_lapply()`

What tricks us, is the `%dopar%` infix operator.  It makes `foreach()` look like a for-loop, although it isn't one.  If the author of **[foreach]** wouldn't have invented `%dopar%`, they would probably have written `foreach()` to work like:

```r
res <- foreach(ii = 1:3, FUN = function(ii) {
  letters[ii]
}
```

which would make it clear that `foreach()` is just another map-reduce function very similar to `lapply()`.

To further bring the message home, it wouldn't be hard to imagine an implementation of `lapply()` that could be written as:

```r
res <- lapply(ii = 1:3) %dopar% {
  letters[ii]
}
```

I hope that clarifies it.


## Appendix: Debugging

For troubleshooting, call `backtrace()` (sic!), if there is an error when running in parallel.  You can also retry with `plan(sequential)`.  If you still get an error, then use `debug()` with `plan(sequential, split = TRUE)` to interactively step through the problematic function.

Since **[future]** relay all output, you can also add `print()`, `str()`, and `message()` output to your functions, which is a common poor man's debugging technique that actually works.



#### For package developers

* Will my future code work anywhere regardless of where it runs?

  - _If the answer is yes_, then you've embraced the philosophy of futures to 100%.

  - _If the answer is no_, try to identify exactly what part of the future code won't work everywhere, and see if it is necessary to have that constrain.

It's always a good practice to never override users settings, including with **[foreach]** adapter they might already have registered.  For instance, if you do:

```r
llply_slow <- function(x) {
  doFuture::registerDoFuture()
  llply(x, slow, .parallel = TRUE)
}
```

you will break the user's intentions if they use it as:

```r
library(foreach)
doParallel::registerDoParallel(2)

y1 <- foreach(ii = 1:3) %dopar% { some_other_fcn(ii) }
y2 <- llply_slow(1:3)  ## here you change the adaptor
y3 <- foreach(ii = 3:1) %dopar% { some_other_fcn(ii) }
```

To avoid this, undo your adaptor changes as:

```r
llply_slow <- function(x) {
  oldDoPar <- registerDoFuture()
  on.exit(with(oldDoPar, foreach::setDoPar(fun=fun, data=data, info=info)), add = TRUE)
  
  llply(x, slow, .parallel = TRUE)
}
```


[batchtools]: https://cran.r-project.org/package=batchtools
[beepr]: https://cran.r-project.org/package=beepr
[BiocParallel]: https://bioconductor.org/packages/BiocParallel/
[callr]: https://callr.r-lib.org/
[doFuture]: https://doFuture.futureverse.org
[doMC]: https://cran.r-project.org/package=doMC
[doParallel]: https://cran.r-project.org/package=doParallel
[foreach]: https://cran.r-project.org/package=foreach
[future]: https://future.futureverse.org
[future.apply]: https://future.apply.futureverse.org
[future.batchtools]: https://future.batchtools.futureverse.org
[future.callr]: https://future.callr.futureverse.org
[furrr]: https://furrr.futureverse.org
[parallelly]: https://parallelly.futureverse.org
[plyr]: https://cran.r-project.org/package=plyr
[progress]: https://github.com/r-lib/progress#readme
[progressr]: https://progressr.futureverse.org
[purrr]: https://purrr.tidyverse.org/
