USE [ListaPrzeboj�w]
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
		RAISERROR('Data wydania nie mo�e by� p�niejsza ni� data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
		IF((SELECT Rozpocz�cieNagra� from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data rozpocz�cia nagra� nie mo�e by� p�niejsza ni� data dzisiejsza',16,1)
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
		RAISERROR('Data powstania nie mo�e by� p�niejsza ni� data dzisiejsza',16,1)
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
		IF((SELECT PierwszeWr�czenie from inserted)>GETDATE())
		BEGIN
		RAISERROR('Data pierwsz�go wr�czenia nie mo�e by� p�niejsza ni� data dzisiejsza',16,1)
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
		RAISERROR('Data wydania nie mo�e by� p�niejsza ni� data dzisiejsza',16,1)
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
		RAISERROR('Data urodzenia/ powstania zespo�u nie mo�e by� p�niejsza ni� data dzisiejsza',16,1)
		ROLLBACK TRANSACTION
		END
		
	END
GO

--komendy dodajaca w�a��iwo�� not null dla wybranych p�l w bazie danych

ALTER TABLE dbo.Utwory ALTER COLUMN [NazwaUtworu] [nvarchar] NOT  NULL
GO
ALTER TABLE dbo.Gatunki ALTER COLUMN [NazwaGatunku] [nvarchar] NOT  NULL
GO
ALTER TABLE dbo.Albumy ALTER COLUMN [NazwaAlbumu] [nvarchar] NOT  NULL
GO
ALTER TABLE dbo.Wykonawcy ALTER COLUMN Wykonawca [nvarchar] NOT  NULL
GO

--odmowa dost�pu do danych dla administratora i administratorki oraz goscia
	DENY INSERT ON OBJECT::ListaPrzeboj�w.Oceny.OcenaAdministratorki To Administrator
	GO 
	
	DENY INSERT ON OBJECT::ListaPrzeboj�w.Oceny.OcenaAdministratora To Administratorka
	GO 

	DENY INSERT ON OBJECT::ListaPrzeboj�w TO guest
	