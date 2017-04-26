USE [TEST_Cup]
GO
--
-- 1. Create temp-table
if not exists(select * from tempdb.sys.objects s where s.name like '%fb_full%')
	CREATE TABLE #fb_full(
		[cup_name] [nvarchar](50) NOT NULL,
		[cup_year] [int] NOT NULL,
		[club_name] [nvarchar](100) NOT NULL,
		[country_name] [nvarchar](50) NOT NULL)
GO
-- 2. Parse info from one srting to columns
INSERT INTO #fb_full ([cup_name],[cup_year],[club_name],[country_name])
SELECT rtrim(ltrim(replace(LEFT( [str_data], CHARINDEX(',', [str_data]) - 1),'	',''))) [cup_name],
       cast(replace( SUBSTRING( [str_data], CHARINDEX(',', [str_data]) + 1, CHARINDEX(',', [str_data], CHARINDEX(',', [str_data]) + 1) - CHARINDEX(',', [str_data]) - 1),'	','') as int) [cup_year],
       rtrim(ltrim(replace(SUBSTRING( [str_data], CHARINDEX(',', [str_data], CHARINDEX(',', [str_data]) + 1) + 1, CHARINDEX(',', [str_data], CHARINDEX(',', [str_data], CHARINDEX(',', [str_data]) + 1) + 1) - CHARINDEX(',', [str_data], CHARINDEX(',', [str_data]) + 1) - 1),'	',''))) [club_name],
       rtrim(ltrim(replace(right( rtrim(ltrim([str_data])), len([str_data]) - CHARINDEX(',', [str_data], CHARINDEX(',', [str_data], CHARINDEX(',', [str_data]) + 1) + 1)),'	',''))) [country_name]
  FROM [dbo].[fb_temp] 
  where nullif([str_data],'') is not null
GO
-- 3. Produce DICTIONARY tables
INSERT INTO [dbo].[fb_clubs] ([club_name])
SELECT DISTINCT rtrim(ltrim([club_name])) FROM #fb_full
INSERT INTO [dbo].[fb_countries]([country_name])
SELECT DISTINCT [country_name] FROM #fb_full ORDER BY [country_name]
INSERT INTO [dbo].[fb_cups]([cup_name])
SELECT DISTINCT [cup_name] FROM #fb_full ORDER BY [cup_name]
GO
-- 3. Produce MAIN table
INSERT INTO [dbo].[fb_winners]([cup_id],[cup_year],[club_id],[country_id])
SELECT c.[cup_id], f.[cup_year], t.[club_id], k.[country_id]
	FROM #fb_full f
	INNER JOIN [dbo].[fb_cups] c ON c.[cup_name] = f.[cup_name]
	INNER JOIN [dbo].[fb_clubs] t ON t.[club_name] = f.[club_name]
	INNER JOIN [dbo].[fb_countries] k ON k.[country_name] = f.[country_name]
GO
-- 4. Review results
select * from #fb_full
select * from [dbo].[fb_winners]
select * from [dbo].[fb_cups]
select * from [dbo].[fb_clubs]
select * from [dbo].[fb_countries]
GO
-- drop table #fb_full
--
select c.club_name, w.cnt
	from (select top 1 [club_id], count(1) cnt from [dbo].[fb_winners] group by [club_id] order by cnt DESC) w
	inner join [dbo].[fb_clubs] c on c.club_id = w.club_id
GO
--
select c.club_name, w.cnt
	from (select [club_id], count(1) cnt from [dbo].[fb_winners] group by [club_id]) w
	inner join (select top 1 [club_id], count(1) cnt from [dbo].[fb_winners] group by [club_id] order by cnt DESC) m
		on m.cnt = w.cnt
	inner join [dbo].[fb_clubs] c on c.club_id = w.club_id
GO
--
with best_win as
  (select [club_id], count(1) cnt from [dbo].[fb_winners] group by [club_id])
select c.club_name, w.cnt
	from best_win w
	inner join [dbo].[fb_clubs] c 
		on c.club_id = w.club_id
	inner join (select top 1 [club_id] from best_win order by cnt desc) m
		on m.club_id = w.club_id
GO
