# Extract PC scores for odontocetes
# Using linear measurement data
# June 2019
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
# Input measurement data
#--------------------------------------------
measure <- read_csv("raw-data/cochlea-measurements.csv")

# Exclude maxRadius due to missing data
measure <-
  measure %>%
  select(-maxRadius)

#--------------------------------
# Principal Components Analysis
# also creates a plot
#-------------------------------
intra_pca <- princomp(measure[, 4:15])

% May need to use logs or residuals or volume is too powerful

# Look at how PCs explain variance
# Here we need 39 PCs to explain > 95%
summary(intra_pca)

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
