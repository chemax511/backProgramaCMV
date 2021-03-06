USE [BD_CMV]
GO
/****** Object:  User [userCMV]    Script Date: 16/08/2021 12:17:58 p. m. ******/
CREATE USER [userCMV] FOR LOGIN [userCMV] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[CAT_CMV_TIPO_CUENTA]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CAT_CMV_TIPO_CUENTA](
	[id_cuenta] [int] IDENTITY(1,1) NOT NULL,
	[nombre_cuenta] [varchar](50) NULL,
 CONSTRAINT [PK_CAT_CMV_TIPO_CUENTA] PRIMARY KEY CLUSTERED 
(
	[id_cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_ADMIN]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_ADMIN](
	[id_admin] [int] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TBL_ADMIN] PRIMARY KEY CLUSTERED 
(
	[id_admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_CMV_CLIENTE]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CMV_CLIENTE](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellido_paterno] [varchar](50) NOT NULL,
	[apellido_materno] [varchar](50) NOT NULL,
	[rfc] [varchar](50) NOT NULL,
	[curp] [varchar](50) NOT NULL,
	[fecha_alta] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_TBL_CMV_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_CMV_CLIENTE_CUENTA]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA](
	[id_cliente_cuenta] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_cuenta] [int] NOT NULL,
	[saldo_actual] [money] NOT NULL,
	[fecha_contratacion] [datetime] NOT NULL,
	[fecha_ultimo_movimiento] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_CMV_CLIENTE_CUENTA] PRIMARY KEY CLUSTERED 
(
	[id_cliente_cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA]  WITH CHECK ADD  CONSTRAINT [FK_TBL_CMV_CLIENTE_CUENTA_CAT_CMV_TIPO_CUENTA] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CAT_CMV_TIPO_CUENTA] ([id_cuenta])
GO
ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA] CHECK CONSTRAINT [FK_TBL_CMV_CLIENTE_CUENTA_CAT_CMV_TIPO_CUENTA]
GO
ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA]  WITH CHECK ADD  CONSTRAINT [FK_TBL_CMV_CLIENTE_CUENTA_TBL_CMV_CLIENTE] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[TBL_CMV_CLIENTE] ([id_cliente])
GO
ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA] CHECK CONSTRAINT [FK_TBL_CMV_CLIENTE_CUENTA_TBL_CMV_CLIENTE]
GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Cliente]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Delete_Cliente]
	-- Add the parameters for the stored procedure here
	@id_cliente int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE TBL_CMV_CLIENTE SET status = 0 WHERE id_cliente = @id_cliente
END

GO
/****** Object:  StoredProcedure [dbo].[SP_Insert_CMV_Cliente]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Insert_CMV_Cliente]
	-- Add the parameters for the stored procedure here
	@nombre varchar(50),
	@apellido_paterno varchar(50),
	@apellido_materno varchar(50),
	@curp varchar(50),
	@rfc varchar(50),
	
	@id_cliente int,
	@id_cuenta int,
	@saldo_actual money
	--@fecha_alta datetime,
	--@fecha_contratacion datetime

	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
DECLARE @GetTime datetime = GETDATE();
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO TBL_CMV_CLIENTE (nombre,apellido_paterno,apellido_materno,rfc,curp,fecha_alta,status) VALUES (@nombre,@apellido_paterno,@apellido_materno,@rfc,@curp,@GetTime,1	);
	INSERT INTO TBL_CMV_CLIENTE_CUENTA (id_cliente,id_cuenta,saldo_actual,fecha_contratacion,fecha_ultimo_movimiento) VALUES (@id_cliente,@id_cuenta,@saldo_actual,@GetTime,@GetTime);

END

GO
/****** Object:  StoredProcedure [dbo].[SP_Show_CMV_Cliente]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Show_CMV_Cliente]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT nombre, apellido_paterno, apellido_materno, rfc, curp, fecha_alta FROM TBL_CMV_CLIENTE
END

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Cliente_Data]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Update_Cliente_Data]
	-- Add the parameters for the stored procedure here
	@id_cliente int,
	@nombre varchar(50),
	@apellido_paterno varchar(50),
	@apellido_materno varchar(50),
	@curp varchar(50),
	@rfc varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE TBL_CMV_CLIENTE set	nombre = @nombre,
								apellido_paterno = @apellido_paterno,
								apellido_materno = @apellido_materno,
								rfc = @rfc,
								curp = @curp
							WHERE id_cliente = @id_cliente

END

GO
/****** Object:  StoredProcedure [dbo].[stpShowCMVCliente]    Script Date: 16/08/2021 12:17:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[stpShowCMVCliente]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT nombre, apellido_paterno, apellido_materno, rfc,curp,fecha_alta FROM TBL_CMV_CLIENTE WHERE status = 1
END

GO
