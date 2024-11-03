#### Preamble ####
# Purpose: Download and save the actual Presidential General Election Polls (current cycle) data 
# as of November 2, 2024
# Author: Julia Lee
# Date: 3 November 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(dplyr)

#### Reading in the downloaded data ####

raw_data <- read.csv("data/01-raw_data/president_polls.csv")

#### Saving the data again to clean ####

write.csv(raw_data, file = "data/01-raw_data/raw_data.csv")
