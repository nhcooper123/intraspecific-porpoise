# Intraspecific variation in Phocoena phocoena 
# Maria Clara Iruzun Martins April 2019
# Modified by Natalie Cooper May 2019
#------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(geomorph)
library(tidyverse)
#--------------------------------------------
# Input data
#--------------------------------------------
pc_data <- read_csv(here("data/porpoise-data.csv"))

#--------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the genus 
#--------------------------------------------
# Fit the model for all specimens
model1 <- manova(as.matrix(pc_data[, 6:21]) ~ group, data = pc_data)
# Look at overall model significance
anova(model1)

# Subset the data to remove the extinct species
pc_data2 <- filter(pc_data, type == "living")

# Fit the model
model2 <- manova(as.matrix(pc_data2[, 6:21]) ~ group, data = pc_data2)
anova(model2)

# Subset the data to remove the non P.p living species
pc_data3 <- filter(pc_data, 
                   taxon != "Phocoena_sinus" &
                   taxon != "Phocoena_dioptrica")

# Fit the model
model3 <- manova(as.matrix(pc_data3[, 6:21]) ~ group, data = pc_data3)
anova(model3)


