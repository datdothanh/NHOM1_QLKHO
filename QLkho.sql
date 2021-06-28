USE [master]
GO
/****** Object:  Database [QLKHO]    Script Date: 6/28/2021 3:31:37 PM ******/
CREATE DATABASE [QLKHO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLKHO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QLKHO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLKHO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QLKHO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLKHO] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLKHO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLKHO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLKHO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLKHO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLKHO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLKHO] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLKHO] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLKHO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLKHO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLKHO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLKHO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLKHO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLKHO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLKHO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLKHO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLKHO] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLKHO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLKHO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLKHO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLKHO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLKHO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLKHO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLKHO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLKHO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLKHO] SET  MULTI_USER 
GO
ALTER DATABASE [QLKHO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLKHO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLKHO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLKHO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLKHO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLKHO] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QLKHO] SET QUERY_STORE = OFF
GO
USE [QLKHO]
GO
/****** Object:  UserDefinedFunction [dbo].[GetUnsignString]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetUnsignString](@strInput NVARCHAR(4000)) 
RETURNS NVARCHAR(4000)
AS
BEGIN     
    IF @strInput IS NULL RETURN @strInput
    IF @strInput = '' RETURN @strInput
    DECLARE @RT NVARCHAR(4000)
    DECLARE @SIGN_CHARS NCHAR(136)
    DECLARE @UNSIGN_CHARS NCHAR (136)

    SET @SIGN_CHARS       = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'+NCHAR(272)+ NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'

    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
    SET @COUNTER = 1
 
    WHILE (@COUNTER <=LEN(@strInput))
    BEGIN   
      SET @COUNTER1 = 1
      --Tim trong chuoi mau
       WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
       BEGIN
     IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
     BEGIN           
          IF @COUNTER=1
              SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)                   
          ELSE
              SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)    
              BREAK         
               END
             SET @COUNTER1 = @COUNTER1 +1
       END
      --Tim tiep
       SET @COUNTER = @COUNTER +1
    END
    RETURN @strInput
END
GO
/****** Object:  Table [dbo].[Accout]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accout](
	[UserName] [varchar](20) NULL,
	[Pass] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillCode] [int] IDENTITY(1,1) NOT NULL,
	[CommodityCode] [int] NULL,
	[EmployeeCode] [int] NULL,
	[DateOfExport] [date] NULL,
	[NumberOfExport] [int] NULL,
 CONSTRAINT [PK_PhieuXuat_BillCode] PRIMARY KEY CLUSTERED 
(
	[BillCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Commodity]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Commodity](
	[CommodityCode] [int] IDENTITY(1,1) NOT NULL,
	[CommodityName] [nvarchar](50) NULL,
	[DateOfManufacture] [date] NULL,
	[ExpiryDate] [date] NULL,
	[ProducerCode] [int] NULL,
	[Amount] [int] NULL,
 CONSTRAINT [PK_HangHoa_CommodityCode] PRIMARY KEY CLUSTERED 
(
	[CommodityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeCode] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [nvarchar](50) NULL,
	[DateOfBirth] [date] NULL,
	[PhoneNumber] [char](10) NULL,
 CONSTRAINT [PK_NhanVien_EmployeeCode] PRIMARY KEY CLUSTERED 
(
	[EmployeeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnterCoupon]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnterCoupon](
	[EnterCouponCode] [int] IDENTITY(1,1) NOT NULL,
	[CommodityCode] [int] NULL,
	[EmployeeCode] [int] NULL,
	[DateOfImport] [date] NULL,
	[NumberOfImport] [int] NULL,
 CONSTRAINT [PK_PhieuNhap_EnterCouponCode] PRIMARY KEY CLUSTERED 
(
	[EnterCouponCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producer]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producer](
	[ProducerCode] [int] IDENTITY(1,1) NOT NULL,
	[ProducerName] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[PhoneNumber] [char](10) NULL,
 CONSTRAINT [PK_NhaSanXuat_ProducerCode] PRIMARY KEY CLUSTERED 
(
	[ProducerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Accout] ([UserName], [Pass]) VALUES (N'd782000', N'123456')
INSERT [dbo].[Accout] ([UserName], [Pass]) VALUES (N'd882000', N'123456')
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([BillCode], [CommodityCode], [EmployeeCode], [DateOfExport], [NumberOfExport]) VALUES (2, 1, 1, CAST(N'2021-06-28' AS Date), 5)
INSERT [dbo].[Bill] ([BillCode], [CommodityCode], [EmployeeCode], [DateOfExport], [NumberOfExport]) VALUES (4, 1, 1, CAST(N'2021-06-28' AS Date), 5)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[Commodity] ON 

INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (1, N'Bánh CaCa', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 1, 105)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (2, N'Bánh Dani', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 1, 185)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (3, N'Bánh quy bơ', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 1, 215)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (4, N'Kẹo thái', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 1, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (5, N'Kẹo bơ', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 1, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (6, N'Kẹo sầu', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 1, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (7, N'Socola đen', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (8, N'Socola trắng', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (9, N'Socola nâu', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (10, N'Kitkat', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (11, N'Kitkat trà xanh', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 3, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (12, N'Chocopie', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 3, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (13, N'Chocopie đậu đỏ', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 3, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (14, N'Bánh trứng', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 3, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (15, N'Bánh bông lan dứa', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 3, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (16, N'Bánh bông lan trứng muối', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 4, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (17, N'Bánh bông lan trứng', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 4, 100)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (18, N'Lương khô', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 4, 200)
INSERT [dbo].[Commodity] ([CommodityCode], [CommodityName], [DateOfManufacture], [ExpiryDate], [ProducerCode], [Amount]) VALUES (19, N'Lương khô đậu xanh', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 4, 100)
SET IDENTITY_INSERT [dbo].[Commodity] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeCode], [EmployeeName], [DateOfBirth], [PhoneNumber]) VALUES (1, N'Đỗ Thành Đạt', CAST(N'2000-08-08' AS Date), N'14466788  ')
INSERT [dbo].[Employee] ([EmployeeCode], [EmployeeName], [DateOfBirth], [PhoneNumber]) VALUES (2, N'Đỗ Thành Đông', CAST(N'2000-12-11' AS Date), N'11222333  ')
INSERT [dbo].[Employee] ([EmployeeCode], [EmployeeName], [DateOfBirth], [PhoneNumber]) VALUES (3, N'Nguyễn Văn A', CAST(N'1999-11-11' AS Date), N'44444444  ')
INSERT [dbo].[Employee] ([EmployeeCode], [EmployeeName], [DateOfBirth], [PhoneNumber]) VALUES (4, N'Nguyễn Văn B', CAST(N'1999-11-12' AS Date), N'33333333  ')
INSERT [dbo].[Employee] ([EmployeeCode], [EmployeeName], [DateOfBirth], [PhoneNumber]) VALUES (5, N'Nguyễn Văn C', CAST(N'1999-12-12' AS Date), N'22222222  ')
INSERT [dbo].[Employee] ([EmployeeCode], [EmployeeName], [DateOfBirth], [PhoneNumber]) VALUES (6, N'Nguyễn Văn D', CAST(N'1999-12-12' AS Date), N'22222222  ')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[EnterCoupon] ON 

INSERT [dbo].[EnterCoupon] ([EnterCouponCode], [CommodityCode], [EmployeeCode], [DateOfImport], [NumberOfImport]) VALUES (1, 1, 1, CAST(N'2021-06-28' AS Date), 10)
INSERT [dbo].[EnterCoupon] ([EnterCouponCode], [CommodityCode], [EmployeeCode], [DateOfImport], [NumberOfImport]) VALUES (4, 1, 1, CAST(N'2021-06-28' AS Date), 20)
INSERT [dbo].[EnterCoupon] ([EnterCouponCode], [CommodityCode], [EmployeeCode], [DateOfImport], [NumberOfImport]) VALUES (5, 1, 1, CAST(N'2021-06-28' AS Date), 40)
SET IDENTITY_INSERT [dbo].[EnterCoupon] OFF
GO
SET IDENTITY_INSERT [dbo].[Producer] ON 

INSERT [dbo].[Producer] ([ProducerCode], [ProducerName], [Address], [PhoneNumber]) VALUES (1, N'Nam Sơn', N'175 Gia Lâm , Hà Nội', N'035566785 ')
INSERT [dbo].[Producer] ([ProducerCode], [ProducerName], [Address], [PhoneNumber]) VALUES (2, N'Bắc Sơn', N'231 Xuân Hòa , Hà Nội', N'034455643 ')
INSERT [dbo].[Producer] ([ProducerCode], [ProducerName], [Address], [PhoneNumber]) VALUES (3, N'Đông Sơn', N'154 Cầu Giấy , Hà Nội', N'046755643 ')
INSERT [dbo].[Producer] ([ProducerCode], [ProducerName], [Address], [PhoneNumber]) VALUES (4, N'Tây Sơn', N'154 Tây Sơn , Hà Nội', N'048855643 ')
SET IDENTITY_INSERT [dbo].[Producer] OFF
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Commodity] FOREIGN KEY([CommodityCode])
REFERENCES [dbo].[Commodity] ([CommodityCode])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Commodity]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Employee] FOREIGN KEY([EmployeeCode])
REFERENCES [dbo].[Employee] ([EmployeeCode])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Employee]
GO
ALTER TABLE [dbo].[Commodity]  WITH CHECK ADD  CONSTRAINT [FK_Commodity_Producer] FOREIGN KEY([ProducerCode])
REFERENCES [dbo].[Producer] ([ProducerCode])
GO
ALTER TABLE [dbo].[Commodity] CHECK CONSTRAINT [FK_Commodity_Producer]
GO
ALTER TABLE [dbo].[EnterCoupon]  WITH CHECK ADD  CONSTRAINT [FK_EnterCoupon_Commodity] FOREIGN KEY([CommodityCode])
REFERENCES [dbo].[Commodity] ([CommodityCode])
GO
ALTER TABLE [dbo].[EnterCoupon] CHECK CONSTRAINT [FK_EnterCoupon_Commodity]
GO
ALTER TABLE [dbo].[EnterCoupon]  WITH CHECK ADD  CONSTRAINT [FK_EnterCoupon_Employee] FOREIGN KEY([EmployeeCode])
REFERENCES [dbo].[Employee] ([EmployeeCode])
GO
ALTER TABLE [dbo].[EnterCoupon] CHECK CONSTRAINT [FK_EnterCoupon_Employee]
GO
/****** Object:  StoredProcedure [dbo].[Commodity_GetAll]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Commodity_GetAll]
AS
BEGIN
  SELECT *
  FROM Commodity
END
GO
/****** Object:  StoredProcedure [dbo].[Employee_Delete]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Employee_Delete]
  @employeeCode INT
AS
BEGIN
  DELETE Employee
  WHERE EmployeeCode = @employeeCode
END
GO
/****** Object:  StoredProcedure [dbo].[Employee_GetAll]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------Procedure Employee 
CREATE PROCEDURE [dbo].[Employee_GetAll]
AS
BEGIN
  SELECT *
  FROM Employee
END
GO
/****** Object:  StoredProcedure [dbo].[Employee_Insert]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Insert]
  @fullName NVARCHAR(50),
  @dateOfBirth date,
  @phoneNumber varchar(10)
AS
BEGIN
  INSERT INTO Employee
    (EmployeeName, DateOfBirth, PhoneNumber)
  VALUES(@fullName, @dateOfBirth, @phoneNumber)
end
GO
/****** Object:  StoredProcedure [dbo].[Employee_Update]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Employee_Update]
  @employeeCode INT,
  @fullName NVARCHAR(50),
  @dateOfBirth date,
  @phoneNumber varchar(10)
AS
BEGIN
  UPDATE Employee
  SET EmployeeName  = @fullName,
  DateOfBirth = @dateOfBirth,
  PhoneNumber = @phoneNumber
  WHERE EmployeeCode = @employeeCode
END
GO
/****** Object:  StoredProcedure [dbo].[Employees_Search]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Employees_Search]
  @searchValue NVARCHAR(200)
AS
BEGIN
	SELECT *
  FROM Employee
  WHERE EmployeeCode LIKE N'%' + @searchValue + '%'
    OR EmployeeName LIKE N'%' + @searchValue + '%'
    OR DateOfBirth LIKE N'%' + @searchValue + '%'
    OR PhoneNumber LIKE N'%' + @searchValue + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[EnterCoupon_Delete]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EnterCoupon_Delete]
  @EnterCouponCode INT
AS
BEGIN

	declare @Sl int;
	set @Sl=(select EnterCoupon.NumberOfImport from EnterCoupon where EnterCouponCode = @EnterCouponCode )

	declare @CommodityCode int;
	set @CommodityCode=(select EnterCoupon.CommodityCode from EnterCoupon where EnterCouponCode = @EnterCouponCode )

	Update Commodity
	set Amount = Amount - @Sl
	where CommodityCode = @CommodityCode

  DELETE EnterCoupon
  WHERE EnterCouponCode = @EnterCouponCode

	
END
GO
/****** Object:  StoredProcedure [dbo].[EnterCoupon_GetAll]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EnterCoupon_GetAll]
AS
BEGIN
  SELECT *
  FROM EnterCoupon
END
GO
/****** Object:  StoredProcedure [dbo].[EnterCoupon_Insert]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EnterCoupon_Insert]
  @CommodityCode INT,
  @EmployeeCode INT,
  @DateOfImport date,
  @NumberOfImport INT
AS
BEGIN
  INSERT INTO EnterCoupon
    (CommodityCode, EmployeeCode, DateOfImport, NumberOfImport)
  VALUES(@CommodityCode, @EmployeeCode, @DateOfImport, @NumberOfImport)
	
	Update Commodity
	set Amount = Amount + @NumberOfImport
	where CommodityCode = @CommodityCode
END
GO
/****** Object:  StoredProcedure [dbo].[EnterCoupon_Search]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------Long quản lý phiếu nhập------------------------------
CREATE PROCEDURE [dbo].[EnterCoupon_Search]
@searchValue NVARCHAR(200)  
as
Begin  
  SELECT *
  FROM EnterCoupon
  WHERE EnterCouponCode LIKE N'%' + @searchValue + '%'
    OR CommodityCode LIKE N'%' + @searchValue + '%'
    OR EmployeeCode LIKE N'%' + @searchValue + '%'
    OR DateOfImport LIKE N'%' + @searchValue + '%'
    OR NumberOfImport LIKE N'%' + @searchValue + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[EnterCoupon_Update]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EnterCoupon_Update]
  @EnterCouponCode INT,
  @CommodityCode INT,
  @EmployeeCode INT,
  @DateOfImport date,
  @NumberOfImport INT
AS
BEGIN
	declare @Sl int; 
	set @Sl=(select EnterCoupon.NumberOfImport from EnterCoupon where EnterCouponCode = @EnterCouponCode )

	declare @CommodityCode1 int;
	set @CommodityCode1=(select EnterCoupon.CommodityCode from EnterCoupon where EnterCouponCode = @EnterCouponCode )

	Update Commodity
	set Amount = Amount - @Sl
	where CommodityCode = @CommodityCode1

	Update Commodity
	set Amount = Amount + @NumberOfImport
	where CommodityCode = @CommodityCode

  UPDATE EnterCoupon
  SET CommodityCode  = @CommodityCode,
  EmployeeCode = @EmployeeCode,
  DateOfImport = @DateOfImport,
  NumberOfImport = @NumberOfImport
  WHERE EnterCouponCode = @EnterCouponCode

END
GO
/****** Object:  StoredProcedure [dbo].[GetCommodityList]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetCommodityList]
as
begin
	select *
	from Commodity
	where Amount > 0
end
GO
/****** Object:  StoredProcedure [dbo].[SearchCommodityByName]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SearchCommodityByName]
	@commodityname nvarchar(50)
as
begin
	select *
	from Commodity
	where [dbo].[GetUnsignString](CommodityName) like N'%' + [dbo].[GetUnsignString](@commodityname) + '%'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Bill_Delete]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Bill_Delete]
  @BillCode INT
AS
BEGIN
	
	declare @Sl int; 
	set @Sl=(select Bill.NumberOfExport from Bill where BillCode = @BillCode )

	declare @CommodityCode1 int;
	set @CommodityCode1=(select Bill.BillCode from Bill where BillCode = @BillCode )

	Update Commodity
	set Amount = Amount + @Sl
	where CommodityCode = @CommodityCode1


  DELETE Bill
  WHERE BillCode = @BillCode
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Bill_GetAll]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------Thiệp BILL------------------------
CREATE PROCEDURE [dbo].[SP_Bill_GetAll]
AS
BEGIN
  SELECT *
  FROM Bill
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Bill_Insert]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Bill_Insert]
  @CommodityCode INT,
  @EmployeeCode INT,
  @DateOfExport DATE,
  @NumberOfExport INT
AS
BEGIN
  INSERT INTO Bill
    (CommodityCode, EmployeeCode, DateOfExport, NumberOfExport)
  VALUES(@CommodityCode,@EmployeeCode, @DateOfExport, @NumberOfExport)

  
	Update Commodity
	set Amount = Amount - @NumberOfExport
	where CommodityCode = @CommodityCode
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Bill_Search]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Bill_Search]
  @searchValue NVARCHAR(200)
AS
BEGIN
  SELECT *
  FROM Bill
  WHERE BillCode LIKE N'%' + @searchValue + '%'
    OR  CommodityCode LIKE N'%' + @searchValue + '%'
    OR  EmployeeCode LIKE N'%' + @searchValue + '%'
    OR  DateOfExport LIKE N'%' + @searchValue + '%'
    OR  NumberOfExport LIKE N'%' + @searchValue + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Bill_Update]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Bill_Update]
  @BillCode INT,
  @CommodityCode INT,
  @EmployeeCode INT,
  @DateOfExport DATE,
  @NumberOfExport INT
AS
BEGIN
	
	declare @Sl int; 
	set @Sl=(select Bill.NumberOfExport from Bill where BillCode = @BillCode )

	declare @CommodityCode1 int;
	set @CommodityCode1=(select Bill.BillCode from Bill where BillCode = @BillCode )

	Update Commodity
	set Amount = Amount + @Sl - @NumberOfExport
	where CommodityCode = @CommodityCode


  UPDATE Bill
  SET CommodityCode = @CommodityCode,
	  EmployeeCode = @EmployeeCode,
	  DateOfExport = @DateOfExport,
	  NumberOfExport = @NumberOfExport
  WHERE BillCode = @BillCode
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Commodity_GetAll]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Commodity_GetAll]
AS
BEGIN
  SELECT *
  FROM Commodity
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DangNHap]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[SP_DangNHap]
@UserName varchar(50),
@Pass varchar(50)
as
begin
	IF EXISTS (SELECT * FROM Accout  WHERE UserName =  @UserName and Pass = @Pass)
		SELECT 1;
	  ELSE
		SELECT 0;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Employee_GetAll]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Employee_GetAll]
AS
BEGIN
  SELECT *
  FROM Employee
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HangHoa_Delete]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HangHoa_Delete]
  @CommodityCode int
AS
BEGIN
  
  DELETE Commodity
  WHERE CommodityCode = @CommodityCode
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HangHoa_Insert]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HangHoa_Insert]
  @CommodityName NVARCHAR(50),
  @DateOfManufacture DATE,
  @ExpiryDate DATE,
  @ProducerCode int
  
AS
BEGIN
  INSERT INTO Commodity(CommodityName,DateOfManufacture,ExpiryDate,ProducerCode,Amount)
  VALUES(@CommodityName,@DateOfManufacture,@ExpiryDate,@ProducerCode,0)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HangHoa_Search]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HangHoa_Search]
  @searchValue NVARCHAR(50)
AS
BEGIN
  SELECT *
  FROM Commodity
  WHERE CommodityCode LIKE N'%' + @searchValue + '%'
    OR CommodityName LIKE N'%' + @searchValue + '%'
    OR DateOfManufacture LIKE N'%' + @searchValue + '%'
    OR ExpiryDate LIKE N'%' + @searchValue + '%'
    OR ProducerCode LIKE N'%' + @searchValue + '%'
END   
GO
/****** Object:  StoredProcedure [dbo].[SP_HangHoa_Update]    Script Date: 6/28/2021 3:31:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HangHoa_Update]
  @CommodityCode int,
  @CommodityName NVARCHAR(50),
  @DateOfManufacture DATE,
  @ExpiryDate DATE,
  @ProducerCode int
  
AS
BEGIN
  UPDATE Commodity
  SET 
      CommodityName=@CommodityName,
	  DateOfManufacture=@DateOfManufacture,
	  ExpiryDate=@ExpiryDate,
	  ProducerCode=@ProducerCode
	
  
  WHERE CommodityCode = @CommodityCode
END
GO
USE [master]
GO
ALTER DATABASE [QLKHO] SET  READ_WRITE 
GO
