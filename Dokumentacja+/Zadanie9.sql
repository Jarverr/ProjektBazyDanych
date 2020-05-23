USE ListaPrzebojów
GO

-- Kod wspomagaj¹cy aplikacje u¿ytkowa - funkcje
DROP FUNCTION IF EXISTS dbo.f_OcenaAdministratoraWiekszaNiz5
GO
CREATE FUNCTION f_OcenaAdministratoraWiekszaNiz5 ()
RETURNS TABLE
		AS
		RETURN
			(
			SELECT * FROM Utwory INNER JOIN Oceny on oceny.IdOceny=Utwory.OcenaId
			where OcenaAdministratora>5
			);

		GO

DROP FUNCTION IF EXISTS dbo.f_NajlepszeUtworyOcenaAdministratoraRowna10 
GO
CREATE FUNCTION f_NajlepszeUtworyOcenaAdministratoraRowna10 ()
RETURNS TABLE
		AS
		RETURN
			(
			SELECT * FROM Utwory INNER JOIN Oceny on oceny.IdOceny=Utwory.OcenaId
			where OcenaAdministratora=10
			);

		GO

DROP FUNCTION IF EXISTS dbo.f_WszystkieDane
GO
CREATE FUNCTION f_WszystkieDane ()
RETURNS TABLE
		AS
		RETURN
			(
		SELECT u.IdUtworu,u.AlbumId,u.WykonawcaId,u.OcenaId,ndo.IdGatunku,ng.IdNagrody,
		u.NazwaUtworu,u.DataWykonanania,u.D³ugoœæ,u.OpisUtworu,
		o.OcenaAdministratora,o.OcenaAdministratorki,o.Komentarz,
		a.NazwaAlbumu,a.RozpoczêcieNagrañ,a.DataWydania,a.Wydawnictwo,
		w.Wykonawca,w.DataUrodzeniaPowstania,w.RolaWykonawcy,
		g.NazwaGatunku,g.DataPowstania,g.MiejscePowstania,
		n.NazwaNagrody,n.PierwszeWrêczenie,n.Kategoria
		FROM Utwory u JOIN oceny o ON u.IdUtworu=o.IdOceny
		JOIN Albumy a ON a.IdAlbum=u.AlbumId
		JOIN Wykonawcy w ON w.IdWykonawcy=u.WykonawcaId
		JOIN NalezyDoGatunku ndo ON ndo.IdUtworu=u.IdUtworu
		JOIN Gatunki g ON g.IdGatunku=ndo.IdGatunku
		JOIN OtrzymanieNagrody ng ON ng.IdUtworu=u.IdUtworu
		JOIN Nagrody n ON n.IdNagrody=ng.IdNagrody
		);
GO


DROP FUNCTION IF EXISTS dbo.f_UtworyZNagrodami
GO
CREATE FUNCTION f_UtworyZNagrodami ()
RETURNS TABLE
		AS
		RETURN
			(
		
SELECT u.IdUtworu,u.NazwaUtworu,u.DataWykonanania,u.D³ugoœæ,u.OpisUtworu,n.NazwaNagrody,onag.DataOtrzymania FROM Utwory u INNER JOIN OtrzymanieNagrody onag on onag.IdUtworu=u.IdUtworu
INNER JOIN Nagrody n on n.IdNagrody=onag.IdNagrody
where onag.IdUtworu IS NOT NULL
		);
GO


DROP FUNCTION IF EXISTS dbo.f_wykonawcyIIchGatunkui
GO
CREATE FUNCTION f_wykonawcyIIchGatunkui ()
RETURNS TABLE
		AS
		RETURN
			(
SELECT w.Wykonawca, g.NazwaGatunku, g.MiejscePowstania, g.DataPowstania FROM Wykonawcy w inner join Utwory u on u.WykonawcaId=w.IdWykonawcy
INNER JOIN NalezyDoGatunku a on a.IdUtworu=u.IdUtworu
INNER JOIN Gatunki g on g.IdGatunku=a.IdGatunku

		);
GO
