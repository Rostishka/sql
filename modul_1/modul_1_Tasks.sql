USE [TEST]
GO

--UPDATE tProducts
--SET pBarCode = 123
--WHERE pName = 'Tovar_1';

--UPDATE tProducts
--SET pBarCode = 5555
--WHERE pName = 'Tovar_2';

--UPDATE tProducts
--SET pBarCode = 321
--WHERE pName = 'Tovar_3';

-----------------------------------------------------------------------------------

--SELECT tProducts.pName FROM tProducts
--WHERE tProducts.pNumber > 0;

--SELECT tProducts.pName 
--FROM tProducts
--WHERE tProducts.pName LIKE '%2';

--SELECT tProducts.pName, tProducts.pPrice 
--FROM tProducts 
--WHERE tProducts.pPrice < 10;

--SELECT tProducts.pName, tProducts.pBarCode
--FROM tProducts 
--WHERE tProducts.pComment IS NULL;

--SELECT pName, pNumber*pPrice AS ALLPRICE 
--FROM tProducts

--SELECT pName, pNumber*pPrice AS ALLPRICE 
--FROM tProducts
--WHERE pName LIKE 'Tov%';

--------1 варіант розвязання
--SELECT  DISTINCT pName 
--FROM tProducts
--	INNER JOIN tDocDetails
--		ON tDocDetails.sProduct = tProducts.pInstance;

---------2 варіант розвязання
--SELECT tProducts.pName 
--FROM tProducts
--WHERE pInstance IN (SELECT tDocDetails.sProduct FROM tDocDetails);

---------------------------------------ВАРІАНТ 2
--SELECT tClients.cName FROM tClients;

--SELECT tClients.cName 
--	FROM tClients
--		WHERE tClients.cName LIKE 'CL%';

--SELECT tClients.cName 
--	FROM tClients
--		WHERE tClients.cName LIKE '%2';

--SELECT tClients.cName, tClients.cAddress 
--	FROM tClients
--		WHERE tClients.cAddress IS NOT NULL;

--SELECT tClients.cName, tClients.cInstance
--FROM tClients
--	WHERE tClients.cAmount >= 0;

--SELECT SUM(cAmount) AS Total_Amount
--FROM tClients;

--SELECT tClients.cName
--FROM tClients
--	WHERE NOT EXISTS (SELECT tDocuments.dClient FROM tDocuments	
--						WHERE tDocuments.dClient = tClients.cInstance);



SELECT * FROM tClients;
--SELECT * FROM tProducts;
--SELECT * FROM tDocDetails;