/******************************************/

--UNION(ALL) - verbindet Abfrageergebnisse "vertikal" in eine Tabelle

/******************************************/

SELECT 100, 5
UNION
SELECT 500, 10

--Spaltenanzahl muss identisch sein:

SELECT 100, 5
UNION
SELECT 500

--Datentypen müssen kompatibel sein:

SELECT 100
UNION
SELECT 'Datentyp'

SELECT 100
UNION
SELECT 10.5

--UNION hat "eingebautes" DISTINCT:
SELECT 100
UNION
SELECT 100

--Ohne DISTINCT mit UNION ALL:
SELECT 100
UNION ALL
SELECT 100

--ORDER BY immer nach der letzten UNION Abfrage
SELECT 50
UNION 
SELECT 100
UNION
SELECT 70
ORDER BY 1 DESC

/******************************************/

--INTERSECT/EXCEPT - vergleicht Abfrageergebnisse von mehr als einer Abfrage

/******************************************/

--INTERSECT = Schnittmenge (gleiche Datensätze) zweier Abfragen

SELECT * FROM Customers
INTERSECT
SELECT * FROM Customers
WHERE Country = 'Germany'

--EXCEPT = "Zeige mir alle Datensätze aus Abfrage 1, die NICHT ebenfalls in Abfrage 2 auftauchen"
SELECT * FROM Customers
EXCEPT
SELECT * FROM Customers
WHERE Country = 'Germany'

--Übung 3. --> welche Produkte haben wir NICHT in Austria verkauft?

SELECT ProductName FROM Products
EXCEPT
SELECT DISTINCT ProductName FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID 
JOIN Products p ON p.ProductID = od.ProductID
WHERE c.Country = 'Austria'

