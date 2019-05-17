# Functions for intraspecific scripts
# May 2019
# ------------------------------------

# ------------------------------------
# Quick function to run all anovas
# ------------------------------------
fit.anova <- function(pc, data, grouping.var) {
  pc_ <- pull(data, pc)
  grouping.var_ <- pull(data, grouping.var)
  model <- lm(pc_ ~ grouping.var_, data = data)
  out <- tidy(anova(model))
  return(out)
}

# ---------------------------------------------------
# Convex hulls functions for grouped data
# ----------------------------------------------------
# pc1 = column number of the X axis PC you want to make a hull for
# pc2 = column number of the Y axis PC you want to make a hull for
# grouping_var = column number of the grouping variable to split the hulls
# n = number of groups
make_hull <- function(data, pc1, pc2, n, grouping_var){
  
  # Make empty output list
  hulls_x <- list()
  
  # Make hulls
  for(i in 1:n) {
    data2 <- data[data[, grouping_var] == as.character(unique(data[, grouping_var])[i,]), ]
    hull <- spatstat::convexhull.xy(pull(data2[ , pc1]), pull(data2[ , pc2]))
    hulls_x[[i]] <- data.frame(x = hull$bdry[[1]]$x, y = hull$bdry[[1]]$y)
  }
  
  # Add names
  names(hulls_x) <- unique(data[, grouping_var])[[1]]
  
  return(hulls_x)
}