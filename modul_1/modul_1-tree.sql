-- Add new parent tovars
INSERT INTO [dbo].[tProducts]
           ([pName],[pBarCode],[pPrice],[pNumber],[pComment])
     VALUES ('Parent_T1',null,0,0,'Parent_Tovar_Group_1')
INSERT INTO [dbo].[tProducts]
           ([pName],[pBarCode],[pPrice],[pNumber],[pComment])
     VALUES ('Parent_T2',null,0,0,'Parent_Tovar_Group_2')
INSERT INTO [dbo].[tProducts]
           ([pName],[pBarCode],[pPrice],[pNumber],[pComment])
     VALUES ('Parent_ALL',null,0,0,'Parent_Tovar_Group_ALL')
GO
-- Create Tovar Tree Table
if exists(select 1 from sys.all_objects o
			where o.name = 'tProduct_Tree'
			and o.type = 'U')
	drop table [dbo].[tProduct_Tree];
--
create table [dbo].[tProduct_Tree] (
	[rInstance]	int not null,
	[rParent]		int not null);
GO
--
-- Build Tovar Tree
insert into [dbo].[tProduct_Tree]( [rInstance], [rParent])
	select p.[pInstance], 0
		from [dbo].[tProducts] p
		where p.[pName] = 'Parent_ALL'
insert into [dbo].[tProduct_Tree]( [rInstance], [rParent])
	select p1.[pInstance], p2.[pInstance]
		from [dbo].[tProducts] p1,
			[dbo].[tProducts] p2
		where p1.[pName] = 'Parent_T1'
		and p2.[pName] = 'Parent_ALL'
insert into [dbo].[tProduct_Tree]( [rInstance], [rParent])
	select p1.[pInstance], p2.[pInstance]
		from [dbo].[tProducts] p1,
			[dbo].[tProducts] p2
		where p1.[pName] = 'Parent_T2'
		and p2.[pName] = 'Parent_ALL'
insert into [dbo].[tProduct_Tree]( [rInstance], [rParent])
	select p1.[pInstance], p2.[pInstance]
		from [dbo].[tProducts] p1,
			[dbo].[tProducts] p2
		where p1.[pName] = 'Tovar_1'
		and p2.[pName] = 'Parent_T1'
insert into [dbo].[tProduct_Tree]( [rInstance], [rParent])
	select p1.[pInstance], p2.[pInstance]
		from [dbo].[tProducts] p1,
			[dbo].[tProducts] p2
		where p1.[pName] = 'Tovar_3'
		and p2.[pName] = 'Parent_T1'
insert into [dbo].[tProduct_Tree]( [rInstance], [rParent])
	select p1.[pInstance], p2.[pInstance]
		from [dbo].[tProducts] p1,
			[dbo].[tProducts] p2
		where p1.[pName] = 'Tovar_2'
		and p2.[pName] = 'Parent_T2'
go
--
SELECT [pInstance],[pName],[pComment]
  FROM [dbo].[tProducts]
GO
SELECT [rInstance],[rParent]
  FROM [dbo].[tProduct_Tree]
GO
--
WITH [TestRecurs] (ChildID, ParentID, RLevel, RName)
AS 
(SELECT t.[rInstance] ChildID, t.[rParent] ParentID, 0 RLevel, p.[pName]
		FROM [dbo].[tProduct_Tree] t
		INNER JOIN [dbo].[tProducts] p
			ON p.[pName]  = 'Parent_ALL'
			AND t.[rInstance] = p.[pInstance]
    UNION ALL
    SELECT t.[rInstance], t.[rParent], r.[RLevel] + 1, p.[pName]
		FROM [dbo].[tProduct_Tree] t
		INNER JOIN [TestRecurs] r
			ON r.[ChildID] = t.[rParent]
		INNER JOIN [dbo].[tProducts] p
			ON t.[rInstance] = p.[pInstance]
)
SELECT [RLevel], REPLICATE('--- ', [RLevel] * 1) + [RName] Tovar_Tree
	FROM [TestRecurs]
	ORDER BY [RLevel]
GO
--
-- CUBE request
--
SELECT isnull( cName, 'Client ALL') [Client_Name], 
		isnull( tName, 'All Doc')  [Doc_Name],
		sum( (case when tName = 'Invoice' then 1
					when tName = 'Payment' then -1
					else 0 end) *
			 dAmount) Doc_Som
	FROM tDocuments
	INNER JOIN tDocTypes
		ON tInstance = dType
	RIGHT JOIN tClients
		ON cInstance = dClient
	GROUP BY cName, tName WITH CUBE
	ORDER BY (case when cName is null then 1 else 0 end), [Client_Name],
		(case when tName is null then 1 else 0 end), [Doc_Name]
--
-- with OVER
--
SELECT pName, pPrice, sNumber,
	COUNT( tInstance) OVER(PARTITION BY pInstance) [Count],
	SUM( pPrice * isnull(sNumber,0)) OVER(PARTITION BY pInstance) [Total_Prod]
    FROM tDocDetails
	INNER JOIN tDocuments
		INNER JOIN tDocTypes
			ON tInstance = dType
			AND tName = 'Invoice'
		ON sDocument = dInstance
	RIGHT OUTER JOIN tProducts
		on pInstance = sProduct
