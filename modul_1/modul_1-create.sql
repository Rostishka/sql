SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
--
USE [MASTER]
GO
/****** Test DB ******/
CREATE DATABASE [TEST]
GO
--
--
--
USE [TEST]
GO
/****** Table tProducts ******/
CREATE TABLE [dbo].[tProducts](
	[pInstance] [int] IDENTITY(1,1) NOT NULL,
	[pName] [varchar](50) NOT NULL,
	[pBarCode] [nchar](10) NULL,
	[pPrice] [money] NOT NULL,
	[pNumber] [int] NOT NULL,
	[pComment] [varchar](250) NULL,
 CONSTRAINT [PK_tProducts] PRIMARY KEY ([pInstance]),
 CONSTRAINT [UK_tProducts] UNIQUE ([pName])) ON [PRIMARY]
GO
/****** Table tClients ******/
CREATE TABLE [dbo].[tClients](
	[cInstance] [int] IDENTITY(1,1) NOT NULL,
	[cName] [varchar](50)  NOT NULL,
	[cAddress] [varchar](50)  NULL,
	[cAmount] [money] NOT NULL,
	[cComment] [varchar](250)  NULL,
 CONSTRAINT [PK_tClients] PRIMARY KEY ([cInstance]),
 CONSTRAINT [UK_tClients] UNIQUE ([cName])) ON [PRIMARY]
GO

/****** Table tDocTypes ******/
CREATE TABLE [dbo].[tDocTypes](
	[tInstance] [smallint] IDENTITY(1,1) NOT NULL,
	[tName] [varchar](50)  NOT NULL,
	[tComment] [varchar](250)  NULL,
 CONSTRAINT [PK_tDocTypes] PRIMARY KEY ([tInstance]),
 CONSTRAINT [UK_tDocTypes] UNIQUE ([tName])) ON [PRIMARY]
GO

/****** Table tDocuments ******/
CREATE TABLE [dbo].[tDocuments](
	[dInstance] [int] IDENTITY(1,1) NOT NULL,
	[dType] [smallint] NOT NULL,
	[dNumber] [varchar](10) NOT NULL,
	[dDate] [datetime] NOT NULL,
	[dClient] [int] NOT NULL,
	[dAmount] [money] NOT NULL,
	[dComment] [varchar](250) NULL,
 CONSTRAINT [PK_tDocuments] PRIMARY KEY ([dInstance]),
 CONSTRAINT [UK_tDocuments] UNIQUE ([dType],[dNumber])) ON [PRIMARY]
GO

/****** Table tDocDetails ******/
CREATE TABLE [dbo].[tDocDetails](
	[sInstance] [int] IDENTITY(1,1) NOT NULL,
	[sDocument] [int] NOT NULL,
	[sProduct] [int] NOT NULL,
	[sNumber] [int] NOT NULL,
 CONSTRAINT [PK_tDocDetails] PRIMARY KEY ([sInstance]),
 CONSTRAINT [UK_tDocDetails] UNIQUE ([sDocument],[sProduct])) ON [PRIMARY]
GO


/****** Add foreing key ******/
ALTER TABLE [dbo].[tDocuments] WITH CHECK 
	ADD CONSTRAINT [FK_tDocuments_tClients] FOREIGN KEY([dClient])
REFERENCES [dbo].[tClients] ([cInstance])
GO
ALTER TABLE [dbo].[tDocuments] WITH CHECK 
	ADD CONSTRAINT [FK_tDocuments_tDocTypes] FOREIGN KEY([dType])
REFERENCES [dbo].[tDocTypes] ([tInstance])
GO
ALTER TABLE [dbo].[tDocDetails] WITH CHECK
	ADD CONSTRAINT [FK_tDocDetails_tDocuments] FOREIGN KEY([sDocument])
REFERENCES [dbo].[tDocuments] ([dInstance])
GO
ALTER TABLE [dbo].[tDocDetails] WITH CHECK
	ADD CONSTRAINT [FK_tDocDetails_tProducts] FOREIGN KEY([sProduct])
REFERENCES [dbo].[tProducts] ([pInstance])
GO
