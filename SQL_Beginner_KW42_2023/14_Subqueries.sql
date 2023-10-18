/******************************************/

--Subqueries/Unterabfragen/nested queries

/******************************************/

/*
- M�ssen eigenst�ndig fehlerfrei ausf�hrbar sein!
- Abfragen werden "von innen nach au�en" der Reihe nach ausgef�hrt
- K�nnen prinzipiell �berall in eine Abfrage eingebaut werden (wenn es Sinn macht)
- n�tzlich um komplexe Abfragen "zu zerst�ckeln"
*/


--Zeig mir alle Orders, deren Freight Wert �ber dem Durchschnitt liegt:
SELECT * FROM Orders
WHERE Freight > AVG(Freight) --so nicht m�glich (Vergleiche Prozessreihenfolge)

--Subquerie im WHERE:
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) --Subquerie wird zuerst ausgef�hrt, daher AVG(Freight) bereits "generiert"


--Subquerie im FROM (Tabellenalias nicht vergessen!):
SELECT SUM(Umsatz) FROM
(
SELECT CompanyName, SUM(SummeBestPosi) as Umsatz FROM vRechnungsDaten
WHERE Country = 'Germany'
GROUP BY CompanyName
) as t --braucht Alias, keine Tabelle ohne Namen im FROM aufrufbar!


--Mehrere Werte aus einer Subquery im WHERE m�glich, wenn mit IN kombiniert
SELECT * FROM Orders
WHERE Freight IN (SELECT TOP 10 Freight FROM Orders)
