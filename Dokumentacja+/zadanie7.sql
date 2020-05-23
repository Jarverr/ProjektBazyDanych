USE [ListaPrzebojów]
GO

--wyzwalacze
CREATE TRIGGER tooLateDataErrorAlbums ON Albumy
FOR INSERT
NOT FOR REPLICATION
AS
IF(SELECT COUNT(*) FROM inserted)>=1
	BEGIN
		IF((SELECT DataWydania from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data wydania nie mo¿e byæ póŸniejsza ni¿ data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
		IF((SELECT RozpoczêcieNagrañ from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data rozpoczêcia nagrañ nie mo¿e byæ póŸniejsza ni¿ data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
	END
GO
	
CREATE TRIGGER tooLateDataErrorGatunki ON Gatunki
FOR INSERT
NOT FOR REPLICATION
AS
IF(SELECT COUNT(*) FROM inserted)>=1
	BEGIN
		IF((SELECT DataPowstania from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data powstania nie mo¿e byæ póŸniejsza ni¿ data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
	END
GO

CREATE TRIGGER tooLateDataErrorNagrody ON Nagrody
FOR INSERT
NOT FOR REPLICATION
AS
IF(SELECT COUNT(*) FROM inserted)>=1
	BEGIN
		IF((SELECT PierwszeWrêczenie from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data pierwszêgo wrêczenia nie mo¿e byæ póŸniejsza ni¿ data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
		
	END
GO
	
CREATE TRIGGER tooLateDataErrorOtrzymaneNagrody ON OtrzymanieNagrody
FOR INSERT
NOT FOR REPLICATION
AS
IF(SELECT COUNT(*) FROM inserted)>=1
	BEGIN
		IF((SELECT DataOtrzymania from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data wydania nie mo¿e byæ póŸniejsza ni¿ data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
		
	END

GO

CREATE TRIGGER tooLateDataErrorWykonawcy ON Wykonawcy
FOR INSERT
NOT FOR REPLICATION
AS
IF(SELECT COUNT(*) FROM inserted)>=1
	BEGIN
		IF((SELECT DataUrodzeniaPowstania from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data urodzenia/ powstania zespo³u nie mo¿e byæ póŸniejsza ni¿ data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
		
	END
GO

--komendy dodajaca w³aœæiwoœæ not null dla wybranych pól w bazie danych

ALTER TABLE dbo.Utwory ALTER COLUMN [NazwaUtworu] [nvarchar] NOT  NULL
GO
ALTER TABLE dbo.Gatunki ALTER COLUMN [NazwaGatunku] [nvarchar] NOT  NULL
GO
ALTER TABLE dbo.Albumy ALTER COLUMN [NazwaAlbumu] [nvarchar] NOT  NULL
GO
ALTER TABLE dbo.Wykonawcy ALTER COLUMN Wykonawca [nvarchar] NOT  NULL
GO

--odmowa dostêpu do danych dla administratora i administratorki oraz goscia
	DENY INSERT ON OBJECT::ListaPrzebojów.Oceny.OcenaAdministratorki To Administrator
	GO 
	
	DENY INSERT ON OBJECT::ListaPrzebojów.Oceny.OcenaAdministratora To Administratorka
	GO 

	DENY INSERT ON OBJECT::ListaPrzebojów TO guest
	