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

//fájlformátum cseréje, kikommentelve mert elég volt egyszer lefuttatni
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

//kihagyandó változók
*local droplist azon_regi m_zpsc_regi m_zpsc_se_regi o_zpsc_regi o_zpsc_se_regi m_szint_regi o_szint_regi rv_sni_t rv_sni_e rv_sni_a rv_sni_p rv_sni_p_1 rv_sni_p_2 rv_sni_p_3 rv_sni_p_4 rv_sni_p_5 rv_sni_p_6 rv_sni_p_7 rv_sni_p_8 rv_sni_p_9 rv_sni_p_10 rv_sni_p_99 szmcsop_0 szmcsop_1 szmcsop_2 szmcsop_3 szmcsop_4 szmcsop_5 szmcsop_6 szmcsop_7 szmcsop_8 szmcsop_9 szmcsop_10 szmcsop_11 szmcsop_12 szmcsop_13 szmcsop_14 szmcsop_15 szmcsop_16 szmcsop_17 szmcsop_18 szmcsop_19 szmcsop_20 szmcsop_21 nyelv ji_mentesseg ji_teszt_1 ji_teszt_2 ji_teszt_3 ji_teszt_4 token_tanuloi ta00101 ta00102 ta00201 ta00300 ta00400 ta00501 ta00502 ta00503 ta00601 ta00602 ta00701 ta00801 ta00901 ta01101 ta01201 ta01001 ta01301 ta01401 ta01402 ta01403 ta01404 ta01405 ta01506 ta01601 ta01701 ta01702 ta01703 ta01801 ta01901 ta02001 ta02002 ta02003 ta02004 ta02005 ta02006 ta02007 ta02008 ta02009 ta02010 ta02101 ta02201 ta02301 ta02401 ta02501 ta02601 ta02701 ta02801 ta02901 ta03001 ta03101 ta03201 ta03301 ta03401 ta03501 ta03601 ta03602 ta03603 ta03604 ta03701 ta03801 ta03901 ta03902 ta03903 ta03904 ta04001 ta04101 ta04102 ta04103 ta04104 ta04105 ta04201 ta04301 ta04401 ta04501 ta04502 ta04601 ta04600 ta04604 ta04605 ta04606 ta04607 ta04701 ta04801 ta04901 ta04902 ta05001 ta05101 ta05201 ta05202 ta05203 ta05301 ta05302 ta05303 ta05304 ta05305 ta05401 bs_suly1 bs_suly2 bs_suly3 bs_suly4 bs_suly5 bs_suly6 bs_suly7 bs_suly8 bs_suly9 bs_suly10 bs_suly11 bs_suly12 bs_suly13 bs_suly14 bs_suly15 bs_suly16 bs_suly17 bs_suly18 bs_suly19 bs_suly20 bs_suly21 bs_suly22 bs_suly23 bs_suly24 bs_suly25 bs_suly26 bs_suly27 bs_suly28 bs_suly29 bs_suly30 bs_suly31 bs_suly32 bs_suly33 bs_suly34 bs_suly35 bs_suly36 bs_suly37 bs_suly38 bs_suly39 bs_suly40 bs_suly41 bs_suly42 bs_suly43 bs_suly44 bs_suly45 bs_suly46 bs_suly47 bs_suly48 bs_suly49 bs_suly50 bs_suly51 bs_suly52 bs_suly53 bs_suly54 bs_suly55 bs_suly56 bs_suly57 bs_suly58 bs_suly59 bs_suly60 bs_suly61 bs_suly62 bs_suly63 bs_suly64 bs_suly65 bs_suly66 bs_suly67 bs_suly68 bs_suly69 bs_suly70 bs_suly71 bs_suly72 bs_suly73 bs_suly74 bs_suly75 bs_suly76 bs_suly77 bs_suly78 bs_suly79 bs_suly80 bs_suly81 bs_suly82 bs_suly83 bs_suly84 bs_suly85 bs_suly86 bs_suly87 bs_suly88 bs_suly89 bs_suly90 bs_suly91 bs_suly92 bs_suly93 bs_suly94 bs_suly95 bs_suly96 bs_suly97 bs_suly98 bs_suly99 bs_suly100 bs_suly101 rv_sni_t rv_sni_e rv_sni_a rv_sni_p rv_sni_p_1 rv_sni_p_2 rv_sni_p_3 rv_sni_p_4 rv_sni_p_5 rv_sni_p_6 rv_sni_p_7 rv_sni_p_8 rv_sni_p_9 rv_sni_p_10 rv_sni_p_99 szmcsop_0 szmcsop_1 szmcsop_2 szmcsop_3 szmcsop_4 szmcsop_5 szmcsop_6 szmcsop_7 szmcsop_8 szmcsop_9 szmcsop_10 szmcsop_11 szmcsop_12 szmcsop_13 szmcsop_14 szmcsop_15 szmcsop_16 szmcsop_17 szmcsop_18 szmcsop_19 szmcsop_20 szmcsop_21 ji_mentesseg ji_teszt_1 ji_teszt_2 ji_teszt_3 ji_teszt_4 nyelv token_tanuloi ta00101 ta00102 ta00201 ta00301 ta00401 ta00501 ta00502 ta00503 ta00601 ta00602 ta00701 ta00801 ta00901 ta01001 ta01101 ta01201 ta01301 ta01401 ta01402 ta01403 ta01404 ta01405 ta01506 ta01601 ta01701 ta01702 ta01703 ta01801 ta01901 ta02001 ta02002 ta02003 ta02004 ta02005 ta02006 ta02007 ta02008 ta02009 ta02010 ta02101 ta02201 ta02301 ta02401 ta02501 ta02601 ta02701 ta02801 ta02901 ta03001 ta03101 ta03201 ta03301 ta03401 ta03501 ta03601 ta03602 ta03603 ta03604 ta03701 ta03801 ta03901 ta03902 ta03903 ta03904 ta04001 ta04101 ta04102 ta04103 ta04104 ta04105 ta04201 ta04301 ta04401 ta04501 ta04502 ta04601 ta04602 ta04603 ta04604 ta04605 ta04606 ta04607 ta04701 ta04801 ta04901 ta04902 ta05001 ta05101 ta05201 ta05202 ta05203 ta05301 ta05302 ta05303 ta05304 ta05305 ta05401 bs_suly1 bs_suly2 bs_suly3 bs_suly4 bs_suly5 bs_suly6 bs_suly7 bs_suly8 bs_suly9 bs_suly10 bs_suly11 bs_suly12 bs_suly13 bs_suly14 bs_suly15 bs_suly16 bs_suly17 bs_suly18 bs_suly19 bs_suly20 bs_suly21 bs_suly22 bs_suly23 bs_suly24 bs_suly25 bs_suly26 bs_suly27 bs_suly28 bs_suly29 bs_suly30 bs_suly31 bs_suly32 bs_suly33 bs_suly34 bs_suly35 bs_suly36 bs_suly37 bs_suly38 bs_suly39 bs_suly40 bs_suly41 bs_suly42 bs_suly43 bs_suly44 bs_suly45 bs_suly46 bs_suly47 bs_suly48 bs_suly49 bs_suly50 bs_suly51 bs_suly52 bs_suly53 bs_suly54 bs_suly55 bs_suly56 bs_suly57 bs_suly58 bs_suly59 bs_suly60 bs_suly61 bs_suly62 bs_suly63 bs_suly64 bs_suly65 bs_suly66 bs_suly67 bs_suly68 bs_suly69 bs_suly70 bs_suly71 bs_suly72 bs_suly73 bs_suly74 bs_suly75 bs_suly76 bs_suly77 bs_suly78 bs_suly79 bs_suly80 bs_suly81 bs_suly82 bs_suly83 bs_suly84 bs_suly85 bs_suly86 bs_suly87 bs_suly88 bs_suly89 bs_suly90 bs_suly91 bs_suly92 bs_suly93 bs_suly94 bs_suly95 bs_suly96 bs_suly97 bs_suly98 bs_suly99 bs_suly100 bs_suly101 rv_btm_b rv_btm_i rv_btm_m rv_btm_o rv_btm_s ta01002 ta04503 ta05501 ta05502 ta05503 ta05504 ta05505 ta05506 ta05507 ta05508 ta05509 ta05510 ta05511
*local droplist szmcsop_19 azon_regi szmcsop_17 szmcsop_16 szmcsop_15 szmcsop_14 szmcsop_13 szmcsop_12 szmcsop_11 szmcsop_10 ta03401 ta02009 ta00400 bs_suly101 bs_suly14 ta02601 szmcsop_9 szmcsop_8 rv_sni_p szmcsop_6 szmcsop_5 szmcsop_18 szmcsop_3 szmcsop_2 szmcsop_1 szmcsop_0 ta01301 bs_suly59 bs_suly58 ta02003 bs_suly53 rv_sni_a bs_suly51 bs_suly50 bs_suly57 rv_sni_e bs_suly52 bs_suly54 rv_sni_p_7 rv_sni_p_6 rv_sni_p_5 rv_sni_p_4 rv_sni_p_3 rv_sni_p_2 rv_sni_p_1 ta01201 bs_suly30 bs_suly33 bs_suly32 bs_suly35 bs_suly34 rv_sni_p_9 rv_sni_p_8 ta02301 ta01801 m_zpsc_se_regi ta03001 ta04001 ta05201 ta05203 ta05202 bs_suly71 ta00801 bs_suly98 ta03903 bs_suly48 bs_suly49 bs_suly81 bs_suly44 bs_suly45 bs_suly46 bs_suly47 ta03801 bs_suly41 bs_suly42 bs_suly43 bs_suly28 bs_suly29 ta00101 bs_suly23 bs_suly20 ta00102 ta01601 bs_suly27 m_szint_regi bs_suly25 szmcsop_4 ta05507 bs_suly31 bs_suly87 ta05511 ta05510 ta04105 ta04104 ta04101 ji_mentesseg ta04103 ta04102 rv_btm_o bs_suly16 ta05509 bs_suly72 ta01101 bs_suly19 bs_suly18 bs_suly17 bs_suly13 bs_suly15 ta03701 ta00501 ta02010 ta00503 ta00502 bs_suly9 bs_suly8 bs_suly11 bs_suly3 bs_suly2 bs_suly1 bs_suly10 bs_suly7 bs_suly6 bs_suly5 m_zpsc_regi ta00901 o_zpsc_regi bs_suly40 ta00301 ta05508 ta03301 szmcsop_7 ji_teszt_4 ji_teszt_3 ji_teszt_2 ji_teszt_1 ta05101 ta01506 ta02008 ta00201 bs_suly74 bs_suly67 ta02002 rv_sni_t ta02901 ta02001 ta02006 ta02007 ta02004 ta02005 ta05502 ta04801 ta05503 ta04602 ta04603 ta04600 ta04601 ta04606 ta04607 ta04604 ta04605 ta05501 bs_suly96 ta05506 bs_suly61 ta02401 bs_suly97 bs_suly22 bs_suly95 bs_suly94 bs_suly93 bs_suly92 bs_suly91 bs_suly90 bs_suly4 bs_suly99 ta04201 ta03603 ta03602 ta03601 bs_suly21 ta00602 ta03901 ta03902 ta00601 bs_suly26 bs_suly37 bs_suly78 ta05504 ta05401 bs_suly24 szmcsop_20 szmcsop_21 ta01002 ta01001 bs_suly82 bs_suly88 bs_suly89 ta03201 bs_suly80 ta04401 bs_suly36 bs_suly83 bs_suly84 bs_suly85 bs_suly86 bs_suly56 ta05304 bs_suly55 ta05001 bs_suly12 nyelv bs_suly66 ta03904 ta02101 bs_suly65 bs_suly62 bs_suly63 bs_suly60 bs_suly38 bs_suly77 bs_suly68 bs_suly69 ta04701 bs_suly76 ta03501 ta01405 ta00300 ta01403 ta01402 ta01401 bs_suly70 o_zpsc_se_regi ta01404 bs_suly73 ta02501 bs_suly39 ta03604 token_tanuloi ta04301 bs_suly64 ta05505 bs_suly79 ta04901 ta04902 ta01701 ta01702 ta01703 ta02201 ta01901 ta03101 ta00701 rv_sni_p_10 ta04501 ta04503 ta04502 o_szint_regi ta05305 rv_btm_s ta05301 ta05302 ta05303 bs_suly75 rv_btm_m bs_suly100 rv_btm_i ta00401 rv_btm_b rv_sni_p_99

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
*kisterseg_kod

/*
gen omid`oszt' = omid
drop omid

gen m_zpsc`oszt' = m_zpsc
gen m_zpsc`oszt'_se = m_zpsc_se
drop m_zpsc m_zpsc_se

gen o_zpsc`oszt' = o_zpsc
gen o_zpsc`oszt'_se = o_zpsc_se
drop o_zpsc o_zpsc_se
*/

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
*drop if ta02801 >=30
*drop if ta02701 >=30

//csh_index sztenderdizálása
*egen placeholder = std(csh_index)
*replace csh_index = placeholder
*drop placeholder
label variable csh_index "A tanuló standardizált családiháttér-indexe"


//legkisebb iskolák kidobása
*sort omid
*by omid: gen freq_omid = _N
*drop if freq_omid <=10
*drop freq_omid

sort azon

save ${szdOHinSMALL}`y'_`oszt'.dta, replace
}
}
*

