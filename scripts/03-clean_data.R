#### Preamble ####
# Purpose: Clean the raw Presidential General Election Polls (current cycle) data 
# Author: Tianning He, Julia Lee, and Shuangyuan Yang
# Date: 22 October 2024 
# Contact: *need to fill-in
# License: MIT
# Pre-requisites: Download and save the actual Presidential General Election Polls 
# (current cycle) data from 538
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(dplyr)

#### Cleaning the Data ####

# Read in the raw data

data <- read_csv("data/01-raw_data/raw_data.csv")

# Create a new dataframe with desired variables
# Want to keep the pollster name, numeric grades, state, the date when the data was 
# created, the population of voters, whether the poll considered a hypothetical 
# match-up, the candidate name, and the percentage of vote

colnames(data)

columns_to_keep <- c("pollster","numeric_grade", "state", "population", "created_at", 
                     "hypothetical", "candidate_name", "pct")

new_data = data[columns_to_keep]
#view(new_data)

# Now want to filter on high-quality pollsters (>= 2.7), likely voters (lv),
# non-hypothetical match-ups (hypothetical = False), and Harris

filtered_data <- new_data |>
  filter(
    numeric_grade >= 2.7,
    population == "lv",
    hypothetical == "FALSE",
    candidate_name == "Kamala Harris")

#view(filtered_data)

# Change the NA values in the "state" column to "National"

cleaned_data <- filtered_data |>
  mutate(
    state = if_else(is.na(state), "National", state))

#view(cleaned_data)


#### Saving the Data ####

# Save the cleaned data as a csv file in data/02-analysis_data
# The csv file will be called "analysis_data.csv"

write_csv(cleaned_data, file = "data/02-analysis_data/analysis_data.csv")