--Übungen

--1. Was war das meistverkaufte Produkt (ProductName) von Mitarbeiter "Buchanan"? Wieviel Stück insgesamt?
--Gorgonzola & Perth Pasties

SELECT TOP 1 WITH TIES ProductName, SUM(Quantity) as SumQuantity FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE LastName = 'Buchanan'
GROUP BY ProductName
ORDER BY SumQuantity DESC

--2. Wieviel Umsatz (Summe Rechnungsbeträge) haben wir in Q1 1998 mit Kunden aus den USA gemacht?

SELECT SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(QUARTER, OrderDate) = 1

--3. Wieviel Umsatz (Summe Rechnungsbeträge) haben wir in jedem Geschäftsjahr insgesamt gemacht?
--GROUP BY DATEPART..

SELECT DATEPART(YEAR, OrderDate) as Geschäftsjahr, SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY 1

--4. Jahrweiser Vergleich unserer 3 Spediteure (Shippers Tabelle über ShipVia): 
--   Lieferkosten (Freight) gesamt, Durchschnitt (Freight) pro Lieferung und Anzahl an Lieferungen

/* 
Ergebnis in etwa so:
SpediteurName, Geschäftsjahr, FreightGesamt, FreightAvg, AnzBestellungen
Sped 1		 , 1996			, xy		   , xy        , xy
Sped 1       , 1997			, xy		   , xy        , xy
Sped 1       , 1998			, xy		   , xy        , xy
Sped 2       , 1996			, xy		   , xy        , xy
usw...
*/

SELECT 
CompanyName,
DATEPART(YEAR, OrderDate) as Geschäftsjahr,
SUM(Freight) as SumFreight,
AVG(Freight) as AvgFreight,
COUNT(*) as AnzBest
FROM Shippers
JOIN Orders ON ShipVia = ShipperID
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
ORDER BY Geschäftsjahr, AvgFreight