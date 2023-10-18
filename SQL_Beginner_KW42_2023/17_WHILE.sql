/******************************************/

--WHILE - leitet eine Schleifenanweisung ein

/******************************************/

--Alles was in einer WHILE Schleife zwischen BEGIN & END steht, wird solange wiederholt, bis WHILE Bedingung nicht mehr zutrifft

--Endlosschleife:

WHILE 1=1 --Bedingung
BEGIN --Schleifenstart
SELECT 'Hallo!' --Schleifenanweisung
END --Schleifenende

--Dynamische WHILE Bedingung über Variablen:
DECLARE @Counter int = 0

WHILE @Counter <= 5
BEGIN
SELECT @Counter
SET @Counter = @Counter + 1 --zählt Variable innerhalb der Schleife hoch
END
SELECT 'Ende'

--WHILE Loops können ineinander verschachtelt sein


--Zusätzliche IF Prüfung innerhalb der WHILE Schleife:

DECLARE @Counter int = 0

WHILE @Counter <= 5
BEGIN

IF @Counter = 2 BEGIN SELECT 'Bin bei 2' END
ELSE BEGIN SELECT @Counter END

SET @Counter = @Counter + 1

END
SELECT 'Ende'


