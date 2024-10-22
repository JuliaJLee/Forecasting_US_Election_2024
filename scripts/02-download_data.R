#### Preamble ####
# Purpose: Download and save the actual Presidential General Election Polls (current cycle) data 
# as of October 21, 2024
# Author: Tianning He, Julia Lee, and Shuangyuan Yang
# Date: 22 October 2024 
# Contact: *need to fill-in 
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