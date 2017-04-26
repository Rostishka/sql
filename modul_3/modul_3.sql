USE [TEST]
GO

/****** Procedure QUERY_PRODUCTS ******/
if exists(select 1 from sysobjects s where s.name = 'QUERY_PRODUCTS' and s.type = 'P')
	DROP PROCEDURE QUERY_PRODUCTS
GO
--
CREATE PROCEDURE QUERY_PRODUCTS(
	@n_ID		int,
	@c_Name		varchar(50),
	@c_Code		varchar(10))
AS
BEGIN
	declare @n_Inst int
	declare @c_Prod varchar(50)
	declare @c_Bar  varchar(10)
	-- ???
	select @n_Inst = isnull( @n_ID, 0),
		@c_Prod = nullif(ltrim(rtrim(@c_Name)),'') + '%',
		@c_Bar  = nullif(ltrim(rtrim(@c_Code)),'')
	-- Out Data
	SELECT [pInstance] Product_ID,[pName] Product_Name,[pBarCode] Product_Code,
			[pPrice] Product_Price, [pComment] Product_Comment
		FROM [dbo].[tProducts]
		WHERE (@n_ID = 0 or [pInstance] = @n_ID)
		AND (@c_Prod is null) or [pName] like @c_Prod
		AND (@c_Bar is null or [pBarCode] = @c_Bar)
END
GO


/****** Procedure INSERT_PRODUCTS ******/
if exists(select 1 from sysobjects s where s.name = 'INSERT_PRODUCTS' and s.type = 'P')
	DROP PROCEDURE INSERT_PRODUCTS
GO
--
CREATE PROCEDURE INSERT_PRODUCTS(
	@c_Name		varchar(50),
	@c_Code		varchar(10),
	@m_Price	money,
	@c_Comment	varchar(250))
AS
BEGIN
	declare @c_Prod varchar(50)
	declare @c_Bar  varchar(10)
	declare @m_Cina money
	declare @c_Comm varchar(250)
	-- recheck input parameters
	select @c_Prod = nullif(ltrim(rtrim(@c_Name)),'') + '%',
		@c_Bar  = nullif(ltrim(rtrim(@c_Code)),''),
		@m_Cina = isnull(@m_Price,0),
		@c_Comm = nullif(ltrim(rtrim(@c_Comment)),'')
	-- ???
	if @c_Prod is null
		begin
		raiserror('Input parameter @c_Name is empty!',10,1)
		goto SP_END
		end
	if exists(SELECT 1 FROM [dbo].[tProducts] WHERE [pName] = @c_Prod)
		begin
		raiserror('Product %s already exists!',10,1,@c_Prod)
		goto SP_END
		end
	-- insert new row
	INSERT INTO [dbo].[tProducts]
			([pName],[pBarCode],[pPrice],[pComment])
		VALUES(@c_Prod, @c_Bar, @m_Cina, @c_Comm)
SP_END:
END
GO

/****** Procedure UPDATE_PRODUCTS ******/
if exists(select 1 from sysobjects s where s.name = 'UPDATE_PRODUCTS' and s.type = 'P')
	DROP PROCEDURE UPDATE_PRODUCTS
GO
--
CREATE PROCEDURE UPDATE_PRODUCTS(
	@n_ID		int,
	@c_Name		varchar(50),
	@c_Code		varchar(20),
	@m_Price	money,
	@c_Comment	varchar(250))
AS
BEGIN
	-- recheck input values
	if nullif(@n_ID,0) is null
		begin
		raiserror('Input parameter @n_ID is empty!',10,1)
		goto SP_END
		end
	if not exists(SELECT 1 FROM [dbo].[tProducts] WHERE [pInstance] = @n_ID)
		begin
		raiserror('Product ID = %d doesn''t exists!',10,1,@n_ID)
		goto SP_END
		end
	if nullif(@c_Name,'') is null
		begin
		raiserror('Input parameter @c_Name is empty!',10,1)
		goto SP_END
		end
	if exists(SELECT 1 FROM [dbo].[tProducts] WHERE [pName] = @c_Name AND [pInstance] <> @n_ID)
		begin
		raiserror('Product %d already exists with other instance!',10,1,@c_Name)
		goto SP_END
		end
	-- ???
	UPDATE [dbo].[tProducts]
		SET [pName] = @c_Name,
			[pBarCode] = isnull( @c_Code, [pBarCode]),
			[pPrice] = isnull( @m_Price, [pPrice]),
			[pComment] = @c_Comment
		WHERE [pInstance] = @n_ID
SP_END:
END
GO

/****** Procedure DELETE_PRODUCTS ******/
if exists(select 1 from sysobjects s where s.name = 'DELETE_PRODUCTS' and s.type = 'P')
	DROP PROCEDURE DELETE_PRODUCTS
GO
--
/*** ??? ***/
CREATE PROCEDURE DELETE_PRODUCTS(
	@n_ID		int)
AS
BEGIN
	declare @n_Inst int
	-- recheck input parameters
	select @n_Inst = isnull( @n_ID, 0)
	-- test correct values 
	if @n_Inst is null
		begin
		raiserror('Input parameter @n_ID is empty!',10,1)
		goto SP_END
		end
	if exists(SELECT 1 FROM [dbo].[tProducts] WHERE [pInstance] = @n_Inst)
		begin
		raiserror('Product %d does not exists!',10,1,@n_Inst)
		goto SP_END
		end
	-- delete one Product row
	DELETE [dbo].[tProducts]
		WHERE [pInstance] = @n_Inst
SP_END:
END
GO
--
