
cd "E:\szakdoga_data_out\OHtól"

use final_elemzesi_2010-2012.dta, clear

lowess o_zpsc_10 csh_index, jitter(3) lwidth(medthick) saving(10_evf, replace) 

graph export "C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/images/szocokon_matek_2012.png", as(png) replace

