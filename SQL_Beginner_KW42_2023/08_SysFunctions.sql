/******************************************/

--Datums- & Zeitfunktionen

/******************************************/

SELECT OrderDate FROM Orders

--Aktuelle Systemzeit:
SELECT GETDATE()

-- SELECT YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate), OrderDate FROM Orders

--"Zieht" ein gewünschtes Intervall aus einem Datum 
SELECT 
DATEPART(YEAR, OrderDate) as Jahr, 
DATEPART(QUARTER, OrderDate) as Quartal, 
DATEPART(WEEK, OrderDate) as KW,
DATEPART(WEEKDAY, OrderDate) as Wochentag, 
DATEPART(ISO_WEEK, OrderDate) as IsoWeek, 
DATEPART(HOUR, OrderDate) as Stunde
FROM Orders

--Zieht den IntervallNamen aus einem Datum
SELECT DATENAME(MONTH, OrderDate), DATENAME(WEEKDAY, OrderDate), DATEPART(WEEKDAY, OrderDate) FROM Orders

--Intervall zu einem Datum addieren/subtrahieren:
SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(DAY, -14, GETDATE())

--Differenz in Intervall xy zwischen 2 Datum
SELECT DATEDIFF(DAY, '19930224', GETDATE())
SELECT DATEDIFF(YEAR, OrderDate, GETDATE()) FROM Orders

--SQL Server 2022 neue Functions:
DATETRUNC, DATE_BUCKET()

SELECT * FROM Orders
WHERE OrderDate >= DATEADD(DAY, -31, GETDATE())


/******************************************/

--StringFunctions

/******************************************/

--CONCAT: Fügt Strings in eine Spalte zusammen:

SELECT CONCAT(FirstName, ' ', LastName, ' ', 100) as GanzerName FROM Employees

SELECT FirstName + ' ' + LastName + '100' FROM Employees


/******************************************/

--OtherFunctions

/******************************************/

--CAST oder CONVERT, wandeln Datentyp in der ausgabe um

SELECT CAST(OrderDate as date) FROM Orders
SELECT CONVERT(date, OrderDate) FROM Orders

--ISNULL prüft auf NULL Werte und ersetzt diese wenn gewünscht

SELECT ISNULL(Fax, 'n/a'), Fax FROM Customers


