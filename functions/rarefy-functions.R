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