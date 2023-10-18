/* Eröffnet Kommentarblock
über mehrere Zeilen
bis geschlossen wird */

--einzeiliger Kommentar ab "--"

--Richtige Datenbank ansprechen (per Dropdown Menü oben rechts oder per USE Datenbankname Befehl)
USE Northwind

-- "*" bedeuetet ALLE Spalten die vorhanden sind
SELECT * FROM Customers

SELECT * FROM Orders

--Einzelne Spalten namentlich aufrufen und mit "," trennen
SELECT CompanyName, Country, City, [Address] FROM Customers

--SQL nicht case sensitive
select ComPANYnaME, CiTy FrOM cuStomerS

--ebenfalls keine bestimmte Formatierung nötig
select 
     ComPANYnaME, 
					CiTy 
FrOM      cuStomerS

--"Custom" Ausgabe in SQL:
SELECT 100

--Strings/Charakterdatentypen müssen in einzelnen Hochkommas geschrieben werden ''
SELECT 100, 5, 'Hallo'

SELECT 100/5+7*3

SELECT Freight, Freight + 10 FROM Orders

--Namen neu vergeben über Alias:
SELECT Freight as Lieferkosten, Freight + 10 as LieferKostenPlus10 FROM Orders

--Funktionieren auch für Tabellennamen (später nützlich)
SELECT * FROM Customers as cus


/******************************************/

--ORDER BY - Sortiert Ergebnismenge - steht syntaktisch immer am Ende der Abfrage

/******************************************/

SELECT * FROM Customers
ORDER BY Country --standardmäßig immer aufsteigend

SELECT * FROM Customers
ORDER BY Country DESC --DESC = descending = absteigend

--Es kann nach mehreren Spalten sortiert werden:
SELECT CompanyName, Country, City FROM Customers
ORDER BY Country DESC, City 


/******************************************/

-- TOP X - werden nur die "obersten" X Zeilen ausgegeben

/******************************************/

SELECT TOP 10 * FROM Customers

SELECT TOP 10 Country FROM Customers

SELECT * FROM Orders

--Die 20 Bestellungen mit den kleinsten Freight Werten:
SELECT TOP 20 * FROM Orders
ORDER BY Freight

--Die 20 Bestellungen mit den größten Freight Werten:
SELECT TOP 20 * FROM Orders
ORDER BY Freight DESC

--> SELECT BOT X gibt es nicht, wir drehen die Sortierung einfach mit Order By um

SELECT TOP 10 PERCENT * FROM Orders


/******************************************/

--DISTINCT - "filtert" Duplikate Ergebniszeilen

/******************************************/

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT Country, City FROM Customers

SELECT DISTINCT Country, City, Address FROM Customers

SELECT DISTINCT TOP 10 Country FROM Customers

SELECT * FROM [Order Details]
