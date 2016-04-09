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
local valtozok2 "E2 I1 I2 F1 F2"
local refe "fe re" //re

*local sort "o_zpsc_8 csh_index 1.sum10 2.sum10 3.sum10 4.sum10 5.sum10 1.sum10#c.csh_index 2.sum10#c.csh_index 3.sum10#c.csh_index 4.sum10#c.csh_index 5.sum10#c.csh_index"
local sort "o_zpsc_8 csh_index sum10_1of5 sum10_2of5 sum10_3of5 sum10_4of5 sum10_5of5 sum10_1of5#c.csh_index sum10_2of5#c.csh_index sum10_3of5#c.csh_index sum10_4of5#c.csh_index sum10_5of5#c.csh_index"
local dropp "0b.sum10_1of5#co.csh_index 0b.sum10_2of5#co.csh_index 0b.sum10_3of5#co.csh_index 0b.sum10_4of5#co.csh_index 0b.sum10_5of5#co.csh_index o.sum10_5of5 0o.sum10_5of5#co.csh_index o.sum10_4of5 0o.sum10_4of5#co.csh_index"
	
local waaves "2010-2012 2011-2013 2012-2014 pooled"
local refere "fe re"
local depvar "szint valtozas"
	
foreach w of local waaves {
foreach ref of local refere	{
foreach dep of local depvar {
	
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'1.tex", /*
    */ from("VARIABLES") to("VALTOZOK") replace
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'1.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'2.tex", /*
	*/ from("1.sum10") to("sum10") replace
	 
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'2.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'3.tex", /* 
	*/ from("c.csh") to("csh")  replace 
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'3.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'7.tex", /*
	*/ from("Constant") to("Konstans")  replace 
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'7.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'8.tex", /*
	*/ from("2.nem") to("nem")  replace 
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'8.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'9.tex", /*
	*/ from("Observations") to("Megfigyelesek")  replace 
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'9.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'10.tex", /*
	*/ from("Number of omid10") to("Iskolak szama")  replace 
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'10.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'11.tex", /*
	*/ from("Depvar") to("Fuggo valtozo")  replace  
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'11.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'12.tex", /*
	*/ from("Wave") to("Kohorsz")  replace
	
	filefilter ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'12.tex" ${stataOUT}tables/eredmenyek_`w'_`ref'_`dep'_jav.tex", /*
	*/ from("Robust standard errors in parentheses") to("A zarojelekben klaszter-robosztus standard hibak")  replace

}
}
}
*

local waaaves "2008-2010 2009-2011 2010-2012 2011-2013 2012-2014"
	
foreach w of local waaaves {
	
	
	filefilter ${stataOUT}tables/elso_`w'.tex" ${stataOUT}tables/elso_`w'1.tex", /*
    */ from("VARIABLES") to("VALTOZOK") replace
	
	filefilter ${stataOUT}tables/elso_`w'1.tex" ${stataOUT}tables/elso_`w'2.tex", /*
	*/ from("1.sum10") to("sum10") replace
	 
	filefilter ${stataOUT}tables/elso_`w'2.tex" ${stataOUT}tables/elso_`w'3.tex", /* 
	*/ from("c.csh") to("csh")  replace 
	
	filefilter ${stataOUT}tables/elso_`w'3.tex" ${stataOUT}tables/elso_`w'7.tex", /*
	*/ from("Constant") to("Konstans")  replace 
	
	filefilter ${stataOUT}tables/elso_`w'7.tex" ${stataOUT}tables/elso_`w'8.tex", /*
	*/ from("2.nem") to("nem")  replace 
	
	filefilter ${stataOUT}tables/elso_`w'8.tex" ${stataOUT}tables/elso_`w'9.tex", /*
	*/ from("Observations") to("Megfigyelesek")  replace 
	
	filefilter ${stataOUT}tables/elso_`w'9.tex" ${stataOUT}tables/elso_`w'10.tex", /*
	*/ from("Number of omid10") to("Iskolak szama")  replace 
	
	filefilter ${stataOUT}tables/elso_`w'10.tex" ${stataOUT}tables/elso_`w'11.tex", /*
	*/ from("Depvar") to("Fuggo valtozo")  replace  
	
	filefilter ${stataOUT}tables/elso_`w'11.tex" ${stataOUT}tables/elso_`w'12.tex", /*
	*/ from("Wave") to("Kohorsz")  replace
	
	filefilter ${stataOUT}tables/elso_`w'12.tex" ${stataOUT}tables/elso_`w'13.tex", /*
	*/ from("lag") to("6")  replace
	
	filefilter ${stataOUT}tables/elso_`w'13.tex" ${stataOUT}tables/elso_`w'_jav.tex", /*
	*/ from("Robust standard errors in parentheses") to("A zarojelekben klaszter-robosztus standard hibak")  replace

}
*
	
