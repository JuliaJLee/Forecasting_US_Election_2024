#### Preamble ####
# Purpose: Simulate the Presidential General Election Polls (current cycle) data
# Author: Julia Lee
# Date: 22 October 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Review the plan and sketches for the analysis in the "plan" folder
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)

#### Simulating the Data ####

set.seed(919)

# Want to generate a table that shows high-quality pollsters with a numeric grade greater than or 
# equal to 2.7 and whether each pollster was national or state-specific. 
# Want the table to also outline the start and end dates of the polls, the population of voters
# (e.g. likey voters or registered ones), whether the poll was a hypothetical match-up, and the percentage 
# of votes or support for each candidate, Harris and Trump.

## Define table parameters (i.e. the columns of the table)

high_quality_pollsters = c("Suffolk", "AtlasIntel", "SurveyUSA", "Siena", "Marquette Law School", 
                           "Beacon/Shaw")

pollster_numeric_grade = c(2.7, 2.8, 2.9, 3)

national_or_state = c("National", "Pennsylvania", "Minnesota", "Wisconsin", "Arizona", "Nevada",
                      "Georgia", "Michigan")

candidate = c("Kamala Harris", "Donald Trump")

population_voters = c("lv", "rv")

hypothetical = c("FALSE", "TRUE")

## Setting start and end dates to simulate the date in which the polls ended 

start = as.Date("2024-07-07")
end = as.Date("2024-10-26")

## Setting the number of observations (i.e. polls) to simulate

num_obs = 50

## Getting the percentage of support for the candidates

pct_votes = round(runif(num_obs, 40, 60), 1)

## Generate a simulation of the data using the variables defined above

simulated_data <- 
  tibble(
    pollsters = sample(high_quality_pollsters, num_obs, replace = TRUE),
    numeric_grade = sample(pollster_numeric_grade, num_obs, replace = TRUE),
    state = sample(national_or_state, num_obs, replace = TRUE),
    population = sample(population_voters, num_obs, replace = TRUE),
    start_date = sample(seq(from = start, to = end, by = "day"), 
                          num_obs, replace = TRUE),
    end_date = start_date + sample(3:4, length(start_date), replace = TRUE),
    hypothetical_match_up = sample(hypothetical, num_obs, replace = TRUE),
    candidate_name = sample(candidate, num_obs, replace = TRUE),
    pct = sample(pct_votes, num_obs))

#view(simulated_data)

#### Saving the Data ####

# Save the simulated data as a csv file in data/00-simulated_data
# The csv file will be called "simulated_data.csv"

write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
