# PCA plots for other groupings
# June 2019
#-------------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(tidyverse)
library(patchwork)
library(gridExtra)
library(ggrepel)

#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data1 <- read_csv(here("data/odontocete-data-landmarks.csv"))
pc_data2 <- read_csv(here("data/odontocete-data-linear.csv"))

#-------------------------------------------
# PC plots 
# Family
#--------------------------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = family, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = family, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# Habitat
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = habitat, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = habitat, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# Diet
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = diet, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = diet, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2
#-----------------------------
# feeding
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = feeding, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = feeding, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# divetype
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = divetype, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = divetype, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# hearingtype
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = hearingtype, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = hearingtype, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#---------------------------------------------------------
# MANOVAs
# To determine if variation within hearing types
# is significantly less than within the clade
#----------------------------------------------------------
# Fit the model for all odontocetes
# Column 16 = PC1, column 54 = PC39 (95% of variation)
model1 <- manova(cbind(as.matrix(pc_data1[, 16:54])) ~ group + group:hearingtype + hearingtype, data = pc_data)
# Look at overall model significance
summary(model1)
