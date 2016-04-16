*szakdolgozat
*FINAL COUNTDOWN
*elemzési idöszak
*note: igazából a preserve restore nem kell, ugyanazt becsülné



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
global szdOHinSMALL "E:/szakdoga_data_out/OHtól/alap/small_"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

local years "2008 2009 2010 2011 2012 2013 2014"
local evfolyam "6 8 10"
local waves "2010-2012 2011-2013 2012-2014 " 

local values "1 2 3 4 5" //1 2 3 
local valtozok2 "I1 F1 E2 I2 F2"
local refe "fe re" //re

*local sort "o_zpsc_8 csh_index 1.sum10 2.sum10 3.sum10 4.sum10 5.sum10 1.sum10#c.csh_index 2.sum10#c.csh_index 3.sum10#c.csh_index 4.sum10#c.csh_index 5.sum10#c.csh_index"
local sortt "o_zpsc_8 csh_index sum10_1of5 1.sum10_1of5#c.csh_index sum10_2of5 1.sum10_2of5#c.csh_index sum10_3of5 1.sum10_3of5#c.csh_index sum10_4of5 1.sum10_4of5#c.csh_index sum10_5of5 1.sum10_5of5#c.csh_index"
local dropp "0b.sum10#co.csh_index 0b.sum10_1of5#co.csh_index 0b.sum10_2of5#co.csh_index 0b.sum10_3of5#co.csh_index 0b.sum10_4of5#co.csh_index 0b.sum10_5of5#co.csh_index o.sum10_5of5 0o.sum10_5of5#co.csh_index o.sum10_4of5 0o.sum10_4of5#co.csh_index"

global dropnum 30

