*szakdolgozat
*három panel
*értékelési idöszak

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

//adatok betöltése

// elsö hullám ///////////////////////
*2010
use ${szdOHinSMALL}2010_8, clear
save ${szdOHout}temp1, replace

*2012
use ${szdOHinSMALL}2012_10, clear

*egybe
append using ${szdOHout}temp1, force

gen wave = "2010-2012"

//tisztítás
sort azon ev
xtset azon ev

/*
*kidobni akik iskolát váltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2010
drop if isk_valtott == 1
drop isk_valtott


*balanced panel készítése
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/


label variable o_zpsc "A tanuló szövegértés pontszáma év szerint standardizálva"
label variable m_zpsc "A tanuló matematika pontszáma év szerint standardizálva"

//változógenerálás
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc
label variable o_zpsc_lag "Az elözö idöszaki szövegértés pontszám"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc
label variable o_zpsc_diff "A szövegértés pontszám változása"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az elözö idöszaki matematika pontszám"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontszám változása"

compress
label data "OKM 2010 Tanulói 8. és 2012 Tanulói 10. évfolyam"
save ${szdOHout}elemzesi_2010-2012, replace


// negyedik hullám ///////////////////////
*2011
use ${szdOHinSMALL}2011_8, clear
save ${szdOHout}temp1, replace

*2013
use ${szdOHinSMALL}2013_10, clear

*egybe
append using ${szdOHout}temp1, force

gen wave = "2011-2013"

//tisztítás
sort azon ev
xtset azon ev

/*
*kidobni akik iskolát váltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2011
drop if isk_valtott == 1
drop isk_valtott

*balanced panel készítése
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/


label variable o_zpsc "A tanuló szövegértés pontszáma év szerint standardizálva"
label variable m_zpsc "A tanuló matematika pontszáma év szerint standardizálva"

//változógenerálás
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc
label variable o_zpsc_lag "Az elözö idöszaki szövegértés pontszám"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc
label variable o_zpsc_diff "A szövegértés pontszám változása"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az elözö idöszaki matematika pontszám"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontszám változása"

compress
label data "OKM 2011 Tanulói 8. és 2013 Tanulói 10. évfolyam"
save ${szdOHout}elemzesi_2011-2013, replace

// harmadik hullám ///////////////////////
*2012
use ${szdOHinSMALL}2012_8, clear
save ${szdOHout}temp1, replace

*2014
use ${szdOHinSMALL}2014_10, clear

*egybe
append using ${szdOHout}temp1, force

gen wave = "2012-2014"

//tisztítás
sort azon ev
xtset azon ev

/*
*kidobni akik iskolát váltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2012
drop if isk_valtott == 1
drop isk_valtott


*balanced panel készítése
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/

label variable o_zpsc "A tanuló szövegértés pontszáma év szerint standardizálva"
label variable m_zpsc "A tanuló matematika pontszáma év szerint standardizálva"

//változógenerálás
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc
label variable o_zpsc_lag "Az elözö idöszaki szövegértés pontszám"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc
label variable o_zpsc_diff "A szövegértés pontszám változása"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az elözö idöszaki matematika pontszám"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontszám változása"

compress
label data "OKM 2012 Tanulói 8. és 2014 Tanulói 10. évfolyam"
save ${szdOHout}elemzesi_2012-2014, replace

// pooled készítése //////////////////////////////////////////////////////////////////////////////////////////////

use ${szdOHout}elemzesi_2010-2012, clear
append using ${szdOHout}elemzesi_2011-2013, force
append using ${szdOHout}elemzesi_2012-2014, force

label data "Pooled panel 2010-2012 2011-2013 2012-2014 8. és 10. osztályosok"
save ${szdOHout}elemzesi_pooled, replace




