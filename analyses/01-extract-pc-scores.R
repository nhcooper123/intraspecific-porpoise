# Extract PC scores for odontocetes
# May 2019
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

# Exclude mysticetes and fossil species
ds <-
  ds %>%
  filter(family != "Balaenidae" & family != "Balaenopteridae" 
         & status != "fossil")

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

#--------------------------------------------------------
# Generalised Procrustes Analysis
# to remove position, scale and orientation effects
#--------------------------------------------------------
intra_gpa <- gpagen(ptsarray, curves = slidematrix)

# Plot the GPA landmarks if required
# plot(intra_gpa)

#--------------------------------
# Principal Components Analysis
# also creates a plot
#-------------------------------
intra_pca <- plotTangentSpace(intra_gpa$coords, legend = TRUE, label = TRUE,
                              warpgrids = FALSE)

# Look at how PCs explain variance
# Here we need 39 PCs to explain > 95%
intra_pca$pc.summary

# Extract PC scores and make .pts file name into
# a taxon column for combining with the metadata
pc_scores <- data.frame(filename = rownames(intra_pca$pc.scores), intra_pca$pc.scores)

# Merge with metadata
pc_data <- full_join(ds, pc_scores, by = "filename")

# Write to file
write_csv(pc_data, path = here("data/odontocete-data-landmarks.csv")) 

# Quick plot
ggplot(pc_data, aes(PC1, PC2, colour = group2)) +
  geom_point()
