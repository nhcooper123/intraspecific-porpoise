# Test whether intraspecific variation 
# in Phocoena phocoena is higher/lower
# than variation among phocoenids
# Removing North Atlantic specimen
# Using 3D landmark data
# Nov 2019
#------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(geomorph)
library(tidyverse)
library(broom)
library(dispRity)

source("functions/intra-functions.R")
#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data <- read_csv(here("data/no-NA-data-landmarks.csv"))

#---------------------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the clade
#----------------------------------------------------------
# Fit the model for all odontocetes
# Column 16 = PC1, column 41 = PC26 (95% of variation)
model1 <- manova(as.matrix(pc_data[, 16:41]) ~ group, data = pc_data)
# Look at overall model significance
anova(model1)

#--------------------------------------------
# LINEAR MEASUREMENTS
#---------------------------------------------

#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data2 <- read_csv(here("data/no-NA-data-linear.csv"))

#---------------------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the clade
#----------------------------------------------------------
# Fit the model for all odontocetes
# Column 16 = PC1, column 21 = PC6 (95% of variation)
model1 <- manova(as.matrix(pc_data2[, 16:21]) ~ group, data = pc_data2)
# Look at overall model significance
anova(model1)
