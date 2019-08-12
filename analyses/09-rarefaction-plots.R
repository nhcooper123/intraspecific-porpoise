# Plot results of rarefaction
# Aug 2019
#------------------------------------

#------------------------------------
# Load libraries
#------------------------------------
library(here)
library(tidyverse)
#-------------------------------------
# Read in data
man <- read_csv(here("outputs/rarefied-MANOVA-results-landmarks.csv"))

# Extract values for 18 porpoises
man1 <- read_csv(here("outputs/MANOVA-results-landmarks.csv"))

# Get mean values for p values for each nporpoise
# and each PC in ANOVAs
mean_man <-
  man %>%
  filter(!is.na(nporpoise)) %>%
  group_by(nporpoise) %>%
  summarise(mean = median(p),
            se = sqrt(var(p/length(p))))

# Plots 
plot1 <- 
  ggplot(mean_man, aes(x = nporpoise, y = mean)) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.1) +
  theme_bw(base_size = 14) +
  ylab("mean p value") +
  xlab("number of porpoise specimens") +
  geom_point(data = man1, aes(x = 18, y = p[1]))

ggsave(here("outputs/rare-MANOVA.png"))


ggplot(man, aes(x = p, group = nporpoise)) +
  geom_density() +
  theme_bw(base_size = 14) +
  xlab("number of porpoise specimens") +
  facet_wrap(~nporpoise, scales = "free")
