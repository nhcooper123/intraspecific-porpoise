# Plot results of rearefaction
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
an <- read_csv(here("outputs/rarefied-ANOVA-results-landmarks.csv"))

# Extract values for 18 porpoises
man1 <- read_csv(here("outputs/MANOVA-results-landmarks.csv"))
an1 <- read_csv(here("outputs/ANOVA-results-landmarks.csv"))

# Get mean values for p values for each nporpoise
# and each PC in ANOVAs
mean_man <-
  man %>%
  group_by(nporpoise) %>%
  summarise(mean = mean(p),
            se = sqrt(var(p/sd(p))))

mean_an <-
  an %>%
  group_by(nporpoise, PC) %>%
  summarise(mean = mean(p),
            se = sqrt(var(p/sd(p))))

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

plot2 <- 
  ggplot(mean_an, aes(x = nporpoise, y = mean)) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.1) +
  theme_bw(base_size = 14) +
  facet_wrap(~PC, ncol = 5) +
  theme(strip.background = element_rect(fill="white")) +
  ylab("mean p value") +
  xlab("number of porpoise specimens")

ggsave(here("outputs/rare_ANOVA.png")) 