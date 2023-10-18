/******************************************/

--WHERE - Filtert die Ergebnismenge nach einem oder mehreren Kriterien - syntaktisch nach dem FROM

/******************************************/
USE Northwind

SELECT * FROM Customers
WHERE Country = 'Germany' --Wichtig weil Country ein Charakterdatentyp ist, Werte in Hochkommas!

--Mit = Operator nur EXAKTE Treffer
SELECT * FROM Customers
WHERE City = ' Paris'

--WHERE Bedingungen funktionieren mit allen "boolschen" Vergleichsoperatoren
--> >, >=, <, <=, =, !=
SELECT * FROM Orders
WHERE Freight > 100

SELECT * FROM Orders
WHERE Freight < 100

SELECT * FROM Customers
WHERE Country != 'Germany' --"ungleich" Germany

--Mehr als eine Bedingung mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'France' OR Country = 'Brazil'

SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

--BETWEEN gibt eine Reichweite an, Grenzwerte mit inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

--IN Operator fasst mehrere OR Bedingungen zusammen
SELECT * FROM Customers
WHERE Country = 'France' OR Country = 'Brazil' OR Country = 'Austria' OR Country = 'Germany'

--> kürzer:
SELECT * FROM Customers
WHERE Country IN ('France', 'brazil', 'AusTRia', 'Germany')


--Übungen:

--1. Alle Bestellungen (Orders) die nach Deutschland (ShipCountry) gingen
SELECT * FROM Orders
WHERE ShipCountry = 'Germany'

--2. Alle Kunden aus Deutschland oder Frankreich, die aus Berlin oder Paris sind - 3
SELECT * FROM Customers
WHERE (Country = 'Germany' OR Country = 'France') AND (City = 'Berlin' OR City = 'Paris')

--3. Alle Kunden die eine Fax Nummer hinterlegt haben (keine Fax Nummer --> NULL)
SELECT * FROM Customers
WHERE Fax IS NULL

SELECT * FROM Customers
WHERE Fax IS NOT NULL

--4. Alle Ansprechpartner (ContactNames) die im Jobtitel (ContactTitle) "Manager" haben
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'