
set more off

use "E:\szakdoga_data_out\OHtól\final_elemzesi_pooled.dta", clear


drop if sum10_E1_lag ==.
keep if evfolyam == 10
duplicates drop omid, force

rename sum10_E1_lag E1 
rename sum10_E2_lag E2 
rename sum10_I1_lag I1
rename sum10_I2_lag I2
rename sum10_F1_lag F1
rename sum10_F2_lag F2

log using "C:\Users\Tomi\Google Drive\ELTE\SZAKDOLGOZAT\BT_Szakdolgozat\from_stata\tables\crosstabs.txt", replace text

local vars "E1 E2 I1 I2 F1 F2"




foreach var1 of local vars {
foreach var2 of local vars {

tab `var1' `var2'

}
}
*

log close

cd "C:\Users\Tomi\Google Drive\ELTE\SZAKDOLGOZAT\BT_Szakdolgozat\from_stata\tables\"

translate crosstabs.txt crosstabs.pdf, replace


