# Functions to run analyses on rarefied Phocoena phocoena
# datasets
#---------------------------------------------------------

#---------------------------------------------------------
# Extract PCA scores after GPA
#---------------------------------------------------------
get_pcs <- function(points, curves, metadata, nporpoise){

# Generalised Procrustes Analysis
intra_gpa <- gpagen(points, curves = curves)

# Principal Components Analysis
intra_pca <- plotTangentSpace(intra_gpa$coords, legend = TRUE, label = TRUE,
                              warpgrids = FALSE, plot = FALSE)

# Extract PC scores and make .pts file name into
# a taxon column for combining with the metadata
pc_scores <- data.frame(filename = rownames(intra_pca$pc.scores), 
                        intra_pca$pc.scores)

# Merge with metadata
pc_data <- right_join(metadata, pc_scores, by = "filename")

# Add number of porpoises to output
pc_data <- 
  pc_data %>%
  mutate(nporpoise = rep(nporpoise, length(pc_data$filename)))
  
# Return
return(pc_data)

}

#---------------------------------------------------------
# Select just the number of porpoises needed
#---------------------------------------------------------
select_porpoise <- function(nporpoise, points, 
                            porpoise_list){

# Work out how many porpoises need to be removed
nremove <- 18 - nporpoise
# Select a random set of that many porpoises to
# remove
exclude <- sample(porpoise_list, nremove)

# Exclude the specimens from ptsarray and continue
ptsarray[, , -exclude]

}

#---------------------------------------------------------
# Run MANOVAs
# To determine if variation within Phocoena phocoena
# is significantly less than within the clade
# Fit the model for all odontocetes
# Column 16 = PC1, column 54 = PC39 (95% of variation
# in overall model, we will stick with this for simplicity)
#----------------------------------------------------------
fit_manova <- function(pca, output, nporpoise){

model1 <- manova(as.matrix(pca[, 16:54]) ~ group, data = pca)

# Store all the outputs
output[i,"nporpoise"] <- nporpoise
output[i, "df1"] <- anova(model1)$Df[2]
output[i, "df2"] <- anova(model1)$Df[3]
output[i, "Pillai"] <- anova(model1)$Pillai[2]
output[i, "approxF"] <- anova(model1)$`approx F`[2]
output[i, "p"] <- anova(model1)$`Pr(>F)`[2]

return(output)

}

#----------------------------------------------------------
# Create MANOVA output file
#----------------------------------------------------------
create_MANOVA_output <- function(sims){
  output <- data.frame(array(dim = c(sims, 6)))
  names(output) <- c("nporpoise", "df1", "df2", "Pillai", "approxF", "p")
  return(output)
}

#----------------------------------------------------------
# Create ANOVA output file
#----------------------------------------------------------
create_ANOVA_output <- function(sims){
  ANOVA_output <- data.frame(array(dim = c(sims*10, 6)))
  names(ANOVA_output) <- c("nporpoise", "PC", "df1", "df2", "F", "p")
  return(ANOVA_output)
}

#--------------------------------------------
# Fit ANOVAs for each individual PC
#--------------------------------------------
fit_anova <- function(pca, ANOVA_output, nporpoise){

  # List PCs for ANOVA (first 10)
  pc_list <- names(pca)[16:25]
  
  # Run ANOVAs
  for (j in seq_along(pc_list)){
    pc <- pc_list[j]
    x <- fit.anova(pc, pca, "group")
    ANOVA_output[j,"nporpoise"] <- nporpoise
    ANOVA_output[j, "PC"] <- pc_list[j]
    ANOVA_output[j, "df1"] <- x$df[1]
    ANOVA_output[j, "df2"] <- x$df[2]
    ANOVA_output[j, "F"] <- x$statistic[1]
    ANOVA_output[j, "p"] <- x$p.value[1]
  }
  
  return(ANOVA_output)
  
}
