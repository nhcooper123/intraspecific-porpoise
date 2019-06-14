# PCA plots and density plots
# for Phocoena phocoena vs other odontocetes
# Using linear measurements
# June 2019
#-------------------------------------------

# Significant PCs from ANOVA are 1, 2 and 4

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
pc_data <- read_csv(here("data/odontocete-data-linear.csv"))

#-------------------------------------------
# PC plots 
#--------------------------------------------
# Make hulls

hulls_12 <- make_hull(pc_data, pc1 = 18, pc2 = 19, n = 2, grouping_var = 7)
hulls_13 <- make_hull(pc_data, pc1 = 18, pc2 = 20, n = 2, grouping_var = 7)
hulls_23 <- make_hull(pc_data, pc1 = 19, pc2 = 20, n = 2, grouping_var = 7)
hulls_14 <- make_hull(pc_data, pc1 = 18, pc2 = 21, n = 2, grouping_var = 7)
hulls_24 <- make_hull(pc_data, pc1 = 19, pc2 = 21, n = 2, grouping_var = 7)


p1 <-
  ggplot(pc_data, aes(x = PC1, y = PC2, col = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_12[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-3, 9) +
  ylim(-5, 5)
 
p2 <-
  ggplot(pc_data, aes(x = PC1, y = PC3, col = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_13[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-3, 9) +
  ylim(-5, 5)

p3 <-
  ggplot(pc_data, aes(x = PC2, y = PC3, col = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_23[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-3, 9) +
  ylim(-5, 5)

p4 <-
  ggplot(pc_data, aes(x = PC1, y = PC4, col = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_14[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-3, 9) +
  ylim(-5, 5)

p5 <-
  ggplot(pc_data, aes(x = PC2, y = PC4, col = group2)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_24[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) +
  xlim(-3, 9) +
  ylim(-5, 5)

all <- grid.arrange(p1, p2, p3, p4, p5, nrow = 2)

ggsave(all, filename = here("outputs/PC-polygon-plots-linear.png"))
#-------------------------------------------
# Density plots
#--------------------------------------------
# Gather data so PCs can be used as a facet
pc_dataX <- 
  pc_data %>%
  gather(PC, score, PC1:PC9) %>%
  select(taxon, group2, PC, score) %>%
  mutate(group2 = paste(group2, sep = "_")) %>%
  mutate(PC = factor(PC,  levels = c("PC1", "PC2", "PC3", "PC4", 
                                  "PC5", "PC6", "PC7", "PC8", "PC9")))

# Plot for all species in outgroup
px <-
  ggplot(pc_dataX, aes(x = score, fill = group2, col = group2)) +
  geom_density(alpha = 0.5) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none",
        strip.background = element_blank()) +
  facet_wrap(~ PC, scales = "free_y") +
  scale_fill_manual(values = c("#008080", "#911eb4")) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  xlab("Principal Component (PC) score")

ggsave(px, filename = here("outputs/PC-density-plots-linear.png"))