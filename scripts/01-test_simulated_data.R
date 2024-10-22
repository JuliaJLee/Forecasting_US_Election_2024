#### Preamble ####
# Purpose: Test the simulated Presidential General Election Polls (current cycle) data 
# Author: Tianning He, Julia Lee, and Shuangyuan Yang
# Date: 22 October 2024 
# Contact: *need to fill-in
# License: MIT
# Pre-requisites: Simulate the Presidential General Election Polls (current cycle) data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)

#### Testing the Data ####

# Read in the simulated data

data <- read_csv("data/00-simulated_data/simulated_data.csv")
#view(data)

# Test 1: Testing whether there are any null or negative  values in the data
# As it is very unlikely that a pollster does not have a numeric grade or that a poll does not 
# have a percentage of votes for a candidate, this test will be useful in identifying any mistakes 
# that may exist within the data

## Test for null values within the data
is.na(data)

## Test for negative values within the data
data <= 0