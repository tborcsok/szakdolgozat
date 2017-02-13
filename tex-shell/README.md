### Az ELTE TáTK formai követelményeinek megfelelő TeX template

Texmaker használata esetén a követkzőt kell megtenni ahhoz, hogy működjön: a lenti kifejezést másoljátók be a Beállítások -> Gyorsfordítás -> Egyéni részbe. Ha nem működik nézzétek meg jobban hogy mi is van a szövegben, és javítsátok az Adobe Reader elérési útvonalát.

    xelatex -synctex=1 -interaction=nonstopmode %.tex|bibtex %|xelatex -synctex=1 -interaction=nonstopmode %.tex|xelatex -synctex=1 -interaction=nonstopmode %.tex|"C:/Program Files (x86)/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe" %.pdf

Ez felülírja, hogy miket futtasson le a Gyorsfordítás, és pont azt csinálja a program, amire nekünk szükségünk van. XeLaTeX-et használ, ami a Calibri betűtípus miatt szükséges. Illetve betölti a BibTeX hivatkozáskezelőt.

Óriások vállán állva készült el ez a minta, egy közkézen forgó ELTECON template alapján.

Megjegyzés: **Továbbra is a te felelősséged, hogy formailag megfelelt szakdolgozatot adj le**.

### Stata - LaTeX integráció

Egy rövid fájl leírja, hogy hogyan lehet közös munkára bírni a két platformot. Remélem, hogy lesz aki hasznosnak találja ezt később.
