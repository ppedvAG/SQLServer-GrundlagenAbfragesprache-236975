/******************************************/

--CREATE/ALTER/DROP - DDL (Data Definition Language)
--Immer wenn wir Datenbankobjekte "bearbeiten" gelten diese Befehle

/******************************************/


--Neuen Table erstellen:
CREATE TABLE PurchasingOrders 
(
ID int identity(1,1) PRIMARY KEY,
OrderDate date NOT NULL,
ProductID int NOT NULL
)

--Beziehung zwischen PurchasingOrder und Products anlegen über ProductID:
ALTER TABLE PurchasingOrders
ADD FOREIGN KEY (ProductID) REFERENCES Products (ProductID)

--Neue Spalte hinzufügen zu bestehendem Table:
ALTER TABLE PurchasingOrders
ADD Quantity int

--Spalte aus bestehendem Table löschen:
ALTER TABLE PurchasingOrders
DROP COLUMN NeueSpalte

--Tabelle löschen:
DROP TABLE PurchasingOrders


/******************************************/

--INSERT - Hinzufügen neuer Datensätze zu bestehendem Table

/******************************************/

--Alle Spalten befüllen:
INSERT INTO PurchasingOrders
VALUES ('20231018', 5)

--Explizit einzelne Spalten befüllen:
INSERT INTO PurchasingOrders (OrderDate, ProductID)
VALUES ('20231018', 3)

--Ergebnisse einer SELECT Abfrage können direkt Inserted werden (Wenn Spaltenanzahl passt & Datentypen kompatibel)
INSERT INTO PurchasingOrders
SELECT GETDATE(), 3, NULL

--"Kopie" einer Tabelle als neue Tabelle anlegen:
SELECT * INTO InvoicesTable FROM vRechnungsDaten

INSERT INTO InvoicesTable
SELECT * FROM vRechnungsDaten

INSERT INTO InvoicesTable
SELECT * FROM InvoicesTable

--Auch Cross-Database möglich:
SELECT * INTO AdvancedTesting.dbo.CustomersBackup FROM Customers
SELECT * INTO Northwind.dbo.TriggerTest FROM AdvancedTesting.dbo.TriggerTest


/******************************************/

--DELETE - Löschen von Datensätzen in einem bestehendem Table

/******************************************/

--Aufpassen! Ohne WHERE Filter werden ALLE Datensätze gelöscht! Am besten immer Filter über PK
DELETE FROM PurchasingOrders
WHERE ID = 4

--Primär-/Fremdschlüsselbeziehungen verhindern das löschen von Datensätzen, wenn andere Datensätze
--sonst "ins Leere laufen würden"
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

DELETE FROM Products
WHERE ProductID = 3 

/******************************************/

--UPDATE - Ändern von Spaltenwerten in einem vorhandenen Datensatz

/******************************************/

SELECT * FROM PurchasingOrders

--Genauso wie bei DELETE; Aufpassen, wenn kein WHERE Filter dann werden ALLE Datensätze geupdatet!
UPDATE PurchasingOrders
SET Quantity = 25
WHERE ID = 2

--"Löschen" von Werten: SET = NULL
UPDATE Customers
SET ContactName = NULL
WHERE CustomerID = 'ALFKI'

SELECT * FROM Customers


/******************************************/

--CONSTRAINTS in Tabellen

/******************************************/
--IntelliSense Cache refreshen mit STRG+SHIFT+R

SELECT * FROM PurchasingOrders

INSERT INTO PurchasingOrders
VALUES (GETDATE(), 15, -40)

--Quantity soll nur positive Werte akzeptieren, Lösung über CHECK Constraint

ALTER TABLE PurchasingOrders
ADD CONSTRAINT CHK_Quantity CHECK (Quantity > 0)

UPDATE PurchasingOrders
SET Quantity = 40
WHERE ID = 5

INSERT INTO PurchasingOrders
VALUES (GETDATE(), 15, -40)



/******************************************/

--Transactions

/******************************************/

--SQL Server ist ein transaktionales DB System
-->JEDE Abfrage/Anweisung ist ein sog. Transaktion

BEGIN TRANSACTION --öffnet manuell eine neue Transaktion

SELECT @@TRANCOUNT --gibt aktuelles Transaktionslevel aus (0 = keine Transaktion)

UPDATE Customers
Set City = 'Käse'

COMMIT --schließt Transaktion und "bestätigt" Änderungen
ROLLBACK --schließt Transaktion und macht Änderungen rückgängig

SELECT * FROM customers