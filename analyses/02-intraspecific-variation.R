# Intraspecific variation in Phocoena phocoena 
# Maria Clara Iruzun Martins April 2019
# Modified by Natalie Cooper May 2019
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
#--------------------------------------------
pc_data <- read_csv(here("data/porpoise-data.csv"))

#--------------------------------------------
# MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the genus 
#--------------------------------------------
# Fit the model for all specimens
model1 <- manova(as.matrix(pc_data[, 6:21]) ~ group, data = pc_data)
# Look at overall model significance
anova(model1)

# Subset the data to remove the extinct species
pc_data2 <- filter(pc_data, type == "living")

# Fit the model
model2 <- manova(as.matrix(pc_data2[, 6:21]) ~ group, data = pc_data2)
anova(model2)

# Subset the data to remove the non P.p living species
pc_data3 <- filter(pc_data, 
                   taxon != "Phocoena_sinus" &
                   taxon != "Phocoena_dioptrica")

# Fit the model
model3 <- manova(as.matrix(pc_data3[, 6:21]) ~ group, data = pc_data3)
anova(model3)

# Create an output file for three subsets
output <- data.frame(array(dim = c(15, 5)))
names(output) <- c("outgroup", "df1", "df2", "Pillai", "p")

# Store all the outputs
output[1, "outgroup"] <- "all"
output[1, "df1"] <- anova(model1)$Df[2]
output[1, "df2"] <- anova(model1)$Df[3]
output[1, "Pillai"] <- anova(model1)$Pillai[2]
output[1, "p"] <- anova(model1)$`Pr(>F)`[2]

output[2, "outgroup"] <- "living"
output[2, "df1"] <- anova(model2)$Df[2]
output[2, "df2"] <- anova(model2)$Df[3]
output[2, "Pillai"] <- anova(model2)$Pillai[2]
output[2, "p"] <- anova(model2)$`Pr(>F)`[2]

output[3, "outgroup"] <- "fossil"
output[3, "df1"] <- anova(model3)$Df[2]
output[3, "df2"] <- anova(model3)$Df[3]
output[3, "Pillai"] <- anova(model3)$Pillai[2]
output[3, "p"] <- anova(model3)$`Pr(>F)`[2]

# Write to file
write_csv(path = here("outputs/MANOVA-results.csv"), output)

#--------------------------------------------
# Fit ANOVAs for each individual PC
#--------------------------------------------
# Quick function to run all anovas
fit.anova <- function(pc, data, grouping.var) {
  pc_ <- pull(pc_data, pc)
  grouping.var_ <- pull(pc_data, grouping.var)
  model <- lm(pc_ ~ grouping.var_, data = data)
  out <- tidy(anova(model))
  return(out)
}

# List names of forst 16 PCs
pc_list <- names(pc_data)[5:20]

# Create an output file for three subsets
output <- data.frame(array(dim = c((16*3), 6)))
names(output) <- c("PC", "outgroup", "df1", "df2", "F", "p")

# All species in outgroup
for (i in seq_along(pc_list)){
  pc <- pc_list[i]
  x <- fit.anova(pc, pc_data, "group")
  output[i, "PC"] <- pc_list[i]
  output[i, "outgroup"] <- "all"
  output[i, "df1"] <- x$df[1]
  output[i, "df2"] <- x$df[2]
  output[i, "F"] <- x$statistic[1]
  output[i, "p"] <- x$p.value[1]
}

# Remove the extinct species
for (i in seq_along(pc_list)){
  pc <- pc_list[i]
  x <- fit.anova(pc, pc_data2, "group")
  output[i+16, "PC"] <- pc_list[i]
  output[i+16, "outgroup"] <- "living"
  output[i+16, "df1"] <- x$df[1]
  output[i+16, "df2"] <- x$df[2]
  output[i+16, "F"] <- x$statistic[1]
  output[i+16, "p"] <- x$p.value[1]
}

# Remove the living species outgroups
for (i in seq_along(pc_list)){
  pc <- pc_list[i]
  x <- fit.anova(pc, pc_data3, "group")
  output[i+32, "PC"] <- pc_list[i]
  output[i+32, "outgroup"] <- "fossil"
  output[i+32, "df1"] <- x$df[1]
  output[i+32, "df2"] <- x$df[2]
  output[i+32, "F"] <- x$statistic[1]
  output[i+32, "p"] <- x$p.value[1]
}

write_csv(path = here("outputs/ANOVA-results.csv"), output)
