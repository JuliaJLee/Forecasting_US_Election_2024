#### Preamble ####
# Purpose: Simulate the Presidential General Election Polls (current cycle) data
# Author: Tianning He, Julia Lee, and Shuangyuan Yang
# Date: 22 October 2024 
# Contact: *need to fill-in
# License: MIT
# Pre-requisites: Review the plan and sketches for the analysis in the "other" folder
# Any other information needed? N/A


#### Setting Up the Workspace ####
library(tidyverse)

#### Simulating the Data ####

set.seed(420)

# Want to generate a table that shows high-quality pollsters with a numeric grade greater than or 
# equal to 2.7 and whether each pollster was national or state-specific. 
# Want the table to also outline the date in which the poll data was created and the percentage of 
# votes or support for the candidate, Harris.

# Define table parameters (i.e. the columns of the table)

high_quality_pollsters = c("Suffolk", "AtlasIntel", "SurveyUSA", "Siena", "Marquette Law School", 
                           "Beacon/Shaw")

pollster_numeric_grade = c(2.7, 2.8, 2.9, 3)

national_or_state = c("National", "Pennsylvania", "Minnesota", "Wisconsin", "Arizona", "Nevada",
                      "Georgia", "Michigan")

candidate = c("Kamala Harris")

## Setting start and end dates to simulate the date in which the poll data was created

start_date = as.Date("2024-07-26")
end_date = as.Date("2024-10-21")

## Setting the number of observations (i.e. polls) to simulate

num_obs = 50

## Getting the percentage of votes for Harris

pct_votes = round(runif(num_obs, 40, 60), 1)

# Generate a random sample of high-quality pollsters 

simulated_data <- 
  tibble(
    pollsters = sample(high_quality_pollsters, num_obs, replace = TRUE),
    numeric_grade = sample(pollster_numeric_grade, num_obs, replace = TRUE),
    scope_of_poll = sample(national_or_state, num_obs, replace = TRUE),
    data_created = sample(seq(from = start_date, to = end_date, by = "day"), 
                          num_obs, replace = TRUE),
    candidate_name = sample(candidate, num_obs, replace = TRUE),
    percentage_of_vote = sample(pct_votes, num_obs))

#view(simulated_data)

#### Saving the Data ####

# Save the simulated data as a csv file in data/00-simulated_data
# The csv file will be called "simulated_data.csv"

write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
