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

colours <- c("#332288", "#117733", "#44AA99", "#88CCEE", "#DDCC77",
             "#CC6677", "#AA4499", "#882255", "#000000", "#F0E442")
pho_col <- c("#911eb4")
#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data <- read_csv(here("data/odontocete-data-landmarks.csv"))

#---------------------------------------------------------
# MANOVAs
# For other variables 
#----------------------------------------------------------
# Identify variables
vars <- c("family", "habitat", "feeding",
          "diet", "divetype", "hearingtype")

# Create an output file
output <- data.frame(array(dim = c(length(vars), 11)))
names(output) <- c("variable", 
                   "df1_group", "df2_group", "Pillai_group", "approxF_group", "p_group",
                   "df1_var", "df2_var", "Pillai_var", "approxF_var", "p_var")
                   
# Fit the model for all extra variables with group
for (i in 1:length(vars)){

  # Select variable
  other <- pull(pc_data, vars[i])

  # Column 16 = PC1, column 54 = PC39 (95% of variation)
  model1 <- manova(as.matrix(pc_data[, 16:54]) ~ group + other, data = pc_data)

  # Store all the outputs
  output[i, "variable"] <- vars[i]
  output[i, "df1_group"] <- anova(model1)$Df[2]
  output[i, "df2_group"] <- anova(model1)$Df[4]
  output[i, "Pillai_group"] <- anova(model1)$Pillai[2]
  output[i, "approxF_group"] <- anova(model1)$`approx F`[2]
  output[i, "p_group"] <- anova(model1)$`Pr(>F)`[2]
  output[i, "df1_var"] <- anova(model1)$Df[3]
  output[i, "df2_var"] <- anova(model1)$Df[4]
  output[i, "Pillai_var"] <- anova(model1)$Pillai[3]
  output[i, "approxF_var"] <- anova(model1)$`approx F`[3]
  output[i, "p_var"] <- anova(model1)$`Pr(>F)`[3]

}

# Write to file
write_csv(path = here("outputs/MANOVA-results-landmarks-other-variables.csv"), output)

#-------------------------------------------
# PC plots 
# Family
#--------------------------------------------
p1 <- 
  ggplot(pc_data, aes(x = PC1, y = PC2, col = family, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c(colours[1:5], pho_col, colours[6:9])) +
  theme_bw(base_size = 14) +
  theme(legend.position = "right",
        legend.text = element_text(size = 10),
        legend.title.align = 0.5) +
  guides(shape = FALSE) +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  xlim(-0.4, 0.25) +
  ylim(-0.18, 0.18) +
  xlab("PC1 (34.08%)") +
  ylab("PC2 (12.15%)")
#-----------------------------
# Habitat
#-----------------------------
pc_data2 <- 
  pc_data %>%
  filter(!is.na(habitat))

p2 <- 
  ggplot(pc_data2, aes(x = PC1, y = PC2, col = habitat, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c(colours[1], pho_col, colours[c(3,5,9)])) +
  theme_bw(base_size = 14) +
    theme(legend.position = "right",
          legend.text = element_text(size = 10),
          legend.title.align = 0.5) +
  guides(shape = FALSE) +
  geom_vline(xintercept = 0, linetype = 2) +
  geom_hline(yintercept = 0, linetype = 2) +
  xlim(-0.4, 0.25) +
  ylim(-0.18, 0.18) +
  xlab("PC1 (34.08%)") +
  ylab("PC2 (12.15%)")

#-----------------------------
# Diet
#-----------------------------
pc_data3 <- 
  pc_data %>%
  filter(!is.na(diet))
  
p3 <- 
  ggplot(pc_data3, aes(x = PC1, y = PC2, col = diet, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
    scale_color_manual(values = c(colours[c(3,5)], pho_col, colours[c(9)])) +
    theme_bw(base_size = 14) +
    theme(legend.position = "right",
          legend.text = element_text(size = 10),
          legend.title.align = 0.5) +
    guides(shape = FALSE) +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_hline(yintercept = 0, linetype = 2) +
    xlim(-0.4, 0.25) +
    ylim(-0.18, 0.18) +
    xlab("PC1 (34.08%)") +
    ylab("PC2 (12.15%)")

#-----------------------------
# Feeding
#-----------------------------
pc_data4 <- 
  pc_data %>%
  filter(!is.na(feeding))
  
p4 <- 
  ggplot(pc_data4, aes(x = PC1, y = PC2, col = feeding, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
    scale_color_manual(values = c(colours[c(3,5)], pho_col, colours[c(9)])) +
    theme_bw(base_size = 14) +
    theme(legend.position = "right",
          legend.text = element_text(size = 10),
          legend.title.align = 0.5) +
    guides(shape = FALSE) +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_hline(yintercept = 0, linetype = 2) +
    xlim(-0.4, 0.25) +
    ylim(-0.18, 0.18) +
    xlab("PC1 (34.08%)") +
    ylab("PC2 (12.15%)")

#-----------------------------
# divetype
#-----------------------------
pc_data5 <- 
  pc_data %>%
  filter(!is.na(divetype))  

# Fix up level ordering and spacing
pc_data5$divetype2 <- factor(pc_data5$divetype, 
                             levels = c("shallow", "mid", "deep", "verydeep"))

pc_data5$divetype2 <- gsub("verydeep", "very deep", pc_data5$divetype2)
pc_data5$divetype2 <- gsub("mid", "middle depth", pc_data5$divetype2)


p5 <- 
  ggplot(pc_data5, aes(x = PC1, y = PC2, col = divetype, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
    scale_color_manual(values = c(colours[c(3,5)], pho_col, colours[c(9)])) +
    theme_bw(base_size = 14) +
    theme(legend.position = "right",
          legend.text = element_text(size = 10),
          legend.title.align = 0.5) +
    guides(shape = FALSE) +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_hline(yintercept = 0, linetype = 2) +
    xlim(-0.4, 0.25) +
    ylim(-0.18, 0.18) +
    xlab("PC1 (34.08%)") +
    ylab("PC2 (12.15%)") +
    labs(col = "dive type")

#-----------------------------
# hearingtype
#-----------------------------
pc_data6 <- 
  pc_data %>%
  filter(!is.na(hearingtype))

p6 <- 
  ggplot(pc_data6, aes(x = PC1, y = PC2, col = hearingtype, shape = group)) +
  geom_point(size = 2, alpha = 0.8) +
    scale_color_manual(values = c(pho_col, colours[3])) +
    theme_bw(base_size = 14) +
    theme(legend.position = "right",
          legend.text = element_text(size = 10),
          legend.title.align = 0.5) +
    guides(shape = FALSE) +
    geom_vline(xintercept = 0, linetype = 2) +
    geom_hline(yintercept = 0, linetype = 2) +
    xlim(-0.4, 0.25) +
    ylim(-0.18, 0.18) +
    xlab("PC1 (34.08%)") +
    ylab("PC2 (12.15%)") +
    labs(col = "hearing type")

p1 / p2 / p3 

ggsave(here("outputs/other-PCA-plots-1.png"),
       width = 150, height = 250, units = "mm")


p4 / p5 / p6

ggsave(here("outputs/other-PCA-plots-2.png"),
       width = 150, height = 250, units = "mm")

