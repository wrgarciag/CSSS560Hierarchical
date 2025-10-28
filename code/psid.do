* Starting the log file
log using "C:\Users\wrgar\OneDrive - UW\01Study\20254Fall\CSSS560HierarchicalModeling\ProblemSets\project\psid.txt", text replace

clear all
cls

cd "C:\Users\wrgar\OneDrive - UW\01Study\20254Fall\CSSS560HierarchicalModeling\ProblemSets\project"

global psid "C:\Users\wrgar\OneDrive - UW\01Study\20254Fall\CSSS560HierarchicalModeling\ProblemSets\project\data\PSID"

global psid2023 "$psid\2023"

global psid2021 "$psid\2021"

global psid2019 "$psid\2019"

************************************************************
* PSID 2023
************************************************************

* Run FAM2023ER
do "$psid2023\FAM2023ER.do"
* Labels file
do "$psid2023\FAM2023ER_formats.do"

/*
* Label overview
describe ER84572 ER84574 ER84575 ER84576 ER84773 ER84775 ER84776 ER84777

* Summarize each variable (numeric)
summarize ER84572 ER84574 ER84575 ER84576 ER84773 ER84775 ER84776 ER84777

* Tabulate binary indicators (0/1 or Yes/No)
foreach var in ER84572 ER84575 ER84576 ER84773 ER84776 ER84777 {
    di "------------------------------------------------------"
    di "Tabulation for `var' - `: variable label `var''"
    tab `var'
}

* Summarize age at first hypertension (continuous variables)
summarize ER84574 ER84775, detail

* Quick summary table side by side
tabstat ER84572 ER84773, by(ER84572) stats(mean sd n)
*/

save "$psid\FAM2023ER.dta",replace


* Run IND2023ER

do "$psid2023\IND2023ER.do"
do "$psid2023\IND2023ER_formats.do"

save "$psid\IND2023ER.dta",replace


************************************************************
* PSID 2021
************************************************************

* Run FAM2021ER
do "$psid2021\FAM2021ER.do"
* Labels file
do "$psid2021\FAM2021ER_formats.do"

save "$psid\FAM2021ER.dta",replace


log close