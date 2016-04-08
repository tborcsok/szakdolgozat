*szakdolgozat
*adatok bet�lt�se, alap f�jlok elk�sz�t�se

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

local years 2008 2009 2010 2011 2012 2013 2014
local evfolyam 6 8 10

global szdOHout "E:/szakdoga_data_out/OHt�l/"
global szdOHin "E:/szakdoga_data_out/OHt�l/alap/"
local years "2008 2009 2010 2011 2012 2013 2014"
local evfolyam "6 8 10"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'
global szdOHinSMALL "E:/szakdoga_data_out/OHt�l/alap/small_"

global iskid "omid" //telhid, omid lehet
						//a telhid egy olyan v�ltoz�, ami az omidet �s a telephelyet kapcsolja �ssze


//////////////////////////////////////////////////////////////////////////////////////////////////////////


// els� hull�m ///////////////////////
*2008
use ${szdOHinSMALL}2008_6, clear
save ${szdOHout}temp1, replace

*2010
use ${szdOHinSMALL}2010_8, clear

*egybe
append using ${szdOHout}temp1, force

//tiszt�t�s
*tanul� �s �v szerint panel
sort azon ev
xtset azon ev

/*
*kidobni akik iskol�t v�ltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2008
drop if isk_valtott == 1
drop isk_valtott


*balanced panel k�sz�t�se
bys azon: gen enc1 = [_n] 			//szem�lyenk�nt egy sz�ml�l�
bys azon: egen enc2 = max(enc1)		//ennek a maximuma
keep if enc2 == 2					//kidobni, ha nem kett� id�pontban van megfigyel�s
drop enc1 enc2						//seg�dv�ltoz� kidob�sa
*/




//v�ltoz�gener�l�s
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc												//el�z� id�szaki gener�l�sa
label variable o_zpsc_lag "Az el�z� id�szaki sz�veg�rt�s pontsz�m"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc									//v�ltoz�s
label variable o_zpsc_diff "A sz�veg�rt�s pontsz�m v�ltoz�sa"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az el�z� id�szaki matematika pontsz�m"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontsz�m v�ltoz�sa"

compress
label data "OKM 2008 Tanul�i 6. �s 2010 Tanul�i 8. �vfolyam"
save ${szdOHout}ertekelesi_2008-2010, replace

// m�sodik hull�m ///////////////////////
*2009
use ${szdOHinSMALL}2009_6, clear
save ${szdOHout}temp1, replace

*2011
use ${szdOHinSMALL}2011_8, clear

*egybe
append using ${szdOHout}temp1, force

//tiszt�t�s
sort azon ev
xtset azon ev

/*
*kidobni akik iskol�t v�ltottak
gen isk_valtott = (${iskid}-L2.${iskid} != 0)
replace isk_valtott = 0 if ev == 2009
drop if isk_valtott == 1
drop isk_valtott


*balanced panel k�sz�t�se
bys azon: gen enc1 = [_n]
bys azon: egen enc2 = max(enc1)
keep if enc2 == 2
drop enc1 enc2
*/




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
label data "OKM 2009 Tanul�i 6. �s 2011 Tanul�i 8. �vfolyam"
save ${szdOHout}ertekelesi_2009-2011, replace


// harmadik hull�m ///////////////////////
*2010
use ${szdOHinSMALL}2010_6, clear
save ${szdOHout}temp1, replace

*2012
use ${szdOHinSMALL}2012_8, clear

*egybe
append using ${szdOHout}temp1, force

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
label data "OKM 2010 Tanul�i 6. �s 2012 Tanul�i 8. �vfolyam"
save ${szdOHout}ertekelesi_2010-2012, replace


// negyedik hull�m ///////////////////////
*2011
use ${szdOHinSMALL}2011_6, clear
save ${szdOHout}temp1, replace

*2013
use ${szdOHinSMALL}2013_8, clear

*egybe
append using ${szdOHout}temp1, force

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
label data "OKM 2011 Tanul�i 6. �s 2013 Tanul�i 8. �vfolyam"
save ${szdOHout}ertekelesi_2011-2013, replace

// �t�dik hull�m ///////////////////////
*2012
use ${szdOHinSMALL}2012_6, clear
save ${szdOHout}temp1, replace

*2014
use ${szdOHinSMALL}2014_8, clear

*egybe
append using ${szdOHout}temp1, force

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
label data "OKM 2012 Tanul�i 6. �s 2014 Tanul�i 8. �vfolyam"
save ${szdOHout}ertekelesi_2012-2014, replace
