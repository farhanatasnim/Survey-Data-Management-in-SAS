# Survey-Data-Management-in-SAS

# EPI 600: Final Project - Survey Data Management in SAS

## Project Overview

This repository contains the final project for EPI 600, demonstrating data management and cleaning tasks using SAS. The primary goal of this project was to take raw, separate survey data files, process them, and create a single, clean, analysis-ready dataset.

The SAS script (`Final_Project.sas`) handles all steps of this process, including importing data from multiple formats, merging datasets, recoding variables, handling missing values, and creating new composite variables and data quality flags.

## Key Tasks Performed

The main SAS script performs the following data management operations:

* **Data Import:** Imports data from four different source files:

  * `quiz_recode.sas7bdat`

  * `quiz_survey_3_p1.csv`

  * `quiz_survey_3_p2.xlsx`

  * `quiz_survey_3_p3.xlsx`

* **Data Merging:** Sorts all datasets by the `id` variable and merges them into one comprehensive dataset (`epiquiz.final_data`).

* **Variable Recoding:** Cleans and recodes numerous raw survey variables (`q...`) into new, clearly-named variables (e.g., `edu_male`, `smoke_tobac`, `alcohol`).

* **Missing Data Handling:** Appropriately recodes non-numeric responses (like "don't know" or "not applicable," often coded as 8, 9, or 9999) into standard SAS missing values (`.`).

* **Composite Variable Creation:** Creates new variables based on the logic of one or more existing variables (e.g., `par_college`, `age_grp`, `gpa_pass`, `heavy_drink`, `hr_drink`).

* **Data Quality Checks:** Generates a set of "discrepancy" variables (`dis_alcohol`, `dis_tobacco`, `dis_sexual`, `dis_sum`) to identify and flag participants with inconsistent or unreasonable responses.

* **Final Output:** Saves the final, clean dataset as `epiquiz.final_recode.sas7bdat`.

## Repository Contents

* **`Final_Project.sas`**: The main SAS script containing all `PROC IMPORT`, `PROC SORT`, `DATA` steps, and `PROC FREQ` checks used to clean and process the data.

* **`final_recode.sas7bdat`**: The final, clean, and merged SAS dataset. This is the primary output of the project.

* **`Final_Project_logfile.log`**: The complete SAS log file generated from running `Final_Project.sas`.

* **`Final_Project_Output_600.mht`**: The HTML output file from SAS. It contains the results of `PROC CONTENTS` (to show the structure of the new dataset) and `PROC FREQ` (to verify the recoding and new variable creation).

## How to Use

To replicate this project, you would need:

1. Access to SAS 9.4 or a compatible version.

2. The four original source data files (which are not included in this repository).

3. To update the `libname` and all `datafile=` file paths in `Final_Project.sas` to point to the correct locations of the source files on your local machine.
