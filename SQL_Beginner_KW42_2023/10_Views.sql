/******************************************/

--Views/Sichten - "gespeicherte SELECT Abfragen"

/******************************************/

/*
Vorteile einer View:
- Die Ergebnisse komplexer Abfragen abspeichern (auch für andere User)
- Views können unterschiedliche Rechte haben als die Tabellen aus denen die Spalten stammen
- 
- Views sind immer aktuell (aktuelle Daten), weil eine View bei Aufruf immer das hinterlegte 
  Statement ausführt
- ORDER BY funktioniert nicht im CREATE VIEW Teil (Beim Aufruf der View kann ORDER BY verwendet werden)
*/


--View erstellen:

CREATE VIEW vRechnungsDaten AS

SELECT 
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName


--View löschen:

DROP VIEW vRechnungsDaten

--View ändern: (bitte nicht DROP und neu CREATE, da Metadaten verändert werden)

ALTER VIEW vRechnungsDaten AS
SELECT 
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName

--Code hinter einer View (oder anderem DB Objekt) ansehen über Object Explorer
-->Rechtsklick - Script as - CREATE - neues Abfragefenster


/*

CREATE TABLE StadtLandFluss (
ID int,
Stadt int,
Land int )

INSERT INTO StadtLandFluss
SELECT 1, 10, 100
UNION ALL
SELECT 2, 20, 200
UNION ALL
SELECT 3, 30, 300

CREATE VIEW vSLF AS
SELECT * FROM StadtLandFluss

SELECT * FROM StadtLandFluss
SELECT * FROM vSLF

ALTER TABLE StadtLandFluss
ADD Fluss int

UPDATE StadtLandFluss
SET Fluss = ID*1000

SELECT * FROM StadtLandFluss
SELECT * FROM vSLF

ALTER TABLE StadtLandFluss
DROP COLUMN Land

CREATE VIEW vBesser AS
SELECT [ID], [Stadt], [Fluss] FROM StadtLandFluss

*/


