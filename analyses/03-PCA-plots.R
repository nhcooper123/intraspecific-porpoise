# PCA plots and density plots
# for Phocoena phocoena vs other odontocetes
# Using 3D landmark data
# May 2019
#-------------------------------------------

# Significant PCs from ANOVA are 2, 3 and 8

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(tidyverse)
library(patchwork)
library(gridExtra)
library(ggrepel)

# Convex hulls functions
source("functions/intra-functions.R")

#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data <- read_csv(here("data/odontocete-data-landmarks.csv"))

#-------------------------------------------
# PC plots 
#--------------------------------------------
# Make hulls

hulls_12 <- make_hull(pc_data, pc1 = 16, pc2 = 17, n = 2, grouping_var = 5)
hulls_13 <- make_hull(pc_data, pc1 = 16, pc2 = 18, n = 2, grouping_var = 5)
hulls_23 <- make_hull(pc_data, pc1 = 17, pc2 = 18, n = 2, grouping_var = 5)
hulls_28 <- make_hull(pc_data, pc1 = 17, pc2 = 23, n = 2, grouping_var = 5)
hulls_38 <- make_hull(pc_data, pc1 = 18, pc2 = 23, n = 2, grouping_var = 5)


p1 <-
  ggplot(pc_data, aes(x = PC1, y = PC2, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_12[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-0.2, 0.15) +
  ylim(-0.15, 0.15) +
  xlab("PC1 (15.70%)") +
  ylab("PC2 (10.04%)")

p2 <-
  ggplot(pc_data, aes(x = PC1, y = PC3, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_13[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-0.2, 0.15) +
  ylim(-0.15, 0.15) +
  xlab("PC1 (15.70%)") +
  ylab("PC3 (8.943%)")

p3 <-
  ggplot(pc_data, aes(x = PC2, y = PC3, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_23[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-0.2, 0.15) +
  ylim(-0.15, 0.15) +
  xlab("PC2 (10.04%)") +
  ylab("PC3 (8.943%)")

p4 <-
  ggplot(pc_data, aes(x = PC2, y = PC8, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_28[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-0.2, 0.15) +
  ylim(-0.15, 0.15) +
  xlab("PC2 (10.04%)") +
  ylab("PC8 (3.590%)")
  
p5 <-
  ggplot(pc_data, aes(x = PC3, y = PC8, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_38[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-0.2, 0.15) +
  ylim(-0.15, 0.15) +
  xlab("PC3 (8.943%)") +
  ylab("PC8 (3.590%)")

all <- grid.arrange(p1, p2, p3, p4, p5, nrow = 2)

ggsave(all, filename = here("outputs/PC-polygon-plots-landmarks.png"))
#-------------------------------------------
# Density plots
#--------------------------------------------
# Gather data so PCs can be used as a facet
pc_dataX <- 
  pc_data %>%
  gather(PC, score, PC1:PC9) %>%
  select(taxon, group, PC, score) %>%
  mutate(group2 = paste(group, sep = "_")) %>%
  mutate(PC = factor(PC,  levels = c("PC1", "PC2", "PC3", "PC4", 
                                  "PC5", "PC6", "PC7", "PC8", "PC9")))

# Plot for all species in outgroup
px <-
  ggplot(pc_dataX, aes(x = score, fill = group, col = group)) +
  geom_density(alpha = 0.5) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none",
        strip.background = element_blank()) +
  facet_wrap(~ PC, scales = "free_y") +
  scale_fill_manual(values = c("#008080", "#911eb4")) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  xlab("Principal Component (PC) score")

ggsave(px, filename = here("outputs/PC-density-plots-landmarks.png"))
