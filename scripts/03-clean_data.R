#### Preamble ####
# Purpose: Clean the raw Presidential General Election Polls (current cycle) data 
# Author: Julia Lee
# Date: 22 October 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download and save the actual Presidential General Election Polls 
# (current cycle) data from 538
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(dplyr)
library(arrow)

#### Cleaning the Data ####

# Read in the raw data

data <- read_csv("data/01-raw_data/raw_data.csv")

# Want to clean the data so that the data:
# (1) is filtered on pollsters with a numeric grade of 2.7 and higher
# (2) shows state-specific polls
# (3) shows polls that targeted the likely voter population
# (4) displays the start and end dates of polls between July 7, 2024 and October 26, 2024
# (5) presents the sample size of each poll
# (6) displays polls that did not ask about hypothetical match-ups between candidates
# (7) is filtered on Harris and Trump
# (8) shows the pct for Harris and Trump
 
## Selecting columns that correspond with the variables listed above

colnames(data)

columns_to_keep <- c("pollster","numeric_grade", "state", "start_date", "end_date", "sample_size",
                     "population", "hypothetical", "candidate_name", "pct")

new_data = data[columns_to_keep]

#view(new_data)

## Filtering the selected columns: high-quality pollsters (>= 2.7), state-specific polls 
## (i.e. not national ones), likely voters (lv), non-hypothetical match-ups 
## (hypothetical = False), and Harris and Trump

filtered_data <- new_data |>
  filter(
    numeric_grade >= 2.7,
    state != is.na(state),
    population == "lv",
    hypothetical == "FALSE",
    candidate_name == "Kamala Harris" | candidate_name == "Donald Trump")

#view(filtered_data)

#### Saving the Data ####

# Save the cleaned data as a parquet file in data/02-analysis_data
# The file will be called "analysis_data.parquet"

write_parquet(filtered_data, "data/02-analysis_data/analysis_data.parquet")