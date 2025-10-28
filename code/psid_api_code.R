rm(list = ls())
library(psidR)
library(data.table)

# # First, install devtools if needed
# install.packages("devtools")
# # Then install psidR from GitHub
# devtools::install_github("floswald/psidR")

# 1. Set your data directory
psid_dir <- "C:/Users/wrgar/OneDrive - UW/01Study/20254Fall/CSSS560HierarchicalModeling/ProblemSets/project/data/PSID_API/"

# # # convert dta → rda for all relevant files
# files <- list.files(psid_dir, pattern = "\\.dta$", full.names = TRUE)
# 
# for (f in files) {
#   # read Stata file
#   dat <- read_dta(f)
# 
#   # build object name from file (e.g., IND2023ER)
#   obj_name <- tools::file_path_sans_ext(basename(f))
# 
#   # assign that name to the data in global env
#   setnames(dat, toupper(names(dat)))
#   assign(obj_name, dat)
# 
#   # save properly as .rda (with save(), not saveRDS)
#   save(list = obj_name,
#        file = file.path(psid_dir, paste0(obj_name, ".rda")),
#        version = 2)
# }


list.files(psid_dir, pattern = "\\.rda$")

# 2. Build the PSID database index

# Build only for 2023
build.panel(
  datadir = psid_dir,
  fam.vars = data.frame(
    year = 2023,
    vars = I(list(c("ER76001")))  # family ID in FAM2023ER
  )
)
















# r = system.file(package="psidR")
# f = fread(file.path(r,"psid-lists","famvars.txt"))
# i = fread(file.path(r,"psid-lists","indvars.txt"))
# 
# i = dcast(i[,list(year,name,variable)],year~name, value.var = "variable")
# f = dcast(f[,list(year,name,variable)],year~name, value.var = "variable")

#d = build.panel(datadir=datadr,fam.vars=f,ind.vars=i, heads.only = TRUE,sample="SRC",design="all")
