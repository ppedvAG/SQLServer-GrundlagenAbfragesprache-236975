/******************************************/

--CASE - definiert WHEN Bedingungen, die gewissen Ausgabewert haben, wenn Bedingung zutrifft

/******************************************/

--mindestens eine WHEN Bedingung n�tig

SELECT *, 
CASE --er�ffnet "Case-block"
WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
WHEN UnitsInStock >= 10 THEN 'Passt.'
END as Pr�fung --END schlie�t "Case-block"
FROM Products

SELECT *, 
CASE
WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
WHEN UnitsInStock >= 10 THEN 'Passt.'
END as Pr�fung, 'test'
FROM Products

--Wenn ein Fall gefunden wird, der nicht abgedeckt ist: Ergebnis NULL
SELECT *, 
CASE
WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
WHEN UnitsInStock > 10 THEN 'Passt.'
END as Pr�fung
FROM Products

--Alternativ mit ELSE einen "Notausgang" definieren:
SELECT *, 
CASE
WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
WHEN UnitsInStock > 10 THEN 'Passt.'
ELSE 'Fehler'
END as Pr�fung
FROM Products

--Funktioniert auch in UPDATE:
UPDATE Customers
SET City = 
CASE 
WHEN Country = 'Germany' THEN 'Berlin'
WHEN Country = 'France' THEN 'Paris'
ELSE City
END

--Auch im GROUP BY:
SELECT SUM(UnitsInStock), 
CASE
WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
WHEN UnitsInStock > 10 THEN 'Passt.'
ELSE 'Fehler'
END as Pr�fung
FROM Products
GROUP BY
CASE
WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
WHEN UnitsInStock > 10 THEN 'Passt.'
ELSE 'Fehler'
END