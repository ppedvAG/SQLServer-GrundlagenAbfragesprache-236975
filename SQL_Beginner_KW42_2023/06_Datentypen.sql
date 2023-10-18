/*

Datentypen in SQL: 3 groﬂe Gruppen

Charakter/String Datentypen:

char(10) = Nico --> 'Nico      ' = 10 Byte Speicherplatz
nchar()		=
varchar(10)	= Nico --> 'Nico'    = 4 Byte Speicherplatz
nvarchar()	=
binary = Bin‰rstring

Legacy: text 
--> mittlerweile varchar(MAX) = bis zu 2GB groﬂ (LOB Datentypen)
varchar(8000) sonst maximum
nvarchar(4000)


Numerische:

tinyint 8 bit - bis zu 255
smallint 16 bit - bis zu 32k
int 32 bit - bis 2,3 Mrd
bigint 64 bit

bit = 1 oder 0

decimal(x,y) = x Ziffern gesamt, davon sind y Nachkommastellen
float
money


Datum/Zeit:

time = 00h00m00s
date = YYYY/MM/DD
datetime = date + time bis in MS Bereich
datetime2 = bis in NS Bereich
smalldatetime = pr‰zise bis Sekunden Bereich


Andere:

XML
JSON
geometry
geography

*/