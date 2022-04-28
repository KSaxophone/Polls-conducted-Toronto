#### Preamble ####
# Purpose: Clean the data downloaded from https://open.toronto.ca/dataset/polls-conducted-by-the-city/
# Author: Yizhen Wang
# Data: 27 April 2022
# Contact: kerry.wang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
# Use R Projects, not setwd().

library(tidyverse)
library(ggplot2)
library(car)
library(knitr)
library(opendatatoronto)
library(dplyr)
library(kableExtra)
library(patchwork)
library(broom)
library(ggpubr)

# Load data
raw_data <- read_csv("Polls Data.csv")

# Clean Data
polls_clean <- raw_data %>%
  # Filter the missing value in pass rates
  filter(!is.na(PASS_RATE)) %>%
  # Create a new variable that represents the missing ballots
  mutate(MISSING = BALLOTS_DISTRIBUTED - BALLOTS_CAST) %>%
  # Select relevant variables that can be potential predictors
  select(APPLICATION_FOR, BALLOTS_BLANK, BALLOTS_IN_FAVOUR, BALLOTS_NEEDED_TO_PROCEED, BALLOTS_OPPOSED, BALLOTS_RECEIVED_BY_VOTERS, BALLOTS_RETURNED_TO_SENDER, BALLOTS_SPOILED, FINAL_VOTER_COUNT, PASS_RATE, POLL_RESULT, POTENTIAL_VOTERS, RESPONSE_RATE_MET, MISSING)

# example of ploting
## BALLOTS_BLANK & PASS_RATE
polls_clean %>%
  ggplot(aes(x=BALLOTS_BLANK, y=PASS_RATE)) +
  geom_point()+
  geom_smooth(method="lm")+
  theme_classic() +
  labs(x = "Counts of Blank Ballots", y = "Pass Rate")

polls_clean %>% 
  ggplot(aes(x = APPLICATION_FOR, fill = POLL_RESULT)) +
  geom_bar() +
  theme_classic() +
  labs(x = "Votes for Application Types", y = "Count")+
  theme(axis.text.x = element_text(angle = 20, 
                                   hjust=1, size=6))
```



```