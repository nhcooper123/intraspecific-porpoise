# Extract PC scores for just Phocoena spp.
# Using 3D landmark data
# Nov 2019
#------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(geomorph)
library(tidyverse)
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

#---------------------------
# Select just the Phocoena spp
#---------------------------
ptsarray2 <- ptsarray[, , c(32:52)]

#-----------------------
# Input additional data
#-----------------------
# Semilandmark curves
slidematrix <- as.matrix(read_csv(here("raw-data/curves.csv")))

#--------------------------------------------------------
# Generalised Procrustes Analysis
# to remove position, scale and orientation effects
#--------------------------------------------------------
intra_gpa2 <- gpagen(ptsarray2, curves = slidematrix)

# Plot the GPA landmarks if required
# plot(intra_gpa)

#--------------------------------
# Principal Components Analysis
# also creates a plot
#-------------------------------
intra_pca2 <- plotTangentSpace(intra_gpa2$coords, legend = TRUE, label = TRUE,
                              warpgrids = FALSE)

# Look at how PCs explain variance
# Here we need 14 PCs to explain > 95%
intra_pca2$pc.summary

# Extract PC scores and make .pts file name into
# a taxon column for combining with the metadata
pc_scores2 <- data.frame(filename = rownames(intra_pca2$pc.scores), intra_pca2$pc.scores)

# Merge with metadata
pc_data2 <- right_join(ds, pc_scores2, by = "filename")

# Write to file
write_csv(pc_data2, path = here("data/phocoena-data-landmarks.csv")) 
#--------------------------------------------
# Fit Procrustes ANOVAs to coordinates
#--------------------------------------------
# Create geomorph dataframe of coordinates and group
gdf2 <- geomorph.data.frame(intra_gpa2, 
                           group = pc_data2$group)
# Fit models
# randomize raw values
fit1 <- procD.lm(coords ~ group, 
                 data = gdf2, iter = 999, 
                 RRPP = FALSE, print.progress = FALSE) 
summary(fit1)

# Randomize residuals result will be the same
# as there is just one explanatory variable.

#----------------------------------------------------
# LINEAR MEASUREMENTS
#----------------------------------------------------

#--------------------------------------------
# Input measurement data
#--------------------------------------------
measure <- read_csv("raw-data/cochlea-measurements.csv")

# Exclude maxRadius due to missing data
measure <-
  measure %>%
  select(-maxRadius) %>%
  # remove for now
  filter(specID != "NMNH572016" & specID !="NMNH571892" &
           specID != "NMBC111425" & specID != "SDSNH21212")

# Select only phocoenids
measure2 <- 
  measure %>%
  arrange(taxon) %>%
  slice(c(32:52))
#--------------------------------
# Principal Components Analysis
# Variables are scaled and centred
#-------------------------------
intra_pca3 <- princomp(measure2[, 4:15], cor = TRUE)

# Look at how PCs explain variance
# Here we need 7 PCs to explain > 95%
summary(intra_pca3)

# Extract PC scores and make .pts file name into
# a taxon column for combining with the metadata
pc_scores3 <- data.frame(specID = measure2$specID, intra_pca3$scores)

# Merge with metadata
pc_data3 <- right_join(ds, pc_scores3, by = "specID")

# Rename Comp.1 to PC1 etc.
pc_data3 <-
  pc_data3 %>%
  rename_at(vars(starts_with("Comp.")), funs(str_replace(., "Comp.", "PC")))

# Write to file
write_csv(pc_data3, path = here("data/phocoena-data-linear.csv")) 
