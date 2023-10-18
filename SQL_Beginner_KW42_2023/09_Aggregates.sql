/******************************************/

--Aggregatfunktionen

/******************************************/

--grundsätzlich 5 verschiedene Funktionen

SELECT 
SUM(Freight) as Summe, 
MIN(Freight) as Minimum, 
MAX(Freight) as Maximum,
AVG(Freight) as Durchschnitt,
COUNT(ShippedDate) as ZähleSpalte, COUNT(*) as ZähleAlles
FROM Orders

SELECT SUM(Freight) / COUNT(*) FROM Orders


SELECT CustomerID, SUM(Freight) FROM Orders

--Lösung über GROUP BY:

--Freight Summe pro CustomerID:
SELECT CustomerID, SUM(Freight) as Summe FROM Orders
GROUP BY CustomerID

--Freight Summe pro ShipCountry:
SELECT ShipCountry, SUM(Freight) FROM Orders
GROUP BY ShipCountry

--Quantity Summe pro ProductID:
SELECT ProductID, SUM(Quantity) as SummeStückzahl FROM [Order Details]
GROUP BY ProductID

--Quantity Summe pro ProductName:
SELECT ProductName, SUM(Quantity) as SummeStückzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName

--Quantity Summe pro ProductName für Produkte der Kategorien 1-4:
SELECT ProductName, SUM(Quantity) as SummeStückzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
ORDER BY SummeStückzahl DESC

--Summe Freight nach CompanyName:
SELECT CompanyName, Country, City, SUM(Freight) as SummeFreight FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY CompanyName, Country, City

SELECT CompanyName, Country, City, EmployeeID, SUM(Freight) as SummeFreight FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY CompanyName, Country, City, EmployeeID

SELECT CompanyName, Country, City, EmployeeID, COUNT(EmployeeID) as SummeFreight FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY CompanyName, Country, City, EmployeeID

--Vorsicht beim Gruppieren! Wenn Order Details dabei ist, sind die Freight Summen zu hoch!
SELECT FirstName + ' ' + LastName as Mitarbeiter, SUM(Freight) as FreightSumme FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
--JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY FirstName + ' ' + LastName

--Merke: ALLES was im SELECT steht, und KEIN Aggregate --> Copy Paste ins Group By

--Übungen

--1. Verkaufte Stückzahlen (Quantity) pro ProduktKategorie (CategoryName) (8 Ergebniszeilen)
SELECT CategoryName, SUM(Quantity) FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName

--2. Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
SELECT LastName, COUNT(OrderID) FROM Employees 
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName
ORDER BY 2 DESC


--Verkaufte Stückzahlen pro Produkt, aber nur über 1000
--Geht so nicht:
SELECT ProductName as Produkt, SUM(Quantity) as SummeStückzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeStückzahl DESC

--Lösung über HAVING:
SELECT ProductName as Produkt, SUM(Quantity) as SummeStückzahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStückzahl DESC

--HAVING funktioniert 1 zu 1 wie WHERE, kann aber gruppierte/aggregierte Werte nachträglich filtern

--Aber: Nur HAVING verwenden wenn im WHERE nicht möglich!!!

SELECT CompanyName, Country, City, SUM(Freight) as SummeFreight FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY CompanyName, Country, City
HAVING Country = 'Germany'

SELECT CompanyName, Country, City, SUM(Freight) as SummeFreight FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Germany'
GROUP BY CompanyName, Country, City


--Rechnungen vorbereiten:

--Wert der Bestellpositionen (Order Details) berechnen:
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

