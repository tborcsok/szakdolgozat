*szakdolgozat
*adatok betöltése, alap fájlok elkészítése

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

local years 2008 2009 2010 2011 2012 2013 2014
local evfolyam 6 8 10

global szdOHout "E:/szakdoga_data_out/OHtól/"
global szdOHin "E:/szakdoga_data_out/OHtól/alap/"
local years "2008 2009 2010 2011 2012 2013 2014"
local evfolyam "6 8 10"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'
global szdOHinSMALL "E:/szakdoga_data_out/OHtól/alap/small_"

global iskid "omid" //telhid, omid lehet
						//a telhid egy olyan változó, ami az omidet és a telephelyet kapcsolja össze


//////////////////////////////////////////////////////////////////////////////////////////////////////////


// elsö hullám ///////////////////////
*2008
use ${szdOHinSMALL}2008_6, clear
save ${szdOHout}temp1, replace

*2010
use ${szdOHinSMALL}2010_8, clear

*egybe
append using ${szdOHout}temp1, force

//tisztítás
*tanuló és év szerint panel
sort azon ev
xtset azon ev

//változógenerálás
xtset azon ev

gen o_zpsc_lag = L2.o_zpsc												//elözö idöszaki generálása
label variable o_zpsc_lag "Az elözö idöszaki szövegértés pontszám"
gen o_zpsc_diff = o_zpsc - L2.o_zpsc									//változás
label variable o_zpsc_diff "A szövegértés pontszám változása"

gen m_zpsc_lag = L2.m_zpsc
label variable m_zpsc_lag "Az elözö idöszaki matematika pontszám"
gen m_zpsc_diff = m_zpsc - L2.m_zpsc
label variable m_zpsc_diff "A matematika pontszám változása"

compress
label data "OKM 2008 Tanulói 6. és 2010 Tanulói 8. évfolyam"
save ${szdOHout}ertekelesi_2008-2010, replace

// második hullám ///////////////////////
*2009
use ${szdOHinSMALL}2009_6, clear
save ${szdOHout}temp1, replace

*2011
use ${szdOHinSMALL}2011_8, clear

*egybe
append using ${szdOHout}temp1, force

//tisztítás
sort azon ev
xtset azon ev

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
label data "OKM 2009 Tanulói 6. és 2011 Tanulói 8. évfolyam"
save ${szdOHout}ertekelesi_2009-2011, replace


// harmadik hullám ///////////////////////
*2010
use ${szdOHinSMALL}2010_6, clear
save ${szdOHout}temp1, replace

*2012
use ${szdOHinSMALL}2012_8, clear

*egybe
append using ${szdOHout}temp1, force

//tisztítás
sort azon ev
xtset azon ev

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
label data "OKM 2010 Tanulói 6. és 2012 Tanulói 8. évfolyam"
save ${szdOHout}ertekelesi_2010-2012, replace


// negyedik hullám ///////////////////////
*2011
use ${szdOHinSMALL}2011_6, clear
save ${szdOHout}temp1, replace

*2013
use ${szdOHinSMALL}2013_8, clear

*egybe
append using ${szdOHout}temp1, force

//tisztítás
sort azon ev
xtset azon ev

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
label data "OKM 2011 Tanulói 6. és 2013 Tanulói 8. évfolyam"
save ${szdOHout}ertekelesi_2011-2013, replace

// ötödik hullám ///////////////////////
*2012
use ${szdOHinSMALL}2012_6, clear
save ${szdOHout}temp1, replace

*2014
use ${szdOHinSMALL}2014_8, clear

*egybe
append using ${szdOHout}temp1, force

//tisztítás
sort azon ev
xtset azon ev

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
label data "OKM 2012 Tanulói 6. és 2014 Tanulói 8. évfolyam"
save ${szdOHout}ertekelesi_2012-2014, replace
