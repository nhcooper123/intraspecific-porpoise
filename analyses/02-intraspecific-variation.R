# Test whether intraspecific variation 
# in Phocoena phocoena is higher/lower
# than intraspecific variation
# May 2019
#------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(geomorph)
library(tidyverse)
library(broom)
#--------------------------------------------
# Input data
#---------------------------------------------------------
pc_data <- read_csv(here("data/odontocete-data.csv"))

#---------------------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the clade
#----------------------------------------------------------
# Fit the model for all odontocetes
# Column 7 = PC1, column 45 = PC39 (95% of variation)
model1 <- manova(as.matrix(pc_data[, 7:45]) ~ group2, data = pc_data)
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
write_csv(path = here("outputs/MANOVA-results.csv"), output)

#--------------------------------------------
# Fit ANOVAs for each individual PC
#--------------------------------------------
# Quick function to run all anovas
fit.anova <- function(pc, data, grouping.var) {
  pc_ <- pull(data, pc)
  grouping.var_ <- pull(data, grouping.var)
  model <- lm(pc_ ~ grouping.var_, data = data)
  out <- tidy(anova(model))
  return(out)
}

# List names of first 39 PCs
pc_list <- names(pc_data)[7:45]

# Create an output file for three subsets
output <- data.frame(array(dim = c(39, 5)))
names(output) <- c("PC", "df1", "df2", "F", "p")

# Run ANOVAs
for (i in seq_along(pc_list)){
  pc <- pc_list[i]
  x <- fit.anova(pc, pc_data, "group2")
  output[i, "PC"] <- pc_list[i]
  output[i, "df1"] <- x$df[1]
  output[i, "df2"] <- x$df[2]
  output[i, "F"] <- x$statistic[1]
  output[i, "p"] <- x$p.value[1]
}

write_csv(path = here("outputs/ANOVA-results.csv"), output)
