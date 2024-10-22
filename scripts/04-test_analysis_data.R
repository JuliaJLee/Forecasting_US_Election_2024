#### Preamble ####
# Purpose: Test the cleaned Presidential General Election Polls (current cycle) data 
# Author: Tianning He, Julia Lee, and Shuangyuan Yang
# Date: 22 October 2024 
# Contact: *need to fill-in
# License: MIT
# Pre-requisites: Clean the raw Presidential General Election Polls (current cycle) data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)

#### Testing Cleaned Data ####

# Read in the simulated data

testing_clean_data <- read_csv("data/02-analysis_data/analysis_data.csv")
#view(testing_clean_data)

# Test 1: Testing whether there are any null or negative  values in the data
# As it is very unlikely that a pollster does not have a numeric grade or that a poll does not 
# have a percentage of votes for a candidate, this test will be useful in identifying any mistakes 
# that may exist within the data

## Test for null values within the data
is.na(testing_clean_data)

## Test for negative values within the data
testing_clean_data <= 0