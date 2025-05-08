# CodeBook
This document is the codebook for the "Getting and Cleaning Data" course project. 
It describes the variables, data, and any transformations carried out to clean up the data. 

## Accessing the Data  
- Download the source data here: https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones  

## Run_Analysis.R (the R Script)
The R script "Run_Analysis.R" performs the following steps:  
0) Loading the Data  
1) Merge the Training and Test Sets to Create 1 Data Set  
2) Extracts Only the Measurements on the Mean and Standard Deviation for Each Measurement  
3) Uses Descriptive Activity Names to Name the Activities in the Data Set  
4) Appropriately Labels the Data Set with Descriptive Variable Names  
5) From the Data Set in Step 4, Creates a Second, Independent Tidy Data Set with the Average of Each Variable for Each Activity and Subject  
6) Upload Data Set as a Text File  