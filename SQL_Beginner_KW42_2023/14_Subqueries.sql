/******************************************/

--Subqueries/Unterabfragen/nested queries

/******************************************/

/*
- Müssen eigenständig fehlerfrei ausführbar sein!
- Abfragen werden "von innen nach außen" der Reihe nach ausgeführt
- Können prinzipiell überall in eine Abfrage eingebaut werden (wenn es Sinn macht)
- nützlich um komplexe Abfragen "zu zerstückeln"
*/


--Zeig mir alle Orders, deren Freight Wert über dem Durchschnitt liegt:
SELECT * FROM Orders
WHERE Freight > AVG(Freight) --so nicht möglich (Vergleiche Prozessreihenfolge)

--Subquerie im WHERE:
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) --Subquerie wird zuerst ausgeführt, daher AVG(Freight) bereits "generiert"


--Subquerie im FROM (Tabellenalias nicht vergessen!):
SELECT SUM(Umsatz) FROM
(
SELECT CompanyName, SUM(SummeBestPosi) as Umsatz FROM vRechnungsDaten
WHERE Country = 'Germany'
GROUP BY CompanyName
) as t --braucht Alias, keine Tabelle ohne Namen im FROM aufrufbar!


--Mehrere Werte aus einer Subquery im WHERE möglich, wenn mit IN kombiniert
SELECT * FROM Orders
WHERE Freight IN (SELECT TOP 10 Freight FROM Orders)
