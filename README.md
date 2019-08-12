# Intraspecific variation in Phocoena phocoena
Author(s): Maria Clara Iruzun Martins, Travis Park, Rachael Racicot and [Natalie Cooper](mailto:natalie.cooper.@nhm.ac.uk)  

This repository contains all the code and data used in the [paper](link).

To cite the paper: 
> XXX

To cite this repo: 
> XXX

## Data
These analyses are based on CT scans of cochlea specimens from natural history collections.
CT scans are attached to each specimen on the [NHM Data Portal](https://data.nhm.ac.uk).
MCIR and TP then added landmarks to these to create `.pts` files that are used in all subsequent analyses. 
The `.pts` files for Phocoena phocoena are available in this repo in the `rawdata/landmark-data` folder but can also be downloaded from the [NHM Data Portal](https://doi.org/10.5519/0091362). 
`.pts` files for the other odontocetes are available in the dataset of Park et al. [2018](https://doi.org/10.5519/0082968).
Linear measurements for all specimens are available in the `rawdata/` folder or can also be downloaded from the [NHM Data Portal](https://doi.org/10.5519/0091362), as can all of the other data required to run the analyses.

If you use the data please cite as follows: 
> Martins, M.C.I, Park, T. and Cooper, N. (2019). Dataset: Intraspecific variation in harbour porpoise cochleae. Natural History Museum Data Portal (data.nhm.ac.uk). https://doi.org/10.5519/0091362

## Analyses
All code used to run analyses and make figures is included in the `analyses/` folder. These rely on some functions in the `functions/` folder.

* **01-extract-pc-scores.R** extracts the PC scores from the raw landmark data and creates `odontocete-data.csv` for use in later scripts.
* **02-intraspecific-variation.R** fits MANOVA and ANOVAs to determine if *Phocoena phocoena* differ significantly from the other odontocetes.
* **03-PCA-plots.R** creates the plots.  
* **04-extract-pc-scores-linear.R** extracts the PC scores from the raw linear measurements data and creates `odontocete-data.csv` for use in later scripts.
* **05-intraspecific-variation-linear.R** fits MANOVA and ANOVAs to determine if *Phocoena phocoena* differ significantly from the other odontocetes using linear measurements.
* **06-PCA-plots-linear.R** creates the plots. 
* **07-PCA-plots-other-groupings.R** creates plots and runs MANOVAs demonstrating how species vary in relation to taxonomic family and various ecological groupings. 
* **08-rarefaction-analyses.R** runs a sensitivity analysis repeating the MANOVAs for each possible combination of *Phocoena phocoena* specimens. 
* **09-rarefaction-plots.R** creates plots for the above. 

## Session Info
For reproducibility purposes, here is the output of `devtools:session_info()` used to perform the analyses in the publication.

    Session info 
    ────────────────────────────────────────────────────────────────────────────────
    setting  value                       
    version  R version 3.6.1 (2019-07-05)
    os       OS X El Capitan 10.11.6     
    system   x86_64, darwin15.6.0        
    ui       RStudio                     
    language (EN)                        
    collate  en_IE.UTF-8                 
    ctype    en_IE.UTF-8                 
    tz       Europe/Dublin               
    date     2019-08-12                  

    Packages ────────────────────────────────────────────────────────────────────────────────────
    package           * version    date       lib source                              
    abind               1.4-5      2016-07-21 [1] CRAN (R 3.6.0)                      
    ade4                1.7-13     2018-08-31 [1] CRAN (R 3.6.0)                      
    animation           2.6        2018-12-11 [1] CRAN (R 3.6.0)                      
    ape               * 5.3        2019-03-17 [1] CRAN (R 3.6.0)                      
    assertthat          0.2.1      2019-03-21 [1] CRAN (R 3.6.0)                      
    backports           1.1.4      2019-04-10 [1] CRAN (R 3.6.0)                      
    bitops              1.0-6      2013-08-17 [1] CRAN (R 3.6.0)                      
    broom             * 0.5.2      2019-04-07 [1] CRAN (R 3.6.0)                      
    callr               3.3.1      2019-07-18 [1] CRAN (R 3.6.0)                      
    cellranger          1.1.0      2016-07-27 [1] CRAN (R 3.6.0)                      
    Claddis             0.3.0      2019-02-12 [1] CRAN (R 3.6.0)                      
    cli                 1.1.0      2019-03-19 [1] CRAN (R 3.6.0)                      
    cluster             2.1.0      2019-06-19 [1] CRAN (R 3.6.1)                      
    clusterGeneration   1.3.4      2015-02-18 [1] CRAN (R 3.6.0)                      
    coda                0.19-3     2019-07-05 [1] CRAN (R 3.6.0)                      
    colorspace          1.4-1      2019-03-18 [1] CRAN (R 3.6.0)                      
    combinat            0.0-8      2012-10-29 [1] CRAN (R 3.6.0)                      
    crayon              1.3.4      2017-09-16 [1] CRAN (R 3.6.0)                      
    crosstalk           1.0.0      2016-12-21 [1] CRAN (R 3.6.0)                      
    curl                4.0        2019-07-22 [1] CRAN (R 3.6.0)                      
    deldir              0.1-23     2019-07-31 [1] CRAN (R 3.6.0)                      
    desc                1.2.0      2018-05-01 [1] CRAN (R 3.6.0)                      
    deSolve             1.24       2019-07-15 [1] CRAN (R 3.6.0)                      
    devtools          * 2.1.0      2019-07-06 [1] CRAN (R 3.6.0)                      
    digest              0.6.20     2019-07-04 [1] CRAN (R 3.6.0)                      
    dispRity          * 1.2.3      2019-08-12 [1] Github (TGuillerme/dispRity@e856421)
    dplyr             * 0.8.3      2019-07-04 [1] CRAN (R 3.6.0)                      
    expm                0.999-4    2019-03-21 [1] CRAN (R 3.6.0)                      
    fansi               0.4.0      2018-10-05 [1] CRAN (R 3.6.0)                      
    fastmatch           1.1-0      2017-01-28 [1] CRAN (R 3.6.0)                      
    forcats           * 0.4.0      2019-02-17 [1] CRAN (R 3.6.0)                      
    fs                  1.3.1      2019-05-06 [1] CRAN (R 3.6.0)                      
    gdata               2.18.0     2017-06-06 [1] CRAN (R 3.6.0)                      
    geiger              2.0.6.2    2019-06-04 [1] CRAN (R 3.6.0)                      
    generics            0.0.2      2018-11-29 [1] CRAN (R 3.6.0)                      
    geometry            0.4.2      2019-07-12 [1] CRAN (R 3.6.0)                      
    geomorph          * 3.1.2      2019-05-20 [1] CRAN (R 3.6.0)                      
    geoscale            2.0        2015-05-14 [1] CRAN (R 3.6.0)                      
    ggplot2           * 3.2.1      2019-08-10 [1] CRAN (R 3.6.0)                      
    ggrepel           * 0.8.1      2019-05-07 [1] CRAN (R 3.6.0)                      
    glue                1.3.1      2019-03-12 [1] CRAN (R 3.6.0)                      
    goftest             1.1-1      2017-04-03 [1] CRAN (R 3.6.0)                      
    gridExtra         * 2.3        2017-09-09 [1] CRAN (R 3.6.0)                      
    gtable              0.3.0      2019-03-25 [1] CRAN (R 3.6.0)                      
    gtools              3.8.1      2018-06-26 [1] CRAN (R 3.6.0)                      
    haven               2.1.1      2019-07-04 [1] CRAN (R 3.6.0)                      
    here              * 0.1        2017-05-28 [1] CRAN (R 3.6.0)                      
    hms                 0.5.0      2019-07-09 [1] CRAN (R 3.6.0)                      
    htmltools           0.3.6      2017-04-28 [1] CRAN (R 3.6.0)                      
    htmlwidgets         1.3        2018-09-30 [1] CRAN (R 3.6.0)                      
    httpuv              1.5.1      2019-04-05 [1] CRAN (R 3.6.0)                      
    httr                1.4.1      2019-08-05 [1] CRAN (R 3.6.0)                      
    igraph              1.2.4.1    2019-04-22 [1] CRAN (R 3.6.0)                      
    jpeg                0.1-8      2014-01-23 [1] CRAN (R 3.6.0)                      
    jsonlite            1.6        2018-12-07 [1] CRAN (R 3.6.0)                      
    knitr               1.24       2019-08-08 [1] CRAN (R 3.6.0)                      
    labeling            0.3        2014-08-23 [1] CRAN (R 3.6.0)                      
    later               0.8.0      2019-02-11 [1] CRAN (R 3.6.0)                      
    lattice             0.20-38    2018-11-04 [1] CRAN (R 3.6.1)                      
    lazyeval            0.2.2      2019-03-15 [1] CRAN (R 3.6.0)                      
    lubridate           1.7.4      2018-04-11 [1] CRAN (R 3.6.0)                      
    magic               1.5-9      2018-09-17 [1] CRAN (R 3.6.0)                      
    magrittr            1.5        2014-11-22 [1] CRAN (R 3.6.0)                      
    manipulateWidget    0.10.0     2018-06-11 [1] CRAN (R 3.6.0)                      
    maps                3.3.0      2018-04-03 [1] CRAN (R 3.6.0)                      
    MASS                7.3-51.4   2019-03-31 [1] CRAN (R 3.6.1)                      
    Matrix              1.2-17     2019-03-22 [1] CRAN (R 3.6.1)                      
    memoise             1.1.0      2017-04-21 [1] CRAN (R 3.6.0)                      
    mgcv                1.8-28     2019-03-21 [1] CRAN (R 3.6.1)                      
    mime                0.7        2019-06-11 [1] CRAN (R 3.6.0)                      
    miniUI              0.1.1.1    2018-05-18 [1] CRAN (R 3.6.0)                      
    mnormt              1.5-5      2016-10-15 [1] CRAN (R 3.6.0)                      
    modelr              0.1.5      2019-08-08 [1] CRAN (R 3.6.0)                      
    munsell             0.5.0      2018-06-12 [1] CRAN (R 3.6.0)                      
    mvtnorm             1.0-11     2019-06-19 [1] CRAN (R 3.6.0)                      
    nlme                3.1-140    2019-05-12 [1] CRAN (R 3.6.1)                      
    numDeriv            2016.8-1.1 2019-06-06 [1] CRAN (R 3.6.0)                      
    paleotree           3.3.0      2019-06-04 [1] CRAN (R 3.6.0)                      
    patchwork         * 0.0.1      2019-08-12 [1] Github (thomasp85/patchwork@fd7958b)
    permute             0.9-5      2019-03-12 [1] CRAN (R 3.6.0)                      
    phangorn            2.5.5      2019-06-19 [1] CRAN (R 3.6.0)                      
    phyclust            0.1-24     2019-03-27 [1] CRAN (R 3.6.0)                      
    phytools            0.6-99     2019-06-18 [1] CRAN (R 3.6.0)                      
    pillar              1.4.2      2019-06-29 [1] CRAN (R 3.6.0)                      
    pkgbuild            1.0.4      2019-08-05 [1] CRAN (R 3.6.0)                      
    pkgconfig           2.0.2      2018-08-16 [1] CRAN (R 3.6.0)                      
    pkgload             1.0.2      2018-10-29 [1] CRAN (R 3.6.0)                      
    plotrix             3.7-6      2019-06-21 [1] CRAN (R 3.6.0)                      
    plyr                1.8.4      2016-06-08 [1] CRAN (R 3.6.0)                      
    png                 0.1-7      2013-12-03 [1] CRAN (R 3.6.0)                      
    polyclip            1.10-0     2019-03-14 [1] CRAN (R 3.6.0)                      
    prettyunits         1.0.2      2015-07-13 [1] CRAN (R 3.6.0)                      
    processx            3.4.1      2019-07-18 [1] CRAN (R 3.6.0)                      
    promises            1.0.1      2018-04-13 [1] CRAN (R 3.6.0)                      
    ps                  1.3.0      2018-12-21 [1] CRAN (R 3.6.0)                      
    purrr             * 0.3.2      2019-03-15 [1] CRAN (R 3.6.0)                      
    quadprog            1.5-7      2019-05-06 [1] CRAN (R 3.6.0)                      
    R6                  2.4.0      2019-02-14 [1] CRAN (R 3.6.0)                      
    Rcpp                1.0.2      2019-07-25 [1] CRAN (R 3.6.0)                      
    RCurl               1.95-4.12  2019-03-04 [1] CRAN (R 3.6.0)                      
    readr             * 1.3.1      2018-12-21 [1] CRAN (R 3.6.0)                      
    readxl              1.3.1      2019-03-13 [1] CRAN (R 3.6.0)                      
    remotes             2.1.0      2019-06-24 [1] CRAN (R 3.6.0)                      
    rgl               * 0.100.26   2019-07-08 [1] CRAN (R 3.6.0)                      
    rlang               0.4.0      2019-06-25 [1] CRAN (R 3.6.0)                      
    rpart               4.1-15     2019-04-12 [1] CRAN (R 3.6.1)                      
    rprojroot           1.3-2      2018-01-03 [1] CRAN (R 3.6.0)                      
    RRPP              * 0.4.2      2019-05-19 [1] CRAN (R 3.6.0)                      
    rstudioapi          0.10       2019-03-19 [1] CRAN (R 3.6.0)                      
    rvest               0.3.4      2019-05-15 [1] CRAN (R 3.6.0)                      
    scales              1.0.0      2018-08-09 [1] CRAN (R 3.6.0)                      
    scatterplot3d       0.3-41     2018-03-14 [1] CRAN (R 3.6.0)                      
    sessioninfo         1.1.1      2018-11-05 [1] CRAN (R 3.6.0)                      
    shiny               1.3.2      2019-04-22 [1] CRAN (R 3.6.0)                      
    spatstat            1.60-1     2019-06-23 [1] CRAN (R 3.6.0)                      
    spatstat.data       1.4-0      2018-10-04 [1] CRAN (R 3.6.0)                      
    spatstat.utils      1.13-0     2018-10-31 [1] CRAN (R 3.6.0)                      
    spptest             0.4        2019-08-12 [1] Github (myllym/spptest@0e76a60)     
    strap               1.4        2014-11-05 [1] CRAN (R 3.6.0)                      
    stringi             1.4.3      2019-03-12 [1] CRAN (R 3.6.0)                      
    stringr           * 1.4.0      2019-02-10 [1] CRAN (R 3.6.0)                      
    subplex             1.5-4      2018-04-05 [1] CRAN (R 3.6.0)                      
    tensor              1.5        2012-05-05 [1] CRAN (R 3.6.0)                      
    testthat            2.2.1      2019-07-25 [1] CRAN (R 3.6.0)                      
    tibble            * 2.1.3      2019-06-06 [1] CRAN (R 3.6.0)                      
    tidyr             * 0.8.3      2019-03-01 [1] CRAN (R 3.6.0)                      
    tidyselect          0.2.5      2018-10-11 [1] CRAN (R 3.6.0)                      
    tidyverse         * 1.2.1      2017-11-14 [1] CRAN (R 3.6.0)                      
    usethis           * 1.5.1      2019-07-04 [1] CRAN (R 3.6.0)                      
    utf8                1.1.4      2018-05-24 [1] CRAN (R 3.6.0)                      
    vctrs               0.2.0      2019-07-05 [1] CRAN (R 3.6.0)                      
    vegan               2.5-5      2019-05-12 [1] CRAN (R 3.6.0)                      
    webshot             0.5.1      2018-09-28 [1] CRAN (R 3.6.0)                      
    withr               2.1.2      2018-03-15 [1] CRAN (R 3.6.0)                      
    xfun                0.8        2019-06-25 [1] CRAN (R 3.6.0)                      
    xml2                1.2.2      2019-08-09 [1] CRAN (R 3.6.0)                      
    xtable              1.8-4      2019-04-21 [1] CRAN (R 3.6.0)                      
    yaml                2.2.0      2018-07-25 [1] CRAN (R 3.6.0)                      
    zeallot             0.1.0      2018-01-28 [1] CRAN (R 3.6.0)                      


## Checkpoint for reproducibility
To rerun all the code with packages as they existed on CRAN at time of our analyses we recommend using the `checkpoint` package, and running this code prior to the analysis:

```{r}
checkpoint("2019-08-12")
```

