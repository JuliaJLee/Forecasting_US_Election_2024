#### Preamble ####
# Purpose: Test the cleaned Presidential General Election Polls (current cycle) data 
# Author: Julia Lee
# Date: 22 October 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Clean the raw Presidential General Election Polls (current cycle) data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(testthat)
library(arrow)
library(here)

#### Testing Cleaned Data ####

# Read in the cleaned analysis data

testing_clean_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

#view(testing_clean_data)

# (1) Test for missing values and negative values

test_that("There are no missing values", {
  expect_true(!all(is.na(testing_clean_data)))})

test_that("There are no negative values", {
  expect_true(!all(testing_clean_data < 0))})

# (2) Test for valid state names, populations, candidate names, hypothetical 
# match-ups, and pollster names

states = unique(testing_clean_data$state)

test_that("There are valid state names", {
  expect_true(all(testing_clean_data$state %in% states))})

test_that("There are valid voting populations", {
  expect_true(all(testing_clean_data$population %in% c("lv")))})

test_that("There are valid candidate names", {
  expect_true(all(testing_clean_data$candidate_name %in% c("Kamala Harris", "Donald Trump")))})

test_that("Hypothetical match-up values are false", {
  expect_true(all(testing_clean_data$hypothetical %in% c("FALSE")))})

pollsters = unique(testing_clean_data$pollster)

test_that("There are valid pollster names", {
  expect_true(all(testing_clean_data$pollster %in% pollsters))})

# (3) Test that pct does not exceed 100 (i.e. is 
# between 0 and 100)

test_that("pct for both candidates is between 0 and 100", {
  expect_true(all(testing_clean_data$pct >= 0 & testing_clean_data$pct <= 100))
})

# (4) Test that end date comes after start date

test_that("The end date of a poll is a date after its start date", {
  expect_true(!all(apply(testing_clean_data[, c("start_date", "end_date")], 1, is.unsorted)))
})

# (5) Test that sample size is appropriate (i.e. greater than or 
# equal to 30)

test_that("Sample sizes are greater than 30", {
  expect_true(all(testing_clean_data$sample_size > 30))
})

# (6) Test for numeric grade (i.e. that it is between 2.7 and 3)

test_that("Pollster numeric grades are between 2.7 and 3, including endpoints", 
          {expect_true(all(testing_clean_data$numeric_grade >= 2.7 & testing_clean_data$numeric_grade <=3))
          })
