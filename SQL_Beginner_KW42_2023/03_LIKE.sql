/******************************************/

--LIKE - im WHERE statt boolschen Vergleichsoperatoren; Filtert nach "ungenauen" Eingaben

/******************************************/

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Manager%'

--"Wildcards" - Platzhaltersymbole

--"%" = egal welche Symbole, egal wieviele davon

SELECT CompanyName FROM Customers
WHERE CompanyName LIKE 'B%'

SELECT CompanyName FROM Customers
WHERE CompanyName LIKE 'Berg%'

--"_" = egal welches Symbol, aber nur EINES

SELECT CompanyName FROM Customers
WHERE CompanyName LIKE 'B_r%'

SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_r%'

--"[]" = alle Symbole in den Klammern g�ltig, an dieser EINEN Stelle

SELECT * FROM Customers
WHERE PostalCode LIKE '[012345]%'

SELECT * FROM Customers
WHERE CompanyName LIKE '[ABCD]%'

--[^]: alles in der Klammer ist NICHT g�ltig
SELECT * FROM Customers
WHERE CompanyName LIKE '[^ABCD]%'

--[x-y]: "alles g�ltig von x bis y"
SELECT * FROM Customers
WHERE PostalCode LIKE '[0-5]%'

--Sonderf�lle:
SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%''%'

