rm(list=ls()) 

## This project models the relationship between hypertension and income
# in the US using the PSID dataset.

#libraries
library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)
library(haven)

wd <- "C:/Users/wrgar/OneDrive - UW/01Study/20254Fall/CSSS560HierarchicalModeling/CSSS560Hierarchical/"

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
# Load PSID individual data ----

#ind1968_2023   <- as.data.table(read_dta(paste0(wd_data,"PSID/","IND2023ER.dta")))

load(paste0(wd_data,"IND2023ER.rda"))

# Copy to a data table
IND2023ER <- as.data.table(IND2023ER)

# 2. Define shared (cross-year) identifiers
cross_year_vars <- c("ER30001", "ER30002", "ER30003", "ER32000", "ER32050")

# 3. Define 2021-specific variables
vars_2021 <- c(
  "ER34901", "ER34902", "ER34903",   # Interview sequence 2021
  "ER34904", "ER34935",              # Demographics 2021
  "ER35064", "ER35065"               # Weights 2021
)

# 4. Define 2023-specific variables
vars_2023 <- c(
  "ER35101", "ER35102", "ER35103",   # Interview sequence 2023
  "ER35104", "ER35135",              # Demographics 2023
  "ER35264", "ER35265"               # Weights 2023
)

# 5. Create 2021 and 2023 column sets
cols_2021 <- c(cross_year_vars, vars_2021)
cols_2023 <- c(cross_year_vars, vars_2023)

# 6. Subset and create data.tables
ind2021_sel <- IND2023ER[, ..cols_2021]
ind2023_sel <- IND2023ER[, ..cols_2023]

# 7. Add a year variable to each
ind2021_sel[, YEAR := 2021L]
ind2023_sel[, YEAR := 2023L]


# Load family data ----

load(paste0(wd_data,"FAM2023ER.rda"))
#fam2023 <- as.data.table(read_dta(paste0(wd_data,"PSID/","FAM2023ER.dta")))

# copy to a data table
FAM2023ER <- as.data.table(FAM2023ER)

# Select relevant variables
fam2023_sel <- FAM2023ER[, .(
  ER82001, ER82002, ER82003, ER82004, ER82005,  # release & geography
  ER84572, ER84574, ER84575, ER84576,           # Hypertension - RP
  ER84773, ER84775, ER84776, ER84777            # Hypertension - Spouse
)]

# Merge family data with individual data

psid <- merge(ind2023_sel, fam2023_sel,
               by.x = "ER35101", by.y = "ER82001",
               all.x = TRUE)







fam2021 <- as.data.table(read_dta(paste0(wd_data,"PSID/","FAM2021ER.dta")))



