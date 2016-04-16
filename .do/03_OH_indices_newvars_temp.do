*szakdolgozat
*indik�torokhoz seg�dv�ltoz�k

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
global stataOUT `""C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/BT_Szakdolgozat/from_stata/"'

global topsz 10
global topszpc = 100/${topsz}

local vars "E1 E2 I1 I2 F1 F2"
local years "2010 2011 2012 2013 2014"
local waves "2008-2010 2009-2011 2010-2012 2011-2013 2012-2014" // kiv�ve

//adatok bet�lt�se

foreach w of local waves {																//mindegyik hull�m sz�main �tloopol

use ${szdOHout}indices_`w', clear


//loops
foreach Y of local vars {																//az �sszes indexre
xtile top${topszpc}_`Y' = `Y', n(${topsz})												//n-edik percentilisek alapj�n csoporos�t�s
label variable top${topszpc}_`Y' "Az iskola top ${topszpc}% az `Y' index szerint"
egen `Y'_perc_max = min(top${topszpc}_`Y')												//a legnagyobb kateg�ria kisz�mol�sa
replace top${topszpc}_`Y' = 0 if top${topszpc}_`Y' != `Y'_perc_max							//a legnagyobb kateg�ria �rt�ke legyen egy
replace top${topszpc}_`Y' = 1 if top${topszpc}_`Y' == `Y'_perc_max							//az �sszes t�bbi legyen nulla
drop `Y'_perc_max																					//majd ezt lehet �sszeadni �venk�nt
}
*

save ${szdOHout}indices_`w'_appended, replace

}
*
