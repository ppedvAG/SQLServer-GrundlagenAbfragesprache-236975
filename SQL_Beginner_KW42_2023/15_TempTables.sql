/******************************************/

--Tempor�re Tabellen/Temp Tables/#Tables

/******************************************/

/*
- mit SELECT INTO #Tablename werden Ergebnisse in eine Tempor�re Tabelle geschrieben
- existiert nur innerhalb meiner Session (Skriptfenster)
- werden in SystemDB tempdb angelegt
- Ergebnisse werden nur einmal generiert --> TempTables sehr schnell aber nicht aktuell
- mit einem # = "lokal" 
- mit zwei ## = "global" (funktionieren in anderen Sessions/Skriptfenstern) selten n�tzlich
*/

--"Summe von Summen" bilden; schnell l�sbar �ber #Table:
SELECT CompanyName, SUM(SummeBestPosi) as Umsatz 
INTO #TempTable
FROM vRechnungsDaten
WHERE Country = 'Germany'
GROUP BY CompanyName

SELECT SUM(Umsatz) FROM #TempTable

--manuell l�schen:
DROP TABLE #TempTable

--globale Temp Table:
SELECT CompanyName, SUM(SummeBestPosi) as Umsatz 
INTO ##TempTable
FROM vRechnungsDaten
WHERE Country = 'Germany'
GROUP BY CompanyName