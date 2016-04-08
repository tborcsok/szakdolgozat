*szakdolgozat
*adatfájlok kibövitése

//alapbeállítások
clear
clear matrix
clear mata
set more off
set varabbrev off
set matsize 11000
set maxvar 32767
*set segmentsize 128m

local years "2008 2009 2010 2011 2012 2013 2014"
local evfolyam "6 8 10"

global szdOHout "E:/szakdoga_data_out/OHtól/"
global szdOHin "E:/szakdoga_data_out/OHtól/alap/"
global szdOHinSMALL "E:/szakdoga_data_out/OHtól/alap/small_"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

//nyers adatok STATA dta formátumra konvertálása
foreach y of local years {
foreach evf of local evfolyam {
clear
import delimited E:/szakdoga_adatok_leave_unchanged/szakdoga_adatok_from_OH/OKM_`y'_sajat_azonositoval/`evf'_evfolyam_tanuloi_adatok.dat
save $szdOHout`y'_`evf'_evf_tanuloi, replace
clear
}
}



//évenként az adatok, évenként speciális szürési feltételekkel
*év, osztály

foreach y of local years {
foreach oszt of local evfolyam {

use ${szdOHin}`y'_`oszt'.dta, clear

gen ev = `y'

//régiekben átnevezni ugyanarra
capture rename azon_kozos azon

capture rename m_zpsc_kozos m_zpsc
capture rename m_zpsc_se_kozos m_zpsc_se

capture rename o_zpsc_kozos o_zpsc 
capture rename o_zpsc_se_kozos o_zpsc_se

*capture rename m_szint_kozos m_szint
*capture rename o_szint_kozos o_szint

capture rename zhei csh_index

//meghagyni amit használok is
keep azon omid telephely evfolyam tipus megye_kod regio_kod telnagy teltip isknagy fentip m_zpsc m_zpsc_se o_zpsc o_zpsc_se nem csh_index rv_hhh ta02701 ta02801 ev

destring, replace dpcomma

//labelek
label define tipusl 1 "általános iskola" 2 "8 évfolyamos gimnázium" 3 "6 évfolyamos gimnázium"  4 "4 évfolyamos gimnázium" 5 "szakközépiskola" 6 "szakiskola" 7 "speciális szakiskola"
label values tipus tipusl  
label define telnagyl 1 "Kis község" 2 "Közepes község" 3 "Nagy község" 4 "Kis város" 5 "Közepes város" 6 "Nagy város" 7 "Megyeszékhely" 8 "Budapest"
label values telnagy telnagyl
label define neml 1 "lány" 2 "fiú"
label values nem neml

label variable o_zpsc "A tanuló szövegértés pontszáma év szerint standardizálva"
label variable m_zpsc "A tanuló matematika pontszáma év szerint standardizálva"

label variable ta02801 "A tanuló édes- vagy nevelöapjának legmagasabb iskolai végzettsége"
label variable ta02701 "A tanuló édes- vagy nevelöanyjának legmagasabb iskolai végzettsége"

label variable csh_index "A tanuló standardizált családiháttér-indexe"



sort azon

save ${szdOHinSMALL}`y'_`oszt'.dta, replace
}
}
*

