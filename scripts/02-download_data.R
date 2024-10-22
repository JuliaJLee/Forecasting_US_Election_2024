#### Preamble ####
# Purpose: Download and save the actual Presidential General Election Polls (current cycle) data 
# as of October 21, 2024
# Author: Tianning He, Julia Lee, and Shuangyuan Yang
# Date: 22 October 2024 
# Contact: *need to fill-in 
# License: MIT
# Pre-requisites: None
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(tidyverse)
library(dplyr)

#### Reading in the downloaded data ####



#### Creating a Dataframe with the Downloaded Data ####

# As the downloaded data is in "xlsx" format and very large, a dataframe for each year's 
# raw data will be created and saved as separate csv files
# Each dataframe will be saved in the "data/raw_data" folder

# Dataframe for 2017 Data

paramedic_services_data_2017 <- 
  tibble(
    data$"2017")

paramedic_services_data_2017

write.csv(paramedic_services_data_2017, file = "data/raw_data/raw_data_2017.csv")

# Dataframe for 2018 Data

paramedic_services_data_2018 <- 
  tibble(
    data$"2018")

paramedic_services_data_2018

write.csv(paramedic_services_data_2018, file = "data/raw_data/raw_data_2018.csv")

# Dataframe for 2019 Data

paramedic_services_data_2019 <- 
  tibble(
    data$"2019")

paramedic_services_data_2019

write.csv(paramedic_services_data_2019, file = "data/raw_data/raw_data_2019.csv")

# Dataframe for 2020 Data

paramedic_services_data_2020 <- 
  tibble(
    data$"2020")

paramedic_services_data_2020

write.csv(paramedic_services_data_2020, file = "data/raw_data/raw_data_2020.csv")

# Dataframe for 2021 Data

paramedic_services_data_2021 <- 
  tibble(
    data$"2021")

paramedic_services_data_2021

write.csv(paramedic_services_data_2021, file = "data/raw_data/raw_data_2021.csv")

# Dataframe for 2022 Data

paramedic_services_data_2022 <- 
  tibble(
    data$"2022")

paramedic_services_data_2022

write.csv(paramedic_services_data_2022, file = "data/raw_data/raw_data_2022.csv")