# Test whether intraspecific variation 
# in Phocoena phocoena is higher/lower
# than interspecific variation
# Using 3D landmark data
# May 2019
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
pc_data <- read_csv(here("data/odontocete-data-landmarks.csv"))

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

# Create an output file
output <- data.frame(array(dim = c(10, 5)))
names(output) <- c("df1", "df2", "Pillai", "approxF", "p")

# Store all the outputs
output[1, "df1"] <- anova(model1)$Df[2]
output[1, "df2"] <- anova(model1)$Df[3]
output[1, "Pillai"] <- anova(model1)$Pillai[2]
output[1, "approxF"] <- anova(model1)$`approx F`[2]
output[1, "p"] <- anova(model1)$`Pr(>F)`[2]

# Write to file
write_csv(path = here("outputs/MANOVA-results-landmarks.csv"), output)

#--------------------------------------------
# Fit ANOVAs for each individual PC
#--------------------------------------------

# List names of first 26 PCs
pc_list <- names(pc_data)[16:41]

# Create an output file for three subsets
output <- data.frame(array(dim = c(26, 5)))
names(output) <- c("PC", "df1", "df2", "F", "p")

# Run ANOVAs
for (i in seq_along(pc_list)){
  pc <- pc_list[i]
  x <- fit.anova(pc, pc_data, "group")
  output[i, "PC"] <- pc_list[i]
  output[i, "df1"] <- x$df[1]
  output[i, "df2"] <- x$df[2]
  output[i, "F"] <- x$statistic[1]
  output[i, "p"] <- x$p.value[1]
}

p.adjust(output$p, method = "bonferroni")
         
write_csv(path = here("outputs/ANOVA-results-landmarks.csv"), output)

#--------------------------------------------
# Disparity
#--------------------------------------------
matrix <- 
  pc_data %>%
  filter(group == "Phocoena_phocoena") %>%
  select(PC1:PC68) %>%
  as.matrix()

sum(variances(matrix))
median(centroids(matrix))

