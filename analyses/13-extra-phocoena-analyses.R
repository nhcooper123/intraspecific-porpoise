# Test whether intraspecific variation 
# in Phocoena phocoena is related to other
# features of the specimens
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
# Input extra data and join
#---------------------------------------------------------
pc_data2 <- read_csv(here("data/pp-data-landmarks.csv"))

#---------------------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly related to sex, origin, side or skull size
#----------------------------------------------------------
# Column 16 = PC1, column 29 = PC16 (95% of variation), 
# column 21 = PC6 (75%) required for variables with fewer data
model1 <- manova(as.matrix(pc_data2[, 16:21]) ~ as.factor(sex) , data = pc_data2)
anova(model1)

model2 <- manova(as.matrix(pc_data2[, 16:29]) ~ origin, data = pc_data2)
anova(model2)

model3 <- manova(as.matrix(pc_data2[, 16:29]) ~ side, data = pc_data2)
anova(model3)

model4 <- manova(as.matrix(pc_data2[, 16:21]) ~ log(cbl), data = pc_data2)
anova(model4)

p.adjust(p = c(0.340, 0.544, 0.038, 0.4981), method = "bonferroni")
#--------------------------------------------
# LINEAR MEASUREMENTS
#---------------------------------------------

#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data3 <- read_csv(here("data/pp-data-linear.csv"))

#---------------------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the clade
#----------------------------------------------------------
# Fit the model for all odontocetes
# Column 16 = PC1, column 22 = PC7 (95% of variation)
model1 <- manova(as.matrix(pc_data3[, 16:22]) ~ sex, data = pc_data3)
# Look at overall model significance
anova(model1)

model2 <- manova(as.matrix(pc_data3[, 16:22]) ~ origin, data = pc_data3)
# Look at overall model significance
anova(model2)

model3 <- manova(as.matrix(pc_data3[, 16:22]) ~ side, data = pc_data3)
# Look at overall model significance
anova(model3)

model4 <- manova(as.matrix(pc_data3[, 16:22]) ~ log(cbl), data = pc_data3)
# Look at overall model significance
anova(model4)

p.adjust(p = c(0.765, 0.291, 0.566, 0.359), method = "bonferroni")
