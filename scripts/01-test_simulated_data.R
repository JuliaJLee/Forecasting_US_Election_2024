#### Preamble ####
# Purpose: Test the simulated Presidential General Election Polls (current cycle) data 
# Author: Julia Lee
# Date: 22 October 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Simulate the Presidential General Election Polls (current cycle) data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)

#### Testing the Data ####

# Read in the simulated data

data <- read_csv("data/00-simulated_data/simulated_data.csv")
#view(data)

# (1) Test for missing values
# (2) Test for valid state names, poulations, and candidate names

# Test for Internal Consistency: (1) Test that pct does not exceed 100 (i.e. is 
# between 0 and 100), (2) Test that end date 