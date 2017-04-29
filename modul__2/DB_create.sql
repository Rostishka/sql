USE modul_2;
GO

CREATE TABLE [dbo].[tAuthors](
	[aId] [int] IDENTITY(1,1) NOT NULL,
	[aName] [varchar](50) NOT NULL,
	[aAddress] [varchar](50) NULL,
	CONSTRAINT	[PK_tAuthors] PRIMARY KEY ([aId]),
	CONSTRAINT [UK_tAuthors] UNIQUE ([aName])) ON [PRIMARY]
	GO 
	
	ALTER TABLE tAuthors ALTER COLUMN aAddress [varchar](50) NULL;

CREATE TABLE [dbo].[tGenres](
	[gId] [int] IDENTITY(1,1) NOT NULL,
	[gName] [varchar](50) NOT NULL,
	CONSTRAINT	[PK_tGenres] PRIMARY KEY ([gId]),
	CONSTRAINT [UK_tGenres] UNIQUE ([gName])) ON [PRIMARY]
	GO
	
CREATE TABLE [dbo].[tBookMakers](
	[mId] [int] IDENTITY(1,1) NOT NULL,
	[mName] [varchar](50) NOT NULL,
	[mAddress] [varchar](50) NOT NULL,
	CONSTRAINT	[PK_tBookMakers] PRIMARY KEY ([mId]),
	CONSTRAINT [UK_tBookMakers] UNIQUE ([mName])) ON [PRIMARY]
	GO  

CREATE TABLE [dbo].[tBooks](
	[bId] [int] IDENTITY(1,1) NOT NULL,
	[bName] [varchar](50) NOT NULL,
	[bAuthor] [int] NOT NULL,
	[bGenre] [int] NULL,
	[bBookMaker] [int] NOT NULL,
	[bPrice] [money] NOT NULL,
	[bAmount] [int] NOT NULL,
	[bOrdered] [int] NOT NULL,
	CONSTRAINT	[PK_tBooks] PRIMARY KEY ([bId]),
	CONSTRAINT [UK_tBooks] UNIQUE ([bName])) ON [PRIMARY]
	GO



	/*Add foreign Keys*/
	ALTER TABLE [dbo].[tBooks] WITH CHECK 
	ADD CONSTRAINT [FK_tBooks_tAuthor] FOREIGN KEY([bAuthor])
	REFERENCES [dbo].[tAuthors] ([aId])
	GO
  
	ALTER TABLE [dbo].[tBooks] WITH CHECK 
	ADD CONSTRAINT [FK_tBooks_tGenre] FOREIGN KEY([bGenre])
	REFERENCES [dbo].[tGenres] ([gId])
	GO
  
	ALTER TABLE [dbo].[tBooks] WITH CHECK 
	ADD CONSTRAINT [FK_tBooks_tBooksMakers] FOREIGN KEY([bBookMaker])
	REFERENCES [dbo].[tBookMakers] ([mId])
	GO
  