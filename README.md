# Forecasting the 2024 US Election

## Overview

This repository provides readers with all the necessary data, R scripts, and files to understand and reproduce a model on forecasting the 2024 US Presidential election.


## File Structure

The repository is structured as follows:

- The `plan` directory contains a folder (`llm_usage`) that holds chat histories along with a `sketches` folder that has research/background notes and sketches for this analysis.
- All of the original data used within this analysis can be found in the `data/01-raw_data` directory. The data was provided by and obtained from 538 (FiveThirtyEight). 
- The `data/02-analysis_data` folder contains a cleaned version of the original data that was used. This data is saved as a parquet file.
- In the `data` directory, there is also a folder that has simulated data saved as a csv file.
- The `scripts` folder contains all the R scripts and code that simulated, tested, downloaded, and cleaned the data. A script outlining the code for the model used within this analysis (`05-model_analysis_data`) can also be found in this directory.
- Models that were built within this analysis can be found in the `models` directory as rds files. 
- The files used to generate the written analysis can be found in the `paper` folder. This includes the Quarto document where the paper was written, a reference bibliography file, and the PDF of the final paper. 


## Statement on LLM usage

Aspects of the "Idealized Methodology" appendix were written with the help of LLMs. The full chat history can be found in the `plan/llm_usage` directory.
