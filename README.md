# Intraspecific variation in Phocoena phocoena
Author(s): Maria Clara Iruzun Martins, Travis Park and [Natalie Cooper](mailto:natalie.cooper.@nhm.ac.uk)  

This repository contains all the code and data used in the [paper](link).

To cite the paper: 
> XXX

To cite this repo: 
> XXX

## Data
These analyses are based on CT scans of cochlea specimens from natural history collections.
All the CT scans are available from the [NHM Data Portal](link). ???
MCIR and TP then added landmarks to these to create `.pts` files that are used in all subsequent analyses. 
The `.pts` files are available in this repo in the `rawdata/landmark-data` folder but can also be downloaded from the [NHM Data Portal](link). ???

If you use the data please cite as follows: 
> XXX

## Analyses
All code used to run analyses and make figures is included in the `analyses/` folder. 

* **01-extract-pc-scores.R** extracts the PC scores from the raw landmark data and creates `odontocete-data.csv` for use in later scripts.
* **02-intraspecific-variation.R** fits MANOVA and ANOVAs to determine if *Phocoena phocoena* differ significantly from the other odontocetes.
* **03-PCA-plots.R** creates the plots.  

*** Complete this later ***

## Session Info
For reproducibility purposes, here is the output of `devtools:session_info()` used to perform the analyses in the publication.

## Checkpoint for reproducibility
To rerun all the code with packages as they existed on CRAN at time of our analyses we recommend using the `checkpoint` package, and running this code prior to the analysis:

```{r}
checkpoint("???")
```

