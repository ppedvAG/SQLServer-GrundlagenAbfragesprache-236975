/******************************************/

--Stored Procedures/gespeicherte Prozeduren

/******************************************/

/*
- Sind abgespeicherte SQL Anweisungen (nicht nur SELECT, sondern auch alles andere)
- Werden als DB Objekt auf der DB gespeichert
- Arbeiten mit Variablen (muss mindestens 1 Variable haben)
- Praktisch zum "modularisieren" von Code
- Procedures verwenden ihren QueryPlan jedes mal wieder (kein neu compile)
- Können im Job Agent verwendet werden (bspw. für automatisierte Prozesse)
*/

--Procedure erstellen:
CREATE PROCEDURE spRechnungByOrderID @OrderID int 
AS
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

--Procedure ausführen:
EXEC spRechnungByOrderID 10251

GO

--Beispielprocedure für INSERT
CREATE PROCEDURE spNewCustomer 
@CustomerID char(5), @CompanyName varchar(40), 
@Country varchar(40), @City varchar(40)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)

EXEC spNewCustomer PPEDV, 'ppedv AG', 'Germany', Burghausen

SELECT * FROM Customers WHERE CustomerID = 'ppedv'

--Alternative Aufrufmöglichkeit:
EXEC spNewCustomer
@CustomerID = 'EDEKA', @Country = 'Germany', @City = 'München', @CompanyName = 'Edeka'

--Default Wert bei Procedures:
CREATE PROCEDURE spKundenNachLandCity @Country varchar(50) = 'Germany', @City varchar(50) = 'Berlin'
AS
SELECT * FROM Customers WHERE Country = @Country AND City = @City

EXEC spKundenNachLandCity France, Paris


/******************************************/

--Variablen allgemein

/******************************************/

DECLARE @OrderID int = 10250, @var2 int, @var3 int --DECLARE Zeile muss immer mit ausgeführt werden!

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

SET @OrderID = 10251 --ändern von Variablenwerten im Skript mit SET Befehl

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID


