#### Preamble ####
# Purpose: Use the analysis data to set up the model 
# Author: Julia Lee
# Date: 3 November 2024 
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: Clean and test the raw Presidential General Election Polls (current cycle) data 
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(testthat)
library(arrow)
library(here)

# Read in the cleaned analysis data

model_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

#view(model_data)

------------------------------------------------------------------------------------------------------

#### Organizing poll data by week ####

# Want to organize the analysis data so that polls are grouped together by the week in which
# they occurred using poll end dates
# Weeks will be defined by:
## Week 1: Aug. 4-10
## Week 2: Aug. 11-17
## Week 3: Aug. 18-24
## Week 4: Aug. 25-31
## Week 5: Sept. 1-7
## Week 6: Sept. 8-14
## Week 7: Sept. 15-21
## Week 8: Sept. 22-28
## Week 9: Sept. 29 - Oct. 5
## Week 10: Oct. 6-12
## Week 11: Oct. 13-19
## Week 12: Oct. 20-26

# Change the format of both start and end dates

changed_dates <- model_data |>
  mutate(
    start_date = mdy(start_date),
    end_date = mdy(end_date)
  )

#view(changed_dates)

# Sort the data by end date in ascending order

sorted <- changed_dates[order(changed_dates$end_date),]

#view(sorted)

# Remove the polls from 2022 and 2023

only_2024 <- sorted[-c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14), ]

#view(only_2024)

# Keep polls that ended in Aug. 6 until Oct. 26, 2024

august_start <- only_2024[-(1:14),]

#view(august_start)

aug_to_oct <- august_start[-(481:630),]

#view(aug_to_oct)

# Remove pollster, numeric_grade, state, population, and hypothetical columns 
# and filter on HARRIS

columns_to_keep <- c("start_date", "end_date", "sample_size", "candidate_name", "pct")

simplified_data = aug_to_oct[columns_to_keep]

simplified_data_harris <- simplified_data |>
  filter(
    candidate_name == "Kamala Harris")

#view(simplified_data_harris)

# Repeat the same process for TRUMP

simplified_data_trump <- simplified_data |>
  filter(
    candidate_name == "Donald Trump")

#view(simplified_data_trump)

# Organize HARRIS data by week
## The following code (lines 99-101) was provided by a Stack Overflow answer 
## (link: https://stackoverflow.com/questions/40581705/group-dates-by-week-in-r)

harris_by_week <- simplified_data_harris %>% 
  mutate(week = cut.Date(end_date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(end_date)

harris_by_week <- harris_by_week[,-c(1,2)]

#view(harris_by_week)

# Organize TRUMP data by week
## The following code (lines 111-113) was provided by a Stack Overflow answer 
## (link: https://stackoverflow.com/questions/40581705/group-dates-by-week-in-r)

trump_by_week <- simplified_data_trump %>% 
  mutate(week = cut.Date(end_date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(end_date)

trump_by_week <- trump_by_week[,-c(1,2)]

#view(trump_by_week)

------------------------------------------------------------------------------------------------------

#### Pooling poll data by week ####

# Now that polls are organized by week, want to pool the pct for each poll within each week
# to get a more precise average (i.e. a precision-weighted average) pct for each candidate

# The weight for each poll is calculated by dividing each sample size (for each poll) by the 
# sum of all sample sizes in a given week 

# This weight is then multiplied to the pct estimate of each poll to provide the weighted 
# average pct for that particular poll

# The weighted average pct for each week is the sum of all weighted averages for each poll

#### An example of this process is below

##### Weights for week 1

harris_by_week[1:4,]$sample_size / sum(harris_by_week[1:4,]$sample_size)

##### Weighted average pct for each poll in week 1

harris_by_week[1:4,]$pct * (harris_by_week[1:4,]$sample_size / sum(harris_by_week[1:4,]$sample_size))

##### Overall weighted average pct for week 1

sum(harris_by_week[1:4,]$pct * (harris_by_week[1:4,]$sample_size / sum(harris_by_week[1:4,]$sample_size)))


# Pooling polls for HARRIS

pooled_polls_harris <- tibble(
  week_1 = round(sum(harris_by_week[1:4,]$pct * (harris_by_week[1:4,]$sample_size / 
                                                   sum(harris_by_week[1:4,]$sample_size))),2),
  week_2 = round(sum(harris_by_week[5:11,]$pct * (harris_by_week[5:11,]$sample_size / 
                                             sum(harris_by_week[5:11,]$sample_size))),2),
  week_3 = round(sum(harris_by_week[12,]$pct * (harris_by_week[12,]$sample_size / 
                                             sum(harris_by_week[12,]$sample_size))),2),
  week_4 = round(sum(harris_by_week[13:25,]$pct * (harris_by_week[13:25,]$sample_size / 
                                             sum(harris_by_week[13:25,]$sample_size))),2),
  week_5 = round(sum(harris_by_week[26:40,]$pct * (harris_by_week[26:40,]$sample_size / 
                                               sum(harris_by_week[26:40,]$sample_size))),2),
  week_6 = round(sum(harris_by_week[41:45,]$pct * (harris_by_week[41:45,]$sample_size / 
                                               sum(harris_by_week[41:45,]$sample_size))),2),
  week_7 = round(sum(harris_by_week[46:81,]$pct * (harris_by_week[46:81,]$sample_size / 
                                               sum(harris_by_week[46:81,]$sample_size))),2),
  week_8 = round(sum(harris_by_week[82:130,]$pct * (harris_by_week[82:130,]$sample_size / 
                                               sum(harris_by_week[82:130,]$sample_size))),2),
  week_9 = round(sum(harris_by_week[131:136,]$pct * (harris_by_week[131:136,]$sample_size / 
                                               sum(harris_by_week[131:136,]$sample_size))),2),
  week_10 = round(sum(harris_by_week[137:162,]$pct * (harris_by_week[137:162,]$sample_size / 
                                                sum(harris_by_week[137:162,]$sample_size))),2),
  week_11 = round(sum(harris_by_week[163:197,]$pct * (harris_by_week[163:197,]$sample_size / 
                                                sum(harris_by_week[163:197,]$sample_size))),2), 
  week_12 = round(sum(harris_by_week[198:240,]$pct * (harris_by_week[198:240,]$sample_size / 
                                                sum(harris_by_week[198:240,]$sample_size))),2)
)

#view(pooled_polls_harris)

## Flipping the dataframe to have week as one column and the weighted average pct 
## for each week in another column

## The following code (line 182) was provided by a Stack Overflow answer 
## (link: https://stackoverflow.com/questions/28680994/converting-rows-into-columns-and-columns-into-rows-using-r)

final_pooled_polls_harris <- as.data.frame(t(pooled_polls_harris))

#view(final_pooled_polls_harris)

#colnames(final_pooled_polls_harris)
#row.names(final_pooled_polls_harris)

## Renaming the weighted avg. pct column 

final_pooled_polls_harris <-
  final_pooled_polls_harris |>
  rename(
    "WeightedAveragepct" = V1)

## Adding another column for each week 

final_pooled_polls_harris$Week <- c(1:12)

## Bringing "Week" column to the front

final_pooled_polls_harris <- final_pooled_polls_harris %>% relocate(Week)

## Changing row names to just be numbers 1 through 12

rownames(final_pooled_polls_harris) <- c(1:12)

#view(final_pooled_polls_harris)


# Pooling polls for TRUMP

pooled_polls_trump <- tibble(
  week_1 = round(sum(trump_by_week[1:4,]$pct * (trump_by_week[1:4,]$sample_size / 
                                                   sum(trump_by_week[1:4,]$sample_size))),2),
  week_2 = round(sum(trump_by_week[5:11,]$pct * (trump_by_week[5:11,]$sample_size / 
                                                    sum(trump_by_week[5:11,]$sample_size))),2),
  week_3 = round(sum(trump_by_week[12,]$pct * (trump_by_week[12,]$sample_size / 
                                                  sum(trump_by_week[12,]$sample_size))),2),
  week_4 = round(sum(trump_by_week[13:25,]$pct * (trump_by_week[13:25,]$sample_size / 
                                                     sum(trump_by_week[13:25,]$sample_size))),2),
  week_5 = round(sum(trump_by_week[26:40,]$pct * (trump_by_week[26:40,]$sample_size / 
                                                     sum(trump_by_week[26:40,]$sample_size))),2),
  week_6 = round(sum(trump_by_week[41:45,]$pct * (trump_by_week[41:45,]$sample_size / 
                                                     sum(trump_by_week[41:45,]$sample_size))),2),
  week_7 = round(sum(trump_by_week[46:81,]$pct * (trump_by_week[46:81,]$sample_size / 
                                                     sum(trump_by_week[46:81,]$sample_size))),2),
  week_8 = round(sum(trump_by_week[82:130,]$pct * (trump_by_week[82:130,]$sample_size / 
                                                      sum(trump_by_week[82:130,]$sample_size))),2),
  week_9 = round(sum(trump_by_week[131:136,]$pct * (trump_by_week[131:136,]$sample_size / 
                                                       sum(trump_by_week[131:136,]$sample_size))),2),
  week_10 = round(sum(trump_by_week[137:162,]$pct * (trump_by_week[137:162,]$sample_size / 
                                                        sum(trump_by_week[137:162,]$sample_size))),2),
  week_11 = round(sum(trump_by_week[163:197,]$pct * (trump_by_week[163:197,]$sample_size / 
                                                        sum(trump_by_week[163:197,]$sample_size))),2), 
  week_12 = round(sum(trump_by_week[198:240,]$pct * (trump_by_week[198:240,]$sample_size / 
                                                        sum(trump_by_week[198:240,]$sample_size))),2)
)

#view(pooled_polls_trump)

## Flipping the dataframe to have week as one column and the weighted average pct 
## for each week in another column

## The following code (line 182) was provided by a Stack Overflow answer 
## (link: https://stackoverflow.com/questions/28680994/converting-rows-into-columns-and-columns-into-rows-using-r)

final_pooled_polls_trump <- as.data.frame(t(pooled_polls_trump))

#view(final_pooled_polls_trump)

#colnames(final_pooled_polls_trump)
#row.names(final_pooled_polls_trump)

## Renaming the weighted avg. pct column 

final_pooled_polls_trump <-
  final_pooled_polls_trump |>
  rename(
    "WeightedAveragepct" = V1)

## Adding another column for each week 

final_pooled_polls_trump$Week <- c(1:12)

## Bringing "Week" column to the front

final_pooled_polls_trump <- final_pooled_polls_trump %>% relocate(Week)

## Changing row names to just be numbers 1 through 12

rownames(final_pooled_polls_trump) <- c(1:12)

#view(final_pooled_polls_trump)

------------------------------------------------------------------------------------------------------

#### Fitting a regression model with the weekly pooled polls data ####

# Want to perform a regression analysis for both Harris and Trump with 
# y = pct and w = week


# Regression model: HARRIS

harris_model <- lm(formula = WeightedAveragepct ~ Week, data = final_pooled_polls_harris)
summary(harris_model)

## Saving model

saveRDS(
  harris_model,
  file = "models/harris_model.rds"
)

## Residual Plots & Normal Q-Q Plot

### Find residuals

residuals <- harris_model$residuals

### Residuals vs. Predictor

plot(residuals ~ final_pooled_polls_harris$Week, main = "Residuals vs. Week", xlab = "Week", ylab = "Residuals")

### Residuals vs. Fitted Values

fitted_values <- harris_model$fitted.values

plot(residuals ~ fitted_values, main = "Residuals vs. Fitted Values", xlab = "Fitted Values", ylab = "Residuals")

### Normal Q-Q Plot

qqnorm(residuals)
qqline(residuals)


# Regression model: TRUMP

trump_model <- lm(formula = WeightedAveragepct ~ Week, data = final_pooled_polls_trump)
summary(trump_model)

## Saving model

saveRDS(
  trump_model,
  file = "models/trump_model.rds"
)

## Residual Plots & Normal Q-Q Plot

### Find residuals

residuals <- trump_model$residuals

### Residuals vs. Predictor

plot(residuals ~ final_pooled_polls_trump$Week, main = "Residuals vs. Week", xlab = "Week", ylab = "Residuals")

### Residuals vs. Fitted Values

fitted_values <- trump_model$fitted.values

plot(residuals ~ fitted_values, main = "Residuals vs. Fitted Values", xlab = "Fitted Values", ylab = "Residuals")

### Normal Q-Q Plot

qqnorm(residuals)
qqline(residuals)

------------------------------------------------------------------------------------------------------

#### Finding seasonal indexes to forecast Harris and Trump support in week 13 ####

# Using the linear model fitted above, want to create a seasonal index for each week so that the week leading
# up to the election (week 13) can be predicted while accounting for differences in voter opinions across 
# different time periods

# Categorize weeks into three groups - one for each month (August, September, and October)
# Each month should have 4 weeks 

## For HARRIS

by_month_harris <- final_pooled_polls_harris |>
  mutate(month = lubridate::floor_date(week_start = 7, "4 weeks")) %>%
  group_by(month) 
