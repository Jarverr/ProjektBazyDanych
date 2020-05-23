USE ListaPrzebojów
GO
--GATUNKI
INSERT INTO Gatunki VALUES (1,'Metal','19650101','USA/UK'),(2,'Jazz','19100101','Nowy Orlean');

--ALBUMY
INSERT INTO Albumy VALUES (1,'Tha art of War','20080530','20070801','Black Lodge Records'),(2,'Tutu','19860901',Null,'Marcus MillerTommy LiPuma');

--NAGRODY
INSERT INTO Nagrody VALUES(1,'Grammis Award for Hard Rock/Metal of the Year',NULL,'19900221'),(2,'Nagroda Grammy','Najlepsza solowa improwizacja jazzowa','19590101');

--WYKONAWCY
INSERT INTO Wykonawcy VALUES (1,'Sabaton','19990101','Zespol'),(2,'Miles Davis','19260526','trebacz, lider, kompozytor')

--OCENY
INSERT INTO Oceny VALUES (1,9,3,'Dobry kawalek o mestwie i wojnie'),(2,9,7,'Stare przeboje');

--UTWORY
INSERT INTO Utwory VALUES ( 1,'40:1','20080520',NULL,'4:11',1,1,1),(2,'Tutu','19860901','Stary jazzowy kawalek, z trabka','5:18',2,2,2);
INSERT INTO NalezyDoGatunku VALUES (1,1),(2,2)
INSERT INTO OtrzymanieNagrody VALUES (1,1),(2,2)