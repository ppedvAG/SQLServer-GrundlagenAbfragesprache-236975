/******************************************/

--Joins - "verbinden" Datens‰tze von Tabellen miteinander ins selbe Ergebnisfenster

/******************************************/

SELECT * FROM Orders

SELECT * FROM Customers
WHERE CustomerID = 'HANAR'

--Join Syntax:

SELECT OrderID, CompanyName, OrderDate, Freight FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID

SELECT OrderID, CompanyName, OrderDate, Freight FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID

-- SELECT Spalten FROM TabelleA JOIN TabelleB ON TabellaA.Spalte = TabelleB.Spalte

SELECT LastName, FirstName, Orders.* FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.Country = 'Germany'


--‹bungen:

--1. Alle Bestellungen (Orders) die der Mitarbeiter "King" (LastName in Employees) bearbeitet hat
SELECT * FROM Orders 
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 
WHERE LastName = 'King'

--2. Alle Bestellungen (Orders) aus Frankreich (Customers), deren Lieferkosten (Freight) ¸ber 300 lag
SELECT * FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE Country = 'France' AND Freight > 300

--3. Welche verschiedenen Produkte (ProductName in Products) wurden in Austria verkauft?
--Tables: Customers --> Orders --> Order Details --> Products
SELECT DISTINCT ProductName FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
WHERE c.Country = 'Austria'

--Alles INNER JOINS 

/******************************************/

--OUTER Joins - siehe Venn Diagramm in den Unterlagen

/******************************************/

--LEFT/RIGHT Join = Zeigt Tabelle A oder B vollst‰ndig an (zus‰tzlich zur Schnittmenge)

SELECT *
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
--> 2 Ergebnisse mehr (832) --> 2 Customer die noch nie bestellt haben

SELECT *
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL
--> "invertierter" Join durch KeySpalte IS NULL --> nur noch die "Ausreiﬂer"

--FULL OUTER JOIN = Left + Right gleichzeitig
SELECT * FROM Customers FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID

--(CROSS JOIN) = Erstellt kartesisches Produkt AxB - braucht man quasi nie
SELECT * FROM Customers CROSS JOIN Orders

--"SELF JOIN" (=Inner join)

--Wer reportet an wen? (Name Mitarbeiter & Name vom Vorgesetzten)
SELECT Mitarbeiter.EmployeeID, Mitarbeiter.LastName, Vorgesetzte.EmployeeID, Vorgesetzte.LastName
FROM Employees as Mitarbeiter LEFT JOIN Employees as Vorgesetzte 
ON Mitarbeiter.ReportsTo = Vorgesetzte.EmployeeID

SELECT EmployeeID, ReportsTo FROM Employees
