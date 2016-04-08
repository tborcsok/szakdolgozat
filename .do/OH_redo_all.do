*minden lefuttatása újra

set rmsg on

cd "C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/stata/OH adatokkal"

run 00_OH_OHdata_convert.do
run 01_OH_creating_data_for_indices.do
run 02_OH_creating_indices.do
run 03_OH_indices_newvars.do
run 04_OH_top10_dummy.do
run 05_OH_making_panel_for_elemzesi.do
run 06_OH_elemzes.do
run 07_outreg2_fordítás.do

