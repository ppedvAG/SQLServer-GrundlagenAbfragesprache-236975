/******************************************/

--Temporäre Tabellen/Temp Tables/#Tables

/******************************************/

/*
- mit SELECT INTO #Tablename werden Ergebnisse in eine Temporäre Tabelle geschrieben
- existiert nur innerhalb meiner Session (Skriptfenster)
- werden in SystemDB tempdb angelegt
- Ergebnisse werden nur einmal generiert --> TempTables sehr schnell aber nicht aktuell
- mit einem # = "lokal" 
- mit zwei ## = "global" (funktionieren in anderen Sessions/Skriptfenstern) selten nützlich
*/

--"Summe von Summen" bilden; schnell lösbar über #Table:
SELECT CompanyName, SUM(SummeBestPosi) as Umsatz 
INTO #TempTable
FROM vRechnungsDaten
WHERE Country = 'Germany'
GROUP BY CompanyName

SELECT SUM(Umsatz) FROM #TempTable

--manuell löschen:
DROP TABLE #TempTable

--globale Temp Table:
SELECT CompanyName, SUM(SummeBestPosi) as Umsatz 
INTO ##TempTable
FROM vRechnungsDaten
WHERE Country = 'Germany'
GROUP BY CompanyName