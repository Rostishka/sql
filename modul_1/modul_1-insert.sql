/***** Insert defaul data *****/
USE TEST
GO
--
INSERT INTO tProducts
           ([pName],[pBarCode],[pPrice],[pNumber],[pComment])
     VALUES ('Tovar_1',245,10.00,10,null)
GO
INSERT INTO tProducts
           ([pName],[pBarCode],[pPrice],[pNumber],[pComment])
     VALUES ('Tovar_2',0001,5.00,15,'Coments')
GO
INSERT INTO tProducts
           ([pName],[pBarCode],[pPrice],[pNumber],[pComment])
     VALUES ('Tovar_3',1488,3.00,0,'Any data about Tovar_3')
GO
--
INSERT INTO tClients
           ([cName],[cAddress],[cAmount],[cComment])
     VALUES ('Client_1','Address_1',0.0,'Comments')
GO
INSERT INTO tClients
           ([cName],[cAddress],[cAmount],[cComment])
     VALUES ('Client_2','Address_2',20.0,null)
GO
INSERT INTO tClients
           ([cName],[cAddress],[cAmount],[cComment])
     VALUES ('Client_3',null,-10.0,null)
GO
--
INSERT INTO tDocTypes
           ([tName],[tComment])
     VALUES ('Invoice',null)
GO
INSERT INTO tDocTypes
           ([tName],[tComment])
     VALUES ('Payment',null)
GO
--
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (1, 'I-001', cast('01/04/2007' as datetime), 1, 10.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (1, 'I-002', cast('01/04/2007' as datetime), 2, 35.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (1, 'I-003', cast('02/04/2007' as datetime), 1, 10.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (1, 'I-004', cast('02/04/2007' as datetime), 1, 20.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (2, 'P-001', cast('01/04/2007' as datetime), 1, 10.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (2, 'P-002', cast('02/04/2007' as datetime), 1, 10.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (2, 'P-003', cast('02/04/2007' as datetime), 2, 50.00, null)
GO
INSERT INTO tDocuments
           ([dType],[dNumber],[dDate],[dClient],[dAmount],[dComment])
     VALUES (2, 'P-004', cast('02/04/2007' as datetime), 3, 10.00, null)
GO
--
INSERT INTO tDocDetails
           ([sDocument],[sProduct],[sNumber])
     VALUES (1,1,1)
GO
INSERT INTO tDocDetails
           ([sDocument],[sProduct],[sNumber])
     VALUES (2,1,2)
GO
INSERT INTO tDocDetails
           ([sDocument],[sProduct],[sNumber])
     VALUES (2,2,3)
GO
INSERT INTO tDocDetails
           ([sDocument],[sProduct],[sNumber])
     VALUES (3,1,1)
GO
INSERT INTO tDocDetails
           ([sDocument],[sProduct],[sNumber])
     VALUES (4,1,1)
GO
INSERT INTO tDocDetails
           ([sDocument],[sProduct],[sNumber])
     VALUES (4,2,2)
GO
--
