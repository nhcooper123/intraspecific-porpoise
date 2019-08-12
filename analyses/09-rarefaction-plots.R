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

# Get median values for p values for each nporpoise
median_man <-
  man %>%
  filter(!is.na(nporpoise)) %>%
  group_by(nporpoise) %>%
  summarise(mean = median(p),
            se = sqrt(var(p/length(p))),
            sig = sum(p < 0.05)/n() * 100)
# Plots 
plot1 <- 
  ggplot(median_man, aes(x = nporpoise, y = mean)) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.1) +
  theme_bw(base_size = 14) +
  ylab("median p value") +
  xlab("number of porpoise specimens") +
  geom_point(data = man1, aes(x = 18, y = p[1]), size = 2) +
  geom_hline(yintercept = 0.05, linetype = 2, colour = "red")
  
ggsave(here("outputs/rare-MANOVA-overall.png"), plot1)

plot2 <- 
  ggplot(man, aes(x = p)) +
  geom_density() +
  theme_bw(base_size = 14) +
  xlab("MANOVA p value") +
  facet_wrap(~nporpoise, scales = "free") +
  theme(strip.background = element_rect(fill = "white"),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 12)) +
  geom_vline(data = data.frame(xint = rep(0.05,8), nporpoise = c(2:9)), 
             aes(xintercept = xint), 
             linetype = "dashed", colour = "red")

ggsave(here("outputs/rare-MANOVA-p-density.png"), plot2, width = 7, height = 12)
