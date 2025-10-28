rm(list=ls()) 

## This project models the relationship between hypertension and income
# in the US using the PSID dataset.

#libraries
library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)
library(haven)

wd <- "C:/Users/wrgar/OneDrive - UW/01Study/20254Fall/CSSS560HierarchicalModeling/ProblemSets/project/"

wd_code <- paste0(wd,"code/")

# Raw data not available on GitHub
#wd_raw <- paste0("C:/Users/wrgar/OneDrive - UW/04Dissertation/Data/PSID/")

# Processed data (from base rates and tps)
wd_data <- paste0(wd,"data/")
# Output directory
wd_outp <- paste0(wd,"output/")

# Working directory
setwd(wd)

#...........................................................
# 1. PSID Data-----
#...........................................................
# Load PSID data

ind1968_2023   <- as.data.table(read_dta(paste0(wd_data,"PSID/","IND2023ER.dta")))

cols_2023 <- c("ER30001", "ER30002","ER30003", #interview sequence
               "ER34901","ER34902","ER34903", #interview sequence
               "ER32000","ER32050", # Cross-year
               "ER34904","ER34935", #demographics 2021
               "ER35101","ER35102","ER35103", #interview sequence
               "ER35104","ER35135", #demographic 2023
               "ER35064", "ER35065", # weighting variables 2021
               "ER35264","ER35265") # weighting variables 2023

psid <- ind1968_2023[, ..cols_2023]


fam2023 <- as.data.table(read_dta(paste0(wd_data,"PSID/","FAM2023ER.dta")))


# Select relevant variables
fam2023_sel <- fam2023[, .(
  ER82001, ER82002, ER82003, ER82004, ER82005,  # release & geography
  ER84572, ER84574, ER84575, ER84576,           # Hypertension - RP
  ER84773, ER84775, ER84776, ER84777            # Hypertension - Spouse
)]


fam2021 <- as.data.table(read_dta(paste0(wd_data,"PSID/","FAM2021ER.dta")))



