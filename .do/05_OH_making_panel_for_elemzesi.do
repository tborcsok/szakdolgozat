*szakdolgozat
*h�rom panel
*�rt�kel�si id�szak

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
global szdOHinSMALL "E:/szakdoga_data_out/OHt�l/alap/small_"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

local years "2008 2009 2010 2011 2012 2013 2014"
local evfolyam "6 8 10"

//adatok bet�lt�se

// els� hull�m ///////////////////////
*2010
use ${szdOHinSMALL}2010_8, clear
save ${szdOHout}temp1, replace

*2012
use ${szdOHinSMALL}2012_10, clear

*egybe
append using ${szdOHout}temp1, force

gen wave = "2010-2012"

//tiszt�t�s
sort azon ev
xtset azon ev

/*
*kidobni akik iskol�t v�ltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2010
drop if isk_valtott == 1
drop isk_valtott


*balanced panel k�sz�t�se
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/


label variable o_zpsc "A tanul� sz�veg�rt�s pontsz�ma �v szerint standardiz�lva"
label variable m_zpsc "A tanul� matematika pontsz�ma �v szerint standardiz�lva"

//v�ltoz�gener�l�s
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc
label variable o_zpsc_lag "Az el�z� id�szaki sz�veg�rt�s pontsz�m"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc
label variable o_zpsc_diff "A sz�veg�rt�s pontsz�m v�ltoz�sa"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az el�z� id�szaki matematika pontsz�m"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontsz�m v�ltoz�sa"

compress
label data "OKM 2010 Tanul�i 8. �s 2012 Tanul�i 10. �vfolyam"
save ${szdOHout}elemzesi_2010-2012, replace


// negyedik hull�m ///////////////////////
*2011
use ${szdOHinSMALL}2011_8, clear
save ${szdOHout}temp1, replace

*2013
use ${szdOHinSMALL}2013_10, clear

*egybe
append using ${szdOHout}temp1, force

gen wave = "2011-2013"

//tiszt�t�s
sort azon ev
xtset azon ev

/*
*kidobni akik iskol�t v�ltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2011
drop if isk_valtott == 1
drop isk_valtott

*balanced panel k�sz�t�se
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/


label variable o_zpsc "A tanul� sz�veg�rt�s pontsz�ma �v szerint standardiz�lva"
label variable m_zpsc "A tanul� matematika pontsz�ma �v szerint standardiz�lva"

//v�ltoz�gener�l�s
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc
label variable o_zpsc_lag "Az el�z� id�szaki sz�veg�rt�s pontsz�m"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc
label variable o_zpsc_diff "A sz�veg�rt�s pontsz�m v�ltoz�sa"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az el�z� id�szaki matematika pontsz�m"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontsz�m v�ltoz�sa"

compress
label data "OKM 2011 Tanul�i 8. �s 2013 Tanul�i 10. �vfolyam"
save ${szdOHout}elemzesi_2011-2013, replace

// harmadik hull�m ///////////////////////
*2012
use ${szdOHinSMALL}2012_8, clear
save ${szdOHout}temp1, replace

*2014
use ${szdOHinSMALL}2014_10, clear

*egybe
append using ${szdOHout}temp1, force

gen wave = "2012-2014"

//tiszt�t�s
sort azon ev
xtset azon ev

/*
*kidobni akik iskol�t v�ltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2012
drop if isk_valtott == 1
drop isk_valtott


*balanced panel k�sz�t�se
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/

label variable o_zpsc "A tanul� sz�veg�rt�s pontsz�ma �v szerint standardiz�lva"
label variable m_zpsc "A tanul� matematika pontsz�ma �v szerint standardiz�lva"

//v�ltoz�gener�l�s
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc
label variable o_zpsc_lag "Az el�z� id�szaki sz�veg�rt�s pontsz�m"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc
label variable o_zpsc_diff "A sz�veg�rt�s pontsz�m v�ltoz�sa"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az el�z� id�szaki matematika pontsz�m"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontsz�m v�ltoz�sa"

compress
label data "OKM 2012 Tanul�i 8. �s 2014 Tanul�i 10. �vfolyam"
save ${szdOHout}elemzesi_2012-2014, replace

// pooled k�sz�t�se //////////////////////////////////////////////////////////////////////////////////////////////

use ${szdOHout}elemzesi_2010-2012, clear
append using ${szdOHout}elemzesi_2011-2013, force
append using ${szdOHout}elemzesi_2012-2014, force

label data "Pooled panel 2010-2012 2011-2013 2012-2014 8. �s 10. oszt�lyosok"
save ${szdOHout}elemzesi_pooled, replace




