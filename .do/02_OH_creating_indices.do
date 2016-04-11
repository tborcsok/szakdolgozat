*szakdolgozat
*panel 2008-2010, 2009-2011, 2010-2012
*hozz�adott �rt�k alapj�n iskolamin�s�g

log using "C:\Users\Tomi\Google Drive\ELTE\SZAKDOLGOZAT\stata\OH adatokkal\01_creating_indices.txt", replace

//alapbe�ll�t�sok
clear
clear matrix
clear mata
set more off
set varabbrev off
set matsize 11000
set maxvar 32767
*set segmentsize 128m


//makr�k defini�l�sa
global outtype "as(eps)"  //change bw png and eps

global szdOHout "E:/szakdoga_data_out/OHt�l/"
global szdOHinERTEKELESI "E:/szakdoga_data_out/OHt�l/ertekelesi_"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

local waves "2008-2010 2009-2011 2010-2012 2011-2013 2012-2014" // kiv�ve  
local waves2 "2009-2011 2010-2012 2011-2013 2012-2014" // kiv�ve  


local regressants "csh_index i.nem i.ta02801"  //ta02801 - apa iskolai v�gzetts�ge; i.isknagy; megye dummynak nem volt �rtelme; rv_hhh; i.ta02801; 
local rereg ", re"
local fereg ", fe"

local 1keep keep(o_zpsc_lag csh_index)
local 2keep keep(csh_index)

global dropnum 30

