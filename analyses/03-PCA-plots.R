# Plotting 
# Maria Clara Iruzun Martins April 2019
# Modified by Natalie Cooper May 2019
#------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(tidyverse)
library(patchwork)
library(gridExtra)
library(ggrepel)

# Convex hulls function... (for PC1 and 2 only)
make.hull12 <- function(data){
  hull <- spatstat::convexhull.xy(data$PC1, data$PC2)
  data.frame(x = hull$bdry[[1]]$x, y = hull$bdry[[1]]$y)
}

make.hull13 <- function(data){
  hull <- spatstat::convexhull.xy(data$PC1, data$PC3)
  data.frame(x = hull$bdry[[1]]$x, y = hull$bdry[[1]]$y)
}

make.hull23 <- function(data){
  hull <- spatstat::convexhull.xy(data$PC2, data$PC3)
  data.frame(x = hull$bdry[[1]]$x, y = hull$bdry[[1]]$y)
}

#-------------------------------------------
# PC plots 
#--------------------------------------------
# Make hulls
# Make empty output lists
hulls_12 <- list()
hulls_13 <- list()
hulls_23 <- list()

# Make hulls
for(i in 1:2){
  hulls_12[[i]] <- make.hull12(pc_data[pc_data$group == unique(pc_data$group)[i], ])
}

for(i in 1:2){
  hulls_13[[i]] <- make.hull13(pc_data[pc_data$group == unique(pc_data$group)[i], ])
}

for(i in 1:2){
  hulls_23[[i]] <- make.hull23(pc_data[pc_data$group == unique(pc_data$group)[i], ])
}

# Add groupnames
names(hulls_12) <- unique(pc_data$group)
names(hulls_13) <- unique(pc_data$group)
names(hulls_23) <- unique(pc_data$group)

p1 <-
  ggplot(pc_data, aes(x = PC1, y = PC2, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_12[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#008080", fill = "#008080", alpha = 0.2) +
  geom_polygon(data = hulls_12[["Phocoenidae"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) 

p2 <-
  ggplot(pc_data, aes(x = PC1, y = PC3, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_13[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#008080", fill = "#008080", alpha = 0.2) +
  geom_polygon(data = hulls_13[["Phocoenidae"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) 

p3 <-
  ggplot(pc_data, aes(x = PC2, y = PC3, col = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  geom_polygon(data = hulls_23[["Phocoena_phocoena"]], aes(x = x, y = y), 
               col = "#008080", fill = "#008080", alpha = 0.2) +
  geom_polygon(data = hulls_23[["Phocoenidae"]], aes(x = x, y = y), 
               col = "#911eb4", fill = "#911eb4", alpha = 0.2) 
  

grid.arrange(p1, p2, p3, nrow = 2)

ggsave(here("outputs/PC-polygon-plots-all.png"))








#-------------------------------------------
# Density plots
#--------------------------------------------
# Gather data so PCs can be used as a facet
pc_dataX <- 
  pc_data %>%
  gather(PC, score, PC1:PC16) %>%
  select(taxon, group, type, PC, score) %>%
  mutate(group2 = paste(group, type, sep = "_")) %>%
  mutate(PC = factor(PC,  levels = c("PC1", "PC2", "PC3", "PC4", 
                                  "PC5", "PC6", "PC7", "PC8", 
                                  "PC9", "PC10", "PC11", "PC12", 
                                  "PC13", "PC14", "PC15", "PC16")))

# Plot for all species in outgroup
ggplot(pc_dataX, aes(x = score, fill = group, col = group)) +
  geom_density(alpha = 0.5) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none",
        strip.background = element_blank()) +
  facet_wrap(~ PC, scales = "free_y") +
  scale_fill_manual(values = c("#008080", "#911eb4")) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  xlab("Principal Component (PC) score")

ggsave(here("outputs/PC-density-plots-all.png"))

# With only living species
# Subset the data to remove the extinct species
pc_data2X <- filter(pc_dataX, type == "living")

ggplot(pc_data2X, aes(x = score, fill = group, col = group)) +
  geom_density(alpha = 0.5) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none",
        strip.background = element_blank()) +
  facet_wrap(~ PC, scales = "free_y") +
  scale_fill_manual(values = c("#008080", "#911eb4")) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  xlab("Principal Component (PC) score")

ggsave(here("outputs/PC-density-plots-living.png"))

# With only fossil species
# Subset the data to remove the non P.p living species
pc_data3X <- filter(pc_dataX, 
                    taxon != "Phocoena_sinus" &
                      taxon != "Phocoena_dioptrica")

ggplot(pc_data3X, aes(x = score, fill = group, col = group)) +
  geom_density(alpha = 0.5) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none",
        strip.background = element_blank()) +
  facet_wrap(~ PC, scales = "free_y") +
  scale_fill_manual(values = c("#008080", "#911eb4")) +
  scale_color_manual(values = c("#008080", "#911eb4")) +
  xlab("Principal Component (PC) score")

ggsave(here("outputs/PC-density-plots-fossil.png"))
