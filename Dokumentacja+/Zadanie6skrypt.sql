USE [master]
GO
/****** Object:  Database [ListaPrzebojów]    Script Date: 23.05.2020 17:59:36 ******/
CREATE DATABASE [ListaPrzebojów]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ListaPrzebojów', FILENAME = N'C:\Users\games\ListaPrzebojów.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ListaPrzebojów_log', FILENAME = N'C:\Users\games\ListaPrzebojów_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ListaPrzebojów] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ListaPrzebojów].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ListaPrzebojów] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET ARITHABORT OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ListaPrzebojów] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ListaPrzebojów] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ListaPrzebojów] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ListaPrzebojów] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ListaPrzebojów] SET  MULTI_USER 
GO
ALTER DATABASE [ListaPrzebojów] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ListaPrzebojów] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ListaPrzebojów] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ListaPrzebojów] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ListaPrzebojów] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ListaPrzebojów] SET QUERY_STORE = OFF
GO
USE [ListaPrzebojów]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ListaPrzebojów]
GO
/****** Object:  User [Administratorka]    Script Date: 23.05.2020 17:59:36 ******/
CREATE USER [Administratorka] FOR LOGIN [ListaPrzebojowKonto2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Administrator]    Script Date: 23.05.2020 17:59:36 ******/
CREATE USER [Administrator] FOR LOGIN [ListaPrzebojowKonto] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Oceny]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oceny](
	[IdOceny] [int] NOT NULL,
	[OcenaAdministratora] [char](2) NOT NULL,
	[OcenaAdministratorki] [char](2) NULL,
	[Komentarz] [varchar](100) NULL,
 CONSTRAINT [PK_Oceny] PRIMARY KEY CLUSTERED 
(
	[IdOceny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Utwory]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Utwory](
	[IdUtworu] [int] NOT NULL,
	[NazwaUtworu] [nvarchar](50) NOT NULL,
	[DataWykonanania] [datetime] NULL,
	[OpisUtworu] [nvarchar](100) NULL,
	[Długość] [char](5) NULL,
	[WykonawcaId] [int] NOT NULL,
	[AlbumId] [int] NOT NULL,
	[OcenaId] [int] NULL,
 CONSTRAINT [PK_Utwory] PRIMARY KEY CLUSTERED 
(
	[IdUtworu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_NajlepszeUtworyOcenaAdministratoraRowna10]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_NajlepszeUtworyOcenaAdministratoraRowna10] ()
RETURNS TABLE
		AS
		RETURN
			(
			SELECT * FROM Utwory INNER JOIN Oceny on oceny.IdOceny=Utwory.OcenaId
			where OcenaAdministratora=10
			);

GO
/****** Object:  UserDefinedFunction [dbo].[f_OcenaAdministratoraWiekszaNiz5]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_OcenaAdministratoraWiekszaNiz5] ()
RETURNS TABLE
		AS
		RETURN
			(
			SELECT * FROM Utwory INNER JOIN Oceny on oceny.IdOceny=Utwory.OcenaId
			where OcenaAdministratora>5
			);

GO
/****** Object:  Table [dbo].[Gatunki]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gatunki](
	[IdGatunku] [int] NOT NULL,
	[NazwaGatunku] [nvarchar](20) NOT NULL,
	[DataPowstania] [datetime] NULL,
	[MiejscePowstania] [nvarchar](50) NULL,
 CONSTRAINT [PK_Gatunki] PRIMARY KEY CLUSTERED 
(
	[IdGatunku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtrzymanieNagrody]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtrzymanieNagrody](
	[IdUtworu] [int] NOT NULL,
	[IdNagrody] [int] NOT NULL,
	[DataOtrzymania] [datetime] NULL,
 CONSTRAINT [PK_OtrzymanieNagrody] PRIMARY KEY CLUSTERED 
(
	[IdUtworu] ASC,
	[IdNagrody] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NalezyDoGatunku]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NalezyDoGatunku](
	[IdUtworu] [int] NOT NULL,
	[IdGatunku] [int] NOT NULL,
 CONSTRAINT [PK_NalezyDoGatunku] PRIMARY KEY CLUSTERED 
(
	[IdUtworu] ASC,
	[IdGatunku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wykonawcy]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wykonawcy](
	[IdWykonawcy] [int] NOT NULL,
	[Wykonawca] [nvarchar](50) NOT NULL,
	[DataUrodzeniaPowstania] [date] NULL,
	[RolaWykonawcy] [varchar](50) NULL,
 CONSTRAINT [PK_Wykonawcy] PRIMARY KEY CLUSTERED 
(
	[IdWykonawcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nagrody]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nagrody](
	[IdNagrody] [int] NOT NULL,
	[NazwaNagrody] [nvarchar](50) NULL,
	[Kategoria] [varchar](50) NULL,
	[PierwszeWręczenie] [datetime] NULL,
 CONSTRAINT [PK_Nagrody] PRIMARY KEY CLUSTERED 
(
	[IdNagrody] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Albumy]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Albumy](
	[IdAlbum] [int] NOT NULL,
	[NazwaAlbumu] [nvarchar](50) NOT NULL,
	[DataWydania] [datetime] NULL,
	[RozpoczęcieNagrań] [datetime] NULL,
	[Wydawnictwo] [nvarchar](100) NULL,
 CONSTRAINT [PK_Albumy] PRIMARY KEY CLUSTERED 
(
	[IdAlbum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_WszystkieDane]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_WszystkieDane] ()
RETURNS TABLE
		AS
		RETURN
			(
		SELECT u.IdUtworu,u.AlbumId,u.WykonawcaId,u.OcenaId,ndo.IdGatunku,ng.IdNagrody,
		u.NazwaUtworu,u.DataWykonanania,u.Długość,u.OpisUtworu,
		o.OcenaAdministratora,o.OcenaAdministratorki,o.Komentarz,
		a.NazwaAlbumu,a.RozpoczęcieNagrań,a.DataWydania,a.Wydawnictwo,
		w.Wykonawca,w.DataUrodzeniaPowstania,w.RolaWykonawcy,
		g.NazwaGatunku,g.DataPowstania,g.MiejscePowstania,
		n.NazwaNagrody,n.PierwszeWręczenie,n.Kategoria
		FROM Utwory u JOIN oceny o ON u.IdUtworu=o.IdOceny
		JOIN Albumy a ON a.IdAlbum=u.AlbumId
		JOIN Wykonawcy w ON w.IdWykonawcy=u.WykonawcaId
		JOIN NalezyDoGatunku ndo ON ndo.IdUtworu=u.IdUtworu
		JOIN Gatunki g ON g.IdGatunku=ndo.IdGatunku
		JOIN OtrzymanieNagrody ng ON ng.IdUtworu=u.IdUtworu
		JOIN Nagrody n ON n.IdNagrody=ng.IdNagrody
		);
GO
/****** Object:  UserDefinedFunction [dbo].[f_UtworyZNagrodami]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_UtworyZNagrodami] ()
RETURNS TABLE
		AS
		RETURN
			(
		
SELECT u.IdUtworu,u.NazwaUtworu,u.DataWykonanania,u.Długość,u.OpisUtworu,n.NazwaNagrody,onag.DataOtrzymania FROM Utwory u INNER JOIN OtrzymanieNagrody onag on onag.IdUtworu=u.IdUtworu
INNER JOIN Nagrody n on n.IdNagrody=onag.IdNagrody
where onag.IdUtworu IS NOT NULL
		);
GO
/****** Object:  UserDefinedFunction [dbo].[f_WykonawcyIIchAlbumy]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_WykonawcyIIchAlbumy] ()
RETURNS TABLE
		AS
		RETURN
			(
SELECT w.Wykonawca, a.NazwaAlbumu, a.RozpoczęcieNagrań, a.DataWydania FROM Wykonawcy w inner join Utwory u on u.WykonawcaId=w.IdWykonawcy
INNER JOIN Albumy a on a.IdAlbum=u.AlbumId

		);
GO
/****** Object:  UserDefinedFunction [dbo].[f_wykonawcyIIchGatunkui]    Script Date: 23.05.2020 17:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_wykonawcyIIchGatunkui] ()
RETURNS TABLE
		AS
		RETURN
			(
SELECT w.Wykonawca, g.NazwaGatunku, g.MiejscePowstania, g.DataPowstania FROM Wykonawcy w inner join Utwory u on u.WykonawcaId=w.IdWykonawcy
INNER JOIN NalezyDoGatunku a on a.IdUtworu=u.IdUtworu
INNER JOIN Gatunki g on g.IdGatunku=a.IdGatunku

		);
GO
ALTER TABLE [dbo].[NalezyDoGatunku]  WITH CHECK ADD  CONSTRAINT [FK_NalezyDoGatunku_Gatunki] FOREIGN KEY([IdGatunku])
REFERENCES [dbo].[Gatunki] ([IdGatunku])
GO
ALTER TABLE [dbo].[NalezyDoGatunku] CHECK CONSTRAINT [FK_NalezyDoGatunku_Gatunki]
GO
ALTER TABLE [dbo].[NalezyDoGatunku]  WITH CHECK ADD  CONSTRAINT [FK_NalezyDoGatunku_Utwory] FOREIGN KEY([IdUtworu])
REFERENCES [dbo].[Utwory] ([IdUtworu])
GO
ALTER TABLE [dbo].[NalezyDoGatunku] CHECK CONSTRAINT [FK_NalezyDoGatunku_Utwory]
GO
ALTER TABLE [dbo].[OtrzymanieNagrody]  WITH CHECK ADD  CONSTRAINT [FK_OtrzymanieNagrody_Nagrody] FOREIGN KEY([IdNagrody])
REFERENCES [dbo].[Nagrody] ([IdNagrody])
GO
ALTER TABLE [dbo].[OtrzymanieNagrody] CHECK CONSTRAINT [FK_OtrzymanieNagrody_Nagrody]
GO
ALTER TABLE [dbo].[OtrzymanieNagrody]  WITH CHECK ADD  CONSTRAINT [FK_OtrzymanieNagrody_Utwory] FOREIGN KEY([IdUtworu])
REFERENCES [dbo].[Utwory] ([IdUtworu])
GO
ALTER TABLE [dbo].[OtrzymanieNagrody] CHECK CONSTRAINT [FK_OtrzymanieNagrody_Utwory]
GO
ALTER TABLE [dbo].[Utwory]  WITH CHECK ADD  CONSTRAINT [FK_Utwory_Albumy] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Albumy] ([IdAlbum])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Utwory] CHECK CONSTRAINT [FK_Utwory_Albumy]
GO
ALTER TABLE [dbo].[Utwory]  WITH CHECK ADD  CONSTRAINT [FK_Utwory_Oceny] FOREIGN KEY([OcenaId])
REFERENCES [dbo].[Oceny] ([IdOceny])
GO
ALTER TABLE [dbo].[Utwory] CHECK CONSTRAINT [FK_Utwory_Oceny]
GO
ALTER TABLE [dbo].[Utwory]  WITH CHECK ADD  CONSTRAINT [FK_Utwory_Wykonawcy] FOREIGN KEY([WykonawcaId])
REFERENCES [dbo].[Wykonawcy] ([IdWykonawcy])
GO
ALTER TABLE [dbo].[Utwory] CHECK CONSTRAINT [FK_Utwory_Wykonawcy]
GO
USE [master]
GO
ALTER DATABASE [ListaPrzebojów] SET  READ_WRITE 
GO
