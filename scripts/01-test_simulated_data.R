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

test_that("There are no missing values", {
  expect_true(!all(is.na(data)))})

test_that("There are no negative values", {
  expect_true(all(data <0))})

# (2) Test for valid state names, populations, candidate names, hypothetical 
# match-ups, and pollster names

test_that("There are valid state names", {
  expect_true(all(data$state %in% c("National", "Pennsylvania", "Minnesota", "Wisconsin", 
                                    "Arizona", "Nevada", "Georgia", "Michigan")))})

test_that("There are valid voting populations", {
  expect_true(all(data$population %in% c("lv", "rv")))})

test_that("There are valid candidate names", {
  expect_true(all(data$candidate_name %in% c("Kamala Harris", "Donald Trump")))})

test_that("Hypothetical match-up values are either false or true", {
  expect_true(all(data$hypothetical_match_up %in% c("FALSE", "TRUE")))})

test_that("There are valid pollster names", {
  expect_true(all(data$pollsters %in% c("Suffolk", "AtlasIntel", "SurveyUSA", "Siena", "Marquette Law School", 
                                        "Beacon/Shaw")))})

# (3) Test that pct does not exceed 100 (i.e. is 
# between 0 and 100)

test_that("pct for both candidates is between 0 and 100", {
  expect_true(all(data$pct >= 0 & data$pct <= 100))
})

# (4) Test that end date comes after start date

test_that("The end date of a poll is a date after its start date", {
  expect_true(all(data$end_date > data$start_date))
})

# (5) Test that sample size is appropriate (i.e. greater than or 
# equal to 30)

test_that("Sample sizes are greater than or equal to 30", {
  expect_true(all(data$sample_size >= 30))
})

# (6) Test for numeric grade (i.e. that it is between 2.7 and 3)

test_that("Pollster numeric grades are between 2.7 and 3, including endpoints", 
          {expect_true(all(data$numeric_grade >= 2.7 & data$numeric_grade <=3))
})
