*szakdolgozat
*adatf�jlok kib�vit�se

//alapbe�ll�t�sok
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

global szdOHout "E:/szakdoga_data_out/OHt�l/"
global szdOHin "E:/szakdoga_data_out/OHt�l/alap/"
global szdOHinSMALL "E:/szakdoga_data_out/OHt�l/alap/small_"
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

//f�jlform�tum cser�je, kikommentelve mert el�g volt egyszer lefuttatni
/*
foreach y of local years {
foreach evf of local evfolyam {
clear
import delimited E:/szakdoga_adatok_leave_unchanged/szakdoga_adatok_from_OH/OKM_`y'_sajat_azonositoval/`evf'_evfolyam_tanuloi_adatok.dat
save $szdOHout`y'_`evf'_evf_tanuloi, replace
clear
}
}
*/


//�venk�nt az adatok, �venk�nt speci�lis sz�r�si felt�telekkel
*�v, oszt�ly

foreach y of local years {
foreach oszt of local evfolyam {

use ${szdOHin}`y'_`oszt'.dta, clear

gen ev = `y'

//r�giekben �tnevezni ugyanarra
capture rename azon_kozos azon

capture rename m_zpsc_kozos m_zpsc
capture rename m_zpsc_se_kozos m_zpsc_se

capture rename o_zpsc_kozos o_zpsc 
capture rename o_zpsc_se_kozos o_zpsc_se

*capture rename m_szint_kozos m_szint
*capture rename o_szint_kozos o_szint

capture rename zhei csh_index

//meghagyni amit haszn�lok is
keep azon omid telephely evfolyam tipus megye_kod regio_kod telnagy teltip isknagy fentip m_zpsc m_zpsc_se o_zpsc o_zpsc_se nem csh_index rv_hhh ta02701 ta02801 ev
*kisterseg_kod


destring, replace dpcomma

//labelek
label define tipusl 1 "�ltal�nos iskola" 2 "8 �vfolyamos gimn�zium" 3 "6 �vfolyamos gimn�zium"  4 "4 �vfolyamos gimn�zium" 5 "szakk�z�piskola" 6 "szakiskola" 7 "speci�lis szakiskola"
label values tipus tipusl  
label define telnagyl 1 "Kis k�zs�g" 2 "K�zepes k�zs�g" 3 "Nagy k�zs�g" 4 "Kis v�ros" 5 "K�zepes v�ros" 6 "Nagy v�ros" 7 "Megyesz�khely" 8 "Budapest"
label values telnagy telnagyl
label define neml 1 "l�ny" 2 "fi�"
label values nem neml

label variable o_zpsc "A tanul� sz�veg�rt�s pontsz�ma �v szerint standardiz�lva"
label variable m_zpsc "A tanul� matematika pontsz�ma �v szerint standardiz�lva"

label variable ta02801 "A tanul� �des- vagy nevel�apj�nak legmagasabb iskolai v�gzetts�ge"
label variable ta02701 "A tanul� �des- vagy nevel�anyj�nak legmagasabb iskolai v�gzetts�ge"


label variable csh_index "A tanul� standardiz�lt csal�dih�tt�r-indexe"

sort azon

save ${szdOHinSMALL}`y'_`oszt'.dta, replace
}
}
*

