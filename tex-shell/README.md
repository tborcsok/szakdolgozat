### Az ELTE TáTK formai követelményeinek megfelelő TeX template.

Texmakert használóknak: a lenti kifejezést másoljátók be a Beállítások -> Gyorsfordítás -> Egyéni részbe. Ha nem működik nézzétek meg jobban hogy mi is van a szövegben, és javítsátok az Adobe Reader elérési útvonalát.

xelatex -synctex=1 -interaction=nonstopmode %.tex|bibtex %|xelatex -synctex=1 -interaction=nonstopmode %.tex|xelatex -synctex=1 -interaction=nonstopmode %.tex|"C:/Program Files (x86)/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe" %.pdf

Ez felülírja, hogy miket futtasson le a Gyorsfordítás (a gombot lásd fent), és pont azt csinálja a program, amire nekünk szükségünk van. Egyébként azért ez a sok macera, hogy legyen Calibri betűtípus ...
