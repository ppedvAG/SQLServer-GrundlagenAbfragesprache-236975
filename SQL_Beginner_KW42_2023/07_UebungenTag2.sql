--Übungen

--1. Alle Produkte (ProductNames) aus den Kategorien "Beverages" und "Produce" (CategoryName in Categories)
--> Products - Categories; 17 & 17

SELECT * FROM Products
INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE CategoryName IN ('Beverages', 'Produce')

--2. Alle Bestellungen (Orders) bei denen ein Produkt verkauft wurde, das nicht mehr geführt wird
--(Discontinued = 1 in Products)
--> Orders - Order Details - Products; 228

SELECT DISTINCT [Order Details].OrderID FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE Discontinued = 1

--3. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
--(OrderDate in Orders) 'YYYYMMDD'
--> Customers - Orders; 60

SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND OrderDate BETWEEN '19970101' AND '19971231 00:00:00.000'

SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1997


--4. Welches Produkt (ProductName) hatte die größte Bestellmenge (Quantity in OD) im Februar 1998?

SELECT TOP 1 WITH TIES ProductName FROM Products  --WITH TIES übernimmt auch weitere Zeilen, wenn Gleichstand
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID 
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(MONTH, OrderDate) = 2 
ORDER BY Quantity DESC


--5. Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
--   Sind es mehr oder weniger als aus Frankreich? (2. Abfrage)

SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Spain' AND DATEPART(QUARTER, OrderDate) = 2 AND DATEPART(YEAR, OrderDate) = 1997
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'France' AND DATEPART(QUARTER, OrderDate) = 2 AND DATEPART(YEAR, OrderDate) = 1997


--6. Hatten wir Bestellungen, die wir zu spät ausgeliefert haben? Wenn ja, welche OrderIDs waren das und wieviele Tage
--   waren wir zu spät dran? (Verzögerung = Unterschied zwischen Shipped & Required Date in Orders) Tipp: DATEDIFF
/* 37
OrderID, "TageZuSpät"
OrderID, "TageZuSpät"
OrderID, "TageZuSpät"
usw...
*/
SELECT OrderID, DATEDIFF(DAY, RequiredDate, ShippedDate) as TageVerzoegerung FROM Orders
WHERE ShippedDate > RequiredDate
ORDER BY TageVerzoegerung DESC

SELECT OrderID, DATEDIFF(DAY, RequiredDate, ShippedDate) as TageVerzoegerung FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) > 0
ORDER BY TageVerzoegerung DESC

--Lieferungen die bis heute nicht geliefert wurden mit ISNULL "behandeln":
SELECT OrderID, DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) as TageVerzoegerung FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) > 0
ORDER BY TageVerzoegerung DESC


--7. Stellvertreterliste unserer Mitarbeiter erstellen (City in Employees ist die selbe) Tipp: SELF JOIN
/*
Mitarbeiter1, Stellvertreter1, London
Mitarbeiter1, Stellvertreter2, London
usw...
*/

SELECT Mitarbeiter.LastName, Mitarbeiter.City, Vertreter.LastName, Vertreter.City 
FROM Employees as Mitarbeiter
LEFT JOIN Employees as Vertreter ON Mitarbeiter.City = Vertreter.City AND Mitarbeiter.LastName != Vertreter.LastName
-- WHERE Mitarbeiter.LastName != Vertreter.LastName
