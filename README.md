# A családi és iskolai körülmények hatása az iskolai teljesítményre

## Online függelék

Ezen az oldalon találhatóak meg a 2015/2016 tavaszi félévében, az ELTE TáTK Alkalmazott Közgazdaságtan alapképzés szakára íródott szakdolgozatom részletes regressziós outputjai.

Illetve megtalálhatóak az elemzés során használt .do fájlok, melyeket a STATA 13 statisztikai programcsomagban futtattam. A program bemeneti adatfájljait az Oktatási Hivatalhoz beadott közérdekű adatigénylés alapján kapott, a 2008 és 2014 közötti mérésekre vonatkozó nyers adatfájlok képezik. Amennyiben valaki rendelkezik ezekkel, az adatelemzés reprodukálható, csupán a fájlok beolvasása és kimentése során használt elérési útvonalakat szükséges módosítani. Ez egyszerűen kivitelezhető, ugyanis az elérési útvonalakat globális makrók határozzák meg az egyes .do fájlok elején.

Az utolsó .do fájl az outreg2 által létrehozott összefoglaló táblázatok magyar nyelvre való lefordítására tesz kísérletet. Az itt használt módszer még igazán kezdetleges, sok felesleges fájl létrehozásával jár, és nem tudja kezelni a magyar karaktereket. Célom, hogy egy későbbi projekt során ezt a két problémát megoldva egy univerzálisan használható kódot hozzak létre, melynek külön STATA csomaggá fejlesztése is felmerült bennem.
