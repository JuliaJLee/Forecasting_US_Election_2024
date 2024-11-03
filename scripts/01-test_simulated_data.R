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
library(testthat)

#### Testing the Data ####

# Read in the simulated data

data <- read_csv("data/00-simulated_data/simulated_data.csv")

#view(data)

# (1) Test for missing values and negative values

is.na(data)

data < 0

# (2) Test for valid state names, populations, candidate names, and hypothetical 
# match-ups

test_that("There are valid state names", {
  expect_true(all(data$state %in% c("National", "Pennsylvania", "Minnesota", "Wisconsin", 
                                    "Arizona", "Nevada", "Georgia", "Michigan")))})

test_that("There are valid voting populations", {
  expect_true(all(data$population %in% c("lv", "rv")))})

test_that("There are valid candidate names", {
  expect_true(all(data$candidate_name %in% c("Kamala Harris", "Donald Trump")))})

test_that("Hypothetical match-up values are either false or true", {
  expect_true(all(data$hypothetical_match_up %in% c("FALSE", "TRUE")))})

# (3) Test that pct does not exceed 100 (i.e. is 
# between 0 and 100)

test_that("pct for both candidates is between 0 and 100", {
  expect_true(all(data$pct >= 0 & data$pct <= 100))
})

# (4) Test that end date comes after start date

test_that("The end date of a poll is a date after its start date", {
  expect_true(all(data$end_date 0 & data$pct <= 100))
})

# (5) Test that sample size is appropriate (i.e. greater than 30)



# (6) Test for numeric grade (i.e. that it is between 2.7 and 3)


