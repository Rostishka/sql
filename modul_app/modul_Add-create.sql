USE [master]
GO
if not exists(select 1 from sys.databases s where s.name = 'TEST_Cup')
	CREATE DATABASE [TEST_Cup]
GO
--
USE [TEST_Cup]
GO
--
-- Module Add
--
if not exists(select 1 from sys.objects s where s.name = 'fb_winners' and s.type = 'U')
	CREATE TABLE [dbo].[fb_winners](
		[cup_id] [smallint] NOT NULL,
		[cup_year] [int] NOT NULL,
		[club_id] [int] NOT NULL,
		[country_id] [smallint] NOT NULL
		)
--
if not exists(select 1 from sys.objects s where s.name = 'fb_cups' and s.type = 'U')
	CREATE TABLE [dbo].[fb_cups](
		[cup_id] [smallint] NOT NULL IDENTITY(1,1),
		[cup_name] [nvarchar](50) NOT NULL
		)
--
if not exists(select 1 from sys.objects s where s.name = 'fb_clubs' and s.type = 'U')
	CREATE TABLE [dbo].[fb_clubs](
		[club_id] [int] NOT NULL IDENTITY(1,1),
		[club_name] [nvarchar](100) NOT NULL
		)
--
if not exists(select 1 from sys.objects s where s.name = 'fb_countries' and s.type = 'U')
	CREATE TABLE [dbo].[fb_countries](
		[country_id] [smallint] NOT NULL IDENTITY(1,1),
		[country_name] [nvarchar](50) NOT NULL
		)
--
if not exists(select 1 from sys.objects s where s.name = 'fb_temp' and s.type = 'U')
	CREATE TABLE [dbo].[fb_temp](
		[str_data] [nvarchar](max) NULL)
--
-- Clear
--
TRUNCATE TABLE [dbo].[fb_temp]
TRUNCATE TABLE [dbo].[fb_winners]
TRUNCATE TABLE [dbo].[fb_cups]
TRUNCATE TABLE [dbo].[fb_countries]
TRUNCATE TABLE [dbo].[fb_clubs]
GO
