# Extract PC scores for odontocetes
# Using linear measurement data
# June 2019

# For now this deletes the specimens that are not included
# in both datasets
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

#--------------------------------
# Principal Components Analysis
# Variables are scaled and centred
#-------------------------------
intra_pca <- princomp(measure[, 4:15], cor = TRUE)

# Look at how PCs explain variance
# Here we need 6 PCs to explain > 95%
summary(intra_pca)

# Extract PC scores and make .pts file name into
# a taxon column for combining with the metadata
pc_scores <- data.frame(specID = measure$specID, intra_pca$scores)

# Merge with metadata
pc_data <- full_join(ds, pc_scores, by = "specID")

# Rename Comp.1 to PC1 etc.
pc_data <-
  pc_data %>%
  rename_at(vars(starts_with("Comp.")), funs(str_replace(., "Comp.", "PC")))

# Write to file
write_csv(pc_data, path = here("data/odontocete-data-linear.csv")) 

# Quick plot
ggplot(pc_data, aes(PC1, PC2, colour = group)) +
  geom_point()

#-------------------------------
# Coefficients of variation
#-------------------------------
cv_fun <-
  function(x){
    (sd(x)/mean(x))*100
  }

cv <-
  measure %>%
  filter(taxon == "Phocoena_phocoena") %>%
  summarise_if(is.numeric, cv_fun) %>%
  mutate(group = "Phocoena_phocoena")

cv2 <-
  measure %>%
  filter(taxon != "Phocoena_phocoena") %>%
  summarise_if(is.numeric, cv_fun) %>%
  mutate(group = "Other")


write_csv(rbind(cv, cv2), path = here("outputs/coefficient-variation.csv")) 
