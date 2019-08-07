# Extract PC scores for subsets of Phocoena phocoena
# Then perform ANOVAs and MANOVAs
#------------------------------------
source("functions/rarefy-functions.R")
#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(geomorph)
library(tidyverse)
library(broom)
#-------------------------------------
# Read in metadata
#-------------------------------------
ds <- read_csv("raw-data/echo-metadata.csv")

#--------------------------------------------
# Input landmark data
# These are in a series of .pts files 
#--------------------------------------------
# Define # landmarks and dimensions
n.landmarks <- 361
n.dim <- 3

# List .pts files 
ptslist <- ds %>%
  pull(filename)

# Create empty array
ptsarray <- array(dim = c(n.landmarks, n.dim, length(ptslist)))

# Read in files and combine into an array
for (i in 1:length(ptslist)) {
  ptsarray[, , i] <-
    as.matrix(read_table(
      file = paste0(here("raw-data/landmark-data/"), ptslist[i]),
      skip = 2,
      col_names = FALSE,
      col_types = cols(X1 = col_skip()),
      n_max = n.landmarks
    ))
}

# To ensure everything matches up to metadata
# add the names of the .pts files to dim names
dimnames(ptsarray)[[3]] <- ptslist

#-----------------------
# Input additional data
#-----------------------
# Semilandmark curves
slidematrix <- as.matrix(read_csv(here("raw-data/curves.csv")))

#----------------------------
# Identify porpoises

porpoises <- which(str_detect(dimnames(ptsarray)[[3]], 
                   "Phocoena-phocoena") == TRUE)

# Get all combinations
out <- NULL
for (z in 2:17) {
out <- c(out, combn(porpoises, z, simplify = FALSE))
}
#----------------------------------------
# Sample number of porpoises
# and get PC values then run MANOVAs
# and output stats
#-----------------------------------------
# Create MANOVA output file
MANOVA_output <- create_MANOVA_output(length(out))

# Loop through combinations
for(i in 1:length(out)){

  # Save number of porpoises
  nporpoise <- length(out[[i]])
  
  # Select required porpoises plus other whales from ptsarray
  exclude <- setdiff(porpoises, out[[i]])
  points <- ptsarray[, , -exclude]
  
  # GPA and PCA on the new rarefied dataset
  pca <- get_pcs(points, slidematrix, ds, nporpoise)
  
  MANOVA_output <- fit_manova(pca, MANOVA_output, nporpoise)

}  

# Write results to file
write_csv(path = here("outputs/rarefied-MANOVA-results-landmarks.csv"), MANOVA_output)