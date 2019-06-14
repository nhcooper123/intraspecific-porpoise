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
# with labels
#--------------------------------------------
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = hearingtype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none") +
  geom_text_repel(label = pc_data2$taxon)

  ggplot(pc_data2, aes(x = PC1, y = PC3, col = hearingtype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none") +
  geom_text_repel(label = pc_data2$taxon)
  
  ggplot(pc_data2, aes(x = PC2, y = PC3, col = hearingtype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none") +
  geom_text_repel(label = pc_data2$taxon)
  
  ggplot(pc_data2, aes(x = PC1, y = PC4, col = hearingtype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none") +
  geom_text_repel(label = pc_data2$taxon)
  
#-------------------------------------------
# PC plots 
# Family
#--------------------------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = family, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = family, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# Habitat
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = habitat, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = habitat, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# Diet
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = diet, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = diet, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2
#-----------------------------
# feeding
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = feeding, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = feeding, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# divetype
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = divetype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = divetype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2

#-----------------------------
# hearingtype
#-----------------------------
p1 <- 
  ggplot(pc_data1, aes(x = PC1, y = PC2, col = hearingtype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = hearingtype, shape = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  theme(legend.position = "none")

p1 + p2
