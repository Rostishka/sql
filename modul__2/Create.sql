USE modul_2
GO

INSERT INTO tBooks
	([bName], [bAuthor], [bGenre], [bBookMaker], [bPrice], [bAmount], [bOrdered])
	VALUES ('Kozzaks', 1, 1, 1, 23, 100, 55);
	GO

INSERT INTO tBooks
	([bName], [bAuthor], [bGenre], [bBookMaker], [bPrice], [bAmount], [bOrdered])
	VALUES ('Romeo', 2, 2, 2, 12, 200, 66);
	GO

INSERT INTO tBooks
	([bName], [bAuthor], [bGenre], [bBookMaker], [bPrice], [bAmount], [bOrdered])
	VALUES ('SomeBook', 3, 3, 3, 3, 300, 77);
	GO

INSERT INTO tAuthors
			([aName], [aAddress])
			VALUES('Rostik', 'Some_street_23a');
GO

INSERT INTO tAuthors
			([aName], [aAddress])
			VALUES('Vova', 'Some_street_20a');
GO

INSERT INTO tAuthors
			([aName])
			VALUES('Nastya');
GO

INSERT INTO tBookMakers
	([mName], [mAddress])
	VALUES('Some_Guy', 'Ternopil');
	GO
	
INSERT INTO tBookMakers
	([mName], [mAddress])
	VALUES('Other_Guy', 'Lviv');
	GO
	
INSERT INTO tBookMakers
	([mName], [mAddress])
	VALUES('Guy', 'Kyiv');
	GO

INSERT INTO tGenres
	([gName])
	VALUES('Ukrainian');
	GO
	
INSERT INTO tGenres
	([gName])
	VALUES('Expressionism');
	GO
	
INSERT INTO tGenres
	([gName])
	VALUES('Foreign');
	GO