foreach w of local waves {

*log using "C:\Users\Tomi\Google Drive\ELTE\SZAKDOLGOZAT\stata\OH adatokkal\02_analysis_`w'.txt", replace

use ${szdOHout}elemzesi_`w', clear
*use ${szdOHout}elemzesi_pooled, clear

sort ${iskid}
merge ${iskid} using ${szdOHout}04_I_F_dummys

rename _merge _merge2

sort ${iskid}
merge ${iskid} using ${szdOHout}04_E_dummys

xtset azon ev

//két idöszakos modellekhez
gen o_zpsc_8 = L2.o_zpsc if evfolyam == 10
gen o_zpsc_10 = o_zpsc if evfolyam == 10

gen m_zpsc_8 = L2.m_zpsc if evfolyam == 10
gen m_zpsc_10 = m_zpsc if evfolyam == 10

gen o_zpsc_D_8_10 = o_zpsc - L2.o_zpsc if evfolyam == 10
gen m_zpsc_D_8_10 = m_zpsc - L2.m_zpsc if evfolyam == 10

gen csh_index_8 = L2.csh_index if evfolyam == 10

gen omid10 = omid if evfolyam == 10
gen omid8 = omid if evfolyam == 8

encode wave, gen(xy)
drop wave
rename xy wave



*local lagged "I1_1of5_${topszpc}pc I1_2of5_${topszpc}pc I1_3of5_${topszpc}pc I1_4of5_${topszpc}pc I1_5of5_${topszpc}pc F1_1of5_${topszpc}pc F1_2of5_${topszpc}pc F1_3of5_${topszpc}pc F1_4of5_${topszpc}pc F1_5of5_${topszpc}pc E1_1of5_${topszpc}pc E1_2of5_${topszpc}pc E1_3of5_${topszpc}pc E1_4of5_${topszpc}pc E1_5of5_${topszpc}pc  sum${topszpc}_E1  sum${topszpc}_I1  sum${topszpc}_F1"
*local lagged2 "I2_1of5_${topszpc}pc I2_2of5_${topszpc}pc I2_3of5_${topszpc}pc I2_4of5_${topszpc}pc I2_5of5_${topszpc}pc F2_1of5_${topszpc}pc F2_2of5_${topszpc}pc F2_3of5_${topszpc}pc F2_4of5_${topszpc}pc F2_5of5_${topszpc}pc E2_1of5_${topszpc}pc E2_2of5_${topszpc}pc E2_3of5_${topszpc}pc E2_4of5_${topszpc}pc E2_5of5_${topszpc}pc  sum${topszpc}_E2  sum${topszpc}_I2  sum${topszpc}_F2"

local lagged "sum${topszpc}_E1 sum${topszpc}_E2 sum${topszpc}_I1 sum${topszpc}_I2 sum${topszpc}_F1 sum${topszpc}_F2"

foreach l of local lagged {
	gen `l'_lag = .
	replace `l'_lag = L2.`l' if evfolyam == 10
	drop `l'
}
*

rename ta02801 apa_isk

keep if evfolyam == 10

*egen placeholder = std(csh_index)
*replace csh_index = placeholder
*drop placeholder
label variable csh_index "A tanuló standardizált családiháttér-indexe"


//legkisebb iskolák kidobása
*sort omid10
*by omid10: gen freq_omid10 = _N
*sort freq_omid10
*by freq_omid10: drop if freq_omid10 <=15
*drop freq_omid10



xtset omid10


//		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`v'of5_`ref'.tex", replace ctitle(E1) addtext(Depvar, szint, Panel, `ref') tex(fragment pretty)
//		xtreg o_zpsc_10 o_zpsc_8 i.sum10_F1 csh_index i.sum10_F1#c.csh_index, re cluster(omid10)



foreach ref of local refe {
	
	//szint
	preserve
	drop if sum10_E1_lag == .
	sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
	gen sum10 = (sum10_E1_lag >= 4) if sum10_E1_lag != .
	xtreg o_zpsc_10 o_zpsc_8 sum10 csh_index  sum10#c.csh_index i.nem, `ref' cluster(omid10)
	outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_szint_8.tex", replace ctitle(E1) sortvar(`sortt') drop(`dropp') addtext(Depvar, szint, Panel, `ref', Wave, `w') tex(fragment pretty)
	*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
	restore

	foreach v of local valtozok2 {
		preserve
		drop if sum10_`v'_lag == .
		sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
		gen sum10 = (sum10_`v'_lag >= 4) if sum10_`v'_lag != .
		xtreg o_zpsc_10 o_zpsc_8 sum10 csh_index  sum10#c.csh_index i.nem, `ref' cluster(omid10)
		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_szint_8.tex", append ctitle(`v') sortvar(`sortt') drop(`dropp') addtext(Depvar, szint, Panel, `ref', Wave, `w') tex(fragment pretty)
		*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
		restore
	}
	

	//változás
	preserve
	drop if sum10_E1_lag == .
	sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
	gen sum10 = (sum10_E1_lag >= 4) if sum10_E1_lag != .
	xtreg o_zpsc_D_8_10 sum10 csh_index  sum10#c.csh_index i.nem, `ref' cluster(omid10)
	outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_valtozas_8.tex", replace ctitle(E1) sortvar(`sortt') drop(`dropp') addtext(Depvar, valtozas, Panel, `ref', Wave, `w') tex(fragment pretty)
	*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
	restore
	
	foreach v of local valtozok2 {
		preserve
		drop if sum10_`v'_lag == .
		sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
		gen sum10 = (sum10_`v'_lag >= 4) if sum10_`v'_lag != .
		xtreg o_zpsc_D_8_10 sum10 csh_index  sum10#c.csh_index i.nem, `ref' cluster(omid10)		
		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_valtozas_8.tex", append ctitle(`v') sortvar(`sortt') drop(`dropp') addtext(Depvar, valtozas, Panel, `ref', Wave, `w') tex(fragment pretty)
		*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
		restore
	}
	
}



*
save ${szdOHout}final_elemzesi_`w', replace

*log close

}
*




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
local waves2 "pooled"

foreach w of local waves2 {

*log using "C:\Users\Tomi\Google Drive\ELTE\SZAKDOLGOZAT\stata\OH adatokkal\02_analysis_`w'.txt", replace

use ${szdOHout}elemzesi_`w', clear
*use ${szdOHout}elemzesi_pooled, clear

sort ${iskid}
merge ${iskid} using ${szdOHout}04_E_I_F_dummys

*rename _merge _merge2

*sort ${iskid}
*merge ${iskid} using ${szdOHout}04_E_dummys

xtset azon ev


//két idöszakos modellekhez
gen o_zpsc_8 = L2.o_zpsc -1500 if evfolyam == 10
gen o_zpsc_10 = o_zpsc if evfolyam == 10

gen m_zpsc_8 = L2.m_zpsc if evfolyam == 10
gen m_zpsc_10 = m_zpsc if evfolyam == 10

gen o_zpsc_D_8_10 = o_zpsc - L2.o_zpsc if evfolyam == 10
gen m_zpsc_D_8_10 = m_zpsc - L2.m_zpsc if evfolyam == 10

gen csh_index_8 = L2.csh_index if evfolyam == 10

gen omid10 = omid if evfolyam == 10
gen omid8 = omid if evfolyam == 8

encode wave, gen(xy)
drop wave
rename xy wave




*local lagged "I1_1of5_${topszpc}pc I1_2of5_${topszpc}pc I1_3of5_${topszpc}pc I1_4of5_${topszpc}pc I1_5of5_${topszpc}pc F1_1of5_${topszpc}pc F1_2of5_${topszpc}pc F1_3of5_${topszpc}pc F1_4of5_${topszpc}pc F1_5of5_${topszpc}pc E1_1of5_${topszpc}pc E1_2of5_${topszpc}pc E1_3of5_${topszpc}pc E1_4of5_${topszpc}pc E1_5of5_${topszpc}pc  sum${topszpc}_E1  sum${topszpc}_I1  sum${topszpc}_F1"
*local lagged2 "I2_1of5_${topszpc}pc I2_2of5_${topszpc}pc I2_3of5_${topszpc}pc I2_4of5_${topszpc}pc I2_5of5_${topszpc}pc F2_1of5_${topszpc}pc F2_2of5_${topszpc}pc F2_3of5_${topszpc}pc F2_4of5_${topszpc}pc F2_5of5_${topszpc}pc E2_1of5_${topszpc}pc E2_2of5_${topszpc}pc E2_3of5_${topszpc}pc E2_4of5_${topszpc}pc E2_5of5_${topszpc}pc  sum${topszpc}_E2  sum${topszpc}_I2  sum${topszpc}_F2"

local lagged "sum10_E1 sum10_E2 sum10_I1 sum10_I2 sum10_F1 sum10_F2"

foreach l of local lagged {
	gen `l'_lag = .
	replace `l'_lag = L2.`l' if evfolyam == 10
	drop `l'
}
*

rename ta02801 apa_isk

keep if evfolyam == 10

*egen placeholder = std(csh_index)
*replace csh_index = placeholder
*drop placeholder
label variable csh_index "A tanuló standardizált családiháttér-indexe"

//legkisebb iskolák kidobása
*sort omid10
*by omid10: gen freq_omid10 = _N
*sort freq_omid10
*by freq_omid10: drop if freq_omid10 <=15
*drop freq_omid10

xtset omid10


//		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`v'of5_`ref'.tex", replace ctitle(E1) addtext(Depvar, szint, Panel, `ref') tex(fragment pretty)
//		xtreg o_zpsc_10 o_zpsc_8 i.sum10_F1 csh_index i.sum10_F1#c.csh_index, re cluster(omid10)

foreach ref of local refe {
	
	//szint
	preserve
	drop if sum10_E1_lag == .
	sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
	gen sum10 = (sum10_E1_lag >= 4) if sum10_E1_lag != .
	xtreg o_zpsc_10 o_zpsc_8 sum10 csh_index  sum10#c.csh_index i.nem i.wave, `ref' cluster(omid10)
	outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_szint_8.tex", replace ctitle(E1) sortvar(`sortt') drop(`dropp') addtext(Depvar, szint, Panel, `ref', Wave, `w') tex(fragment pretty)
	*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
	restore
	
	foreach v of local valtozok2 {
		preserve
		drop if sum10_`v'_lag == .
		sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
		gen sum10 = (sum10_`v'_lag >= 4) if sum10_`v'_lag != .
		xtreg o_zpsc_10 o_zpsc_8 sum10 csh_index  sum10#c.csh_index i.nem i.wave, `ref' cluster(omid10)
		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_szint_8.tex", append ctitle(`v') sortvar(`sortt') drop(`dropp') addtext(Depvar, szint, Panel, `ref', Wave, `w') tex(fragment pretty)
		*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
		restore
	}
	
	//változás
	preserve
	drop if sum10_E1_lag == .
	sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
		gen sum10 = (sum10_E1_lag >= 4) if sum10_E1_lag != .
		xtreg o_zpsc_D_8_10 sum10 csh_index  sum10#c.csh_index i.nem i.wave, `ref' cluster(omid10)	
		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_valtozas_8.tex", replace ctitle(E1) sortvar(`sortt') drop(`dropp') addtext(Depvar, valtozas, Panel, `ref', Wave, `w') tex(fragment pretty)
	*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
	restore
	
	foreach v of local valtozok2 {
		preserve
		drop if sum10_`v'_lag == .
		sort omid10
by omid10: gen freq_omid10 = _N
sort freq_omid10
by freq_omid10: drop if freq_omid10 <=${dropnum}
drop freq_omid10
		gen sum10 = (sum10_`v'_lag >= 4) if sum10_`v'_lag != .
		xtreg o_zpsc_D_8_10 sum10 csh_index  sum10#c.csh_index i.nem i.wave, `ref' cluster(omid10)	
		outreg2 using ${stataOUT}tables/eredmenyek_`w'_`ref'_valtozas_8.tex", append ctitle(`v') sortvar(`sortt') drop(`dropp') addtext(Depvar, valtozas, Panel, `ref', Wave, `w') tex(fragment pretty)
		*drop sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5
		restore
	}
}



*
save ${szdOHout}final_elemzesi_`w', replace

*log close


}
*


cd "C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/stata/OH adatokkal"

run 07_outreg2_fordítás.do
