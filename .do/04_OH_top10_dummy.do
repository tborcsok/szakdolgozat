*szakdolgozat
*panel 2008-2010, 2009-2011, 2010-2012
*5 évben végig top10 iskola dummy megalkotása
*alternatively: 5 éves átlag iskolaminöség

//alapbeállítások
clear
clear matrix
clear mata
set more off
set varabbrev off
set matsize 11000
set maxvar 32767
*set segmentsize 128m


//makrók definiálása
global outtype "as(eps)"  //change bw png and eps

global szdOHout "E:/szakdoga_data_out/OHtól/"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

local waves "2008-2010 2009-2011 2010-2012 2011-2013 2012-2014" //

local vars1 "E1 E2 I1 I2 F1 F2"
*local vars2 "I1 I2 F1 F2"
local years "2010 2011 2012 2013 2014"


//adatok betöltése

use ${szdOHout}indices_2008-2010_appended, clear
append using ${szdOHout}indices_2009-2011_appended, force
append using ${szdOHout}indices_2010-2012_appended, force
append using ${szdOHout}indices_2011-2013_appended, force
append using ${szdOHout}indices_2012-2014_appended, force

*egen newtelhid = group(omid telephely), label
*label variable newtelhid "Az egyes iskola-telephely kombinációk egyértelmü azonosítója"

xtset ${iskid} ev

//balanced panel
bys ${iskid}: gen enc1 = [_n]
bys ${iskid}: egen enc2 = max(enc1)
keep if enc2 == 5
drop enc1 enc2


// E I F indexek

foreach Y of local vars1 {
bysort ${iskid}: egen sum${topszpc}_`Y' = total(top${topszpc}_`Y')
replace sum${topszpc}_`Y' = . if `Y' == .
label variable sum${topszpc}_`Y' "Hány évben top ${topszpc}% az iskola az `Y' index szerint?"
}
*

duplicates drop ${iskid}, force
keep ${iskid} sum${topszpc}_E1 sum${topszpc}_E2 sum${topszpc}_I1 sum${topszpc}_I2 sum${topszpc}_F1 sum${topszpc}_F2

 
foreach Y of local vars1 {
gen `Y'_1of5_${topszpc}pc = (sum${topszpc}_`Y'>=1)
label variable `Y'_1of5_${topszpc}pc "Az öt évböl leglább 1-szer van benne a top${topszpc}%-ban"
gen `Y'_2of5_${topszpc}pc = (sum${topszpc}_`Y'>=2)
label variable `Y'_2of5_${topszpc}pc "Az öt évböl leglább 2-szer van benne a top${topszpc}%-ban"
gen `Y'_3of5_${topszpc}pc = (sum${topszpc}_`Y'>=3)
label variable `Y'_3of5_${topszpc}pc "Az öt évböl leglább 3-szor van benne a top${topszpc}%-ban"
gen `Y'_4of5_${topszpc}pc = (sum${topszpc}_`Y'>=4)
label variable `Y'_4of5_${topszpc}pc "Az öt évböl leglább 4-szer van benne a top${topszpc}%-ban"
gen `Y'_5of5_${topszpc}pc = (sum${topszpc}_`Y'==5)
label variable `Y'_5of5_${topszpc}pc "Az öt évböl 5-ször van benne a top${topszpc}%-ban"
*drop sum${topsz}_`Y'
}
*

foreach Y of local vars1 {
gen `Y'_1of5_${topszpc}pc_eq = (sum${topszpc}_`Y'==1)
label variable `Y'_1of5_${topszpc}pc_eq "Az öt évböl 1-szer van benne a top${topszpc}%-ban"
gen `Y'_2of5_${topszpc}pc_eq = (sum${topszpc}_`Y'==2)
label variable `Y'_2of5_${topszpc}pc_eq "Az öt évböl 2-szer van benne a top${topszpc}%-ban"
gen `Y'_3of5_${topszpc}pc_eq = (sum${topszpc}_`Y'==3)
label variable `Y'_3of5_${topszpc}pc_eq "Az öt évböl 3-ször van benne a top${topszpc}%-ban"
gen `Y'_4of5_${topszpc}pc_eq = (sum${topszpc}_`Y'==4)
label variable `Y'_4of5_${topszpc}pc_eq "Az öt évböl 4-szer van benne a top${topszpc}%-ban"
gen `Y'_5of5_${topszpc}pc_eq = (sum${topszpc}_`Y'==5)
label variable `Y'_5of5_${topszpc}pc_eq "Az öt évböl 5-ször van benne a top${topszpc}%-ban"
*drop sum${topsz}_`Y'
}
*

sort ${iskid}

save ${szdOHout}04_E_I_F_dummys, replace