foreach w of local waves {
use ${szdOHinERTEKELESI}`w', clear
*use ${szdOHinERTEKELESI}2008-2010, clear

//panel strukt�ra
*xtset omid

*sort telephely omid
*egen newid = group(omid telephely), label

//azonos�t� v�ltoz�k
gen str wave = " "
replace wave = "`w'"

gen ev_start = substr(wave, 1, 4)
gen ev_end = substr(wave, 6, .)
destring ev_start ev_end, replace

//8. oszt�lyos eredm�nyek meghagy�sa
drop if ev != ev_end

//legkisebb iskol�k kidob�sa
sort omid
by omid: gen freq_omid = _N
sort freq_omid
by freq_omid: drop if freq_omid <=${dropnum}
drop freq_omid


/////////// Modellek /////////////////////////////////////////////

//////// az egy�ni hib�k iskolai �tlaga //////////////////////////////////////////////////////////////////////////////////////////////////////

// A) Kiigaz�tott- covariate adjustment - modell
*E1
reg o_zpsc o_zpsc_lag `regressants' i.telnagy i.fentip i.isknagy
estimates store e_1
predict E1_source, res
bysort ${iskid}: egen E1 = mean(E1_source)
*replace E1 = . if ev == ev_start
label variable E1 "E1"
outreg2 e_1 using ${stataOUT}tables/elso_`w'.tex", replace ctitle(E1) `1keep' addtext(Fuggo valtozo, szint, RE, NEM, FE, NEM) tex(fragment pretty)


// B) Fejl�d�s - gain - modell
*E2
regress o_zpsc_diff `regressants' i.telnagy i.fentip i.isknagy
estimates store e_2
predict E2_source, res
bysort ${iskid}: egen E2 = mean(E2_source)
*replace E2 = . if ev == ev_start
label variable E2 "E2"
outreg2 e_2 using ${stataOUT}tables/elso_`w'.tex", append ctitle(E2) `2keep' addtext(Fuggo valtozo, valtozas, RE, NEM, FE, NEM) tex(fragment pretty)
drop E2_source


drop E1_source 


//////// Random Effects modellek ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*itt az egy�ni teljes�tm�ny random effect
*az iskola pedig dummy -> ez alapj�n saj�t tengelymetszete van az egyes iskol�knak
	*ez a M�ko for STATA k�nyv alapj�n

xtset ${iskid}
// A) Kiigaz�tott- covariate adjustment - modell
*I1
xtreg o_zpsc o_zpsc_lag `regressants' i.telnagy i.fentip i.isknagy, re cluster(omid)
estimates store i_1
predict I1, u
label variable I1 "I1"
outreg2 i_1_temp using ${stataOUT}tables/elso_`w'.tex", append ctitle(I1) `1keep' addtext(Fuggo valtozo, szint, RE, IGEN, FE, NEM) tex(fragment pretty)


xtset ${iskid}
// B) Fejl�d�s - gain - modell
*I2
xtreg o_zpsc_diff `regressants' i.telnagy i.fentip i.isknagy, re cluster(omid)
estimates store i_2
predict I2, u
label variable I2 "I2"
outreg2 i_2_temp using ${stataOUT}tables/elso_`w'.tex", append ctitle(I2) `2keep' addtext(Fuggo valtozo, valtozas, RE, IGEN, FE, NEM) tex(fragment pretty)


//////// Fixed Effects modellek //////////////////////////////////////////////////////////////////////////////////////////////////////////////

xtset ${iskid}
// A) Kiigaz�tott- covariate adjustment - modell
*F1
xtreg o_zpsc o_zpsc_lag `regressants' , fe cluster(omid)
estimates store f_1
predict F1, u
label variable F1 "F1"
outreg2 f_1 using ${stataOUT}tables/elso_`w'.tex", append ctitle(F1) `1keep' addtext(Fuggo valtozo, szint, RE, NEM, FE, IGEN) tex(fragment pretty)



xtset ${iskid}
// B) Fejl�d�s - gain - modell
*F2
xtreg o_zpsc_diff `regressants' , fe cluster(omid)
estimates store f_2
predict F2, u
label variable F2 "F2"
outreg2 f_2 using ${stataOUT}tables/elso_`w'.tex", append ctitle(F2) `2keep' addtext(Fuggo valtozo, valtozas, RE, NEM, FE, IGEN) tex(fragment pretty)


//outreg2
*csin�lni egy kompakt, �sszefogal� v�ltozatot a f�sz�vegbe
*csin�lni egy r�szleteset az appendixbe.

*save ${szdOHout}ertekelesi_`w'.dta, replace
*estimates save ${szdOHout}01_est_save_`w'.ster, replace

drop if I1 == . //ezen cs�szott el a sz�m�t�s sok�ig ...
duplicates drop ${iskid}, force

quietly graph matrix E1 E2 I1 I2 F1 F2, title(`w')
graph export ${stataOUT}images/indices_matrixgraph_`w'.png", as(png) replace

keep ${iskid} ev E1 E2 I1 I2 F1 F2
save ${szdOHout}indices_`w', replace

}
*

log close



/*
// pooled 




use ${szdOHinERTEKELESI}2008-2010, clear
append using ${szdOHinERTEKELESI}2009-2011, force
append using ${szdOHinERTEKELESI}2010-2012, force
append using ${szdOHinERTEKELESI}2011-2013, force
append using ${szdOHinERTEKELESI}2012-2014, force

//panel strukt�ra
*xtset omid

*sort telephely omid
*egen newid = group(omid telephely), label

//azonos�t� v�ltoz�k



//8. oszt�lyos eredm�nyek meghagy�sa
drop if evfolyam != 8

//legkisebb iskol�k kidob�sa
*sort omid
*by omid: gen freq_omid = _N
*sort freq_omid
*by freq_omid: drop if freq_omid <=15
*drop freq_omid


/////////// Modellek /////////////////////////////////////////////

//////// az egy�ni hib�k iskolai �tlaga //////////////////////////////////////////////////////////////////////////////////////////////////////

// A) Kiigaz�tott- covariate adjustment - modell
*E1
quietly reg o_zpsc o_zpsc_lag `regressants' i.telnagy i.fentip i.isknagy
estimates store e_1
predict E1_source, res
bysort ${iskid}: egen E1 = mean(E1_source)
*replace E1 = . if ev == ev_start
label variable E1 "E1"
outreg2 e_1 using ${stataOUT}tables/elso_pooled.tex", replace ctitle(E1) `1keep' addtext(RE, NEM, FE, NEM) tex(fragment pretty)


// B) Fejl�d�s - gain - modell
*E2
quietly regress o_zpsc_diff `regressants' i.telnagy i.fentip i.isknagy
estimates store e_2
predict E2_source, res
bysort ${iskid}: egen E2 = mean(E2_source)
*replace E2 = . if ev == ev_start
label variable E2 "E2"
outreg2 e_2 using ${stataOUT}tables/elso_pooled.tex", append ctitle(E2) `2keep' addtext(RE, NEM, FE, NEM) tex(fragment pretty)
drop E2_source


drop E1_source 


//////// Random Effects modellek ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*itt az egy�ni teljes�tm�ny random effect
*az iskola pedig dummy -> ez alapj�n saj�t tengelymetszete van az egyes iskol�knak
	*ez a M�ko for STATA k�nyv alapj�n

xtset ${iskid}
// A) Kiigaz�tott- covariate adjustment - modell
*I1
quietly xtreg o_zpsc o_zpsc_lag `regressants' , re cluster(omid)
estimates store i_1
predict I1, u
label variable I1 "I1"
outreg2 i_1_temp using ${stataOUT}tables/elso_pooled.tex", append ctitle(I1) `1keep' addtext(RE, IGEN, FE, NEM) tex(fragment pretty)


xtset ${iskid}
// B) Fejl�d�s - gain - modell
*I2
quietly xtreg o_zpsc_diff `regressants' , re cluster(omid)
estimates store i_2
predict I2, u
label variable I2 "I2"
outreg2 i_2_temp using ${stataOUT}tables/elso_pooled.tex", append ctitle(I2) `2keep' addtext(RE, IGEN, FE, NEM) tex(fragment pretty)


//////// Fixed Effects modellek //////////////////////////////////////////////////////////////////////////////////////////////////////////////

xtset ${iskid}
// A) Kiigaz�tott- covariate adjustment - modell
*F1
quietly xtreg o_zpsc o_zpsc_lag `regressants' , fe cluster(omid)
estimates store f_1
predict F1, u
label variable F1 "F1"
outreg2 f_1 using ${stataOUT}tables/elso_pooled.tex", append ctitle(F1) `1keep' addtext(RE, NEM, FE, IGEN) tex(fragment pretty)



xtset ${iskid}
// B) Fejl�d�s - gain - modell
*F2
quietly xtreg o_zpsc_diff `regressants' , fe cluster(omid)
estimates store f_2
predict F2, u
label variable F2 "F2"
outreg2 f_2 using ${stataOUT}tables/elso_pooled.tex", append ctitle(F2) `2keep' addtext(RE, NEM, FE, IGEN) tex(fragment pretty)


//outreg2
*csin�lni egy kompakt, �sszefogal� v�ltozatot a f�sz�vegbe
*csin�lni egy r�szleteset az appendixbe.

*save ${szdOHout}ertekelesi_`w'.dta, replace
*estimates save ${szdOHout}01_est_save_`w'.ster, replace


duplicates drop ${iskid}, force
quietly graph matrix E1 E2 I1 I2 F1, title(pooled)
graph export ${stataOUT}images/indices_matrixgraph_pooled.png", as(png) replace
keep omid telephely ${iskid} ev E1 E2 I1 I2 F1 F2
save ${szdOHout}indices_pooled, replace
*/


