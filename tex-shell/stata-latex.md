## Egy-két példa a LaTeX és a STATA összehangolt használtatára

A .tex fájl mappájában ajánlott lehet egy külön mappát csinálni a STATA outputoknak.

Az outreg2-t ezután utasíthatod arra, hogy ide rakja a táblázatait .tex formátumban. Ugyanígy tudsz tenni ábrák esetében.

### STATA

Táblázat kimentése: 

	regress y x
	outreg2 using "C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/from_stata/tables/eredmenyek.tex", replace tex(fragment pretty)
  
Ábra kimentése:

	scatter y x
	graph export "C:/Users/Tomi/Google Drive/ELTE/SZAKDOLGOZAT/from_stata/images/image.png", as(png) replace


### LATEX

Táblázat beillesztése:

	\begin{table}
	\include{./from_stata/tables/eredmenyek}
	\caption{<A táblázat címe>}
	\label{<A táblázat címkéje, hogy hivatkozhass rá a szövegben>}
	\end{table}
	
Kép beillesztése:

	\begin{figure}
	\center
	\includegraphics[scale=0.8]{./from_stata/images/image.png}
	\caption{<A táblázat címe>}
	\label{<A táblázat címkéje, hogy hivatkozhass rá a szövegben>}
	\end{figure}
