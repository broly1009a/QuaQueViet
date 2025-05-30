USE [master]
GO
/****** Object:  Database [ShopYouAndMeVersionFinal2]    Script Date: 26/05/2025 15:36:45 ******/
CREATE DATABASE [ShopYouAndMeVersionFinal2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShopYouAndMeVersionFinal2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ShopYouAndMeVersionFinal2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ShopYouAndMeVersionFinal2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ShopYouAndMeVersionFinal2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShopYouAndMeVersionFinal2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET  MULTI_USER 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET QUERY_STORE = ON
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ShopYouAndMeVersionFinal2]
GO
/****** Object:  Table [dbo].[About]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[About](
	[AboutId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ImageURL] [varchar](255) NULL,
	[Content] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AboutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[bill_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[total] [money] NOT NULL,
	[payment] [varchar](250) NOT NULL,
	[address] [ntext] NOT NULL,
	[date] [date] NOT NULL,
	[phone] [bigint] NOT NULL,
 CONSTRAINT [PK_bill] PRIMARY KEY CLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill_detail]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_detail](
	[detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[bill_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[size] [nchar](10) NOT NULL,
	[color] [nvarchar](150) NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_bill_detail] PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[cart_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[product_img] [varchar](255) NOT NULL,
	[product_price] [float] NOT NULL,
	[total] [float] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_cart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](255) NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [varchar](100) NOT NULL,
	[category_id] [int] NOT NULL,
	[product_name] [nvarchar](max) NOT NULL,
	[product_price] [money] NOT NULL,
	[product_describe] [nvarchar](max) NOT NULL,
	[quantity] [int] NOT NULL,
	[img] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_active]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_active](
	[product_id] [varchar](100) NOT NULL,
	[active] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_color]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_color](
	[product_id] [varchar](100) NOT NULL,
	[color] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_comment]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [varchar](100) NULL,
	[user_id] [bigint] NULL,
	[created_at] [datetime] NULL,
	[Rating] [int] NULL,
	[comment] [nvarchar](255) NULL,
	[user_name] [nvarchar](255) NULL,
	[admin_reply] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_size]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_size](
	[product_id] [varchar](100) NOT NULL,
	[size] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report](
	[id_report] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NULL,
	[content_report] [nvarchar](max) NULL,
	[subject_report] [nvarchar](255) NULL,
	[user_email] [varchar](255) NULL,
	[admin_reply] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_report] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_off]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_off](
	[sale_off_id] [int] IDENTITY(1,1) NOT NULL,
	[sale_off_code] [nvarchar](50) NOT NULL,
	[discount_type] [nvarchar](20) NOT NULL,
	[discount_value] [decimal](10, 2) NOT NULL,
	[max_discount] [decimal](10, 2) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_off_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 26/05/2025 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_name] [nvarchar](200) NULL,
	[user_email] [varchar](255) NOT NULL,
	[user_pass] [nvarchar](255) NOT NULL,
	[isAdmin] [nvarchar](50) NULL,
	[dateOfBirth] [varchar](255) NULL,
	[address] [varchar](255) NULL,
	[phoneNumber] [varchar](10) NULL,
	[banned] [bit] NULL,
	[adminReason] [nvarchar](50) NULL,
	[isStoreStaff] [nvarchar](50) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[About] ON 

INSERT [dbo].[About] ([AboutId], [Title], [ImageURL], [Content]) VALUES (10, N'dongc', N'images/about2.jpg', N'<p>dđsssss</p>')
SET IDENTITY_INSERT [dbo].[About] OFF
GO
SET IDENTITY_INSERT [dbo].[bill] ON 

INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (45, 5, 648000.0000, N'COD', N'Tiền Hải,Thái Bình', CAST(N'2024-05-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (46, 5, 298000.0000, N'CODE', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (47, 5, 378000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (48, 5, 270000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (49, 5, 417000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (50, 5, 567000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (51, 5, 278000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (52, 5, 189000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (53, 5, 259000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (54, 5, 270000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (55, 5, 259000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (56, 5, 810000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (57, 5, 149000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (58, 5, 417000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (59, 5, 149000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (60, 5, 517000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (61, 5, 139000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (62, 13, 2750000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (63, 13, 2880000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (64, 1, 240000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (65, 1, 169000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (66, 1, 210000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (67, 1, 1450000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (68, 16, 600000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 98272722)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (69, 1, 150000.0000, N'VNPAY', N'daihocfpt', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (70, 17, 298000.0000, N'VNPAY', N'daihocfpt', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (71, 17, 1240000.0000, N'COD', N'daihocfpt', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (73, 17, 100000.0000, N'COD', N'Ha Noi', CAST(N'2024-05-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (74, 14, 120000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-14' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (75, 5, 150000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-14' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (76, 5, 60000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-14' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (77, 8, 398000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-19' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (78, 1, 25000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-22' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (79, 1, 420000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-23' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (80, 1, 300000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-23' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (81, 1, 644000.0000, N'COD', N'hhhh', CAST(N'2024-06-23' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (82, 1, 199000.0000, N'VNPAY', N'hhhh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (83, 1, 250000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (84, 1, 349000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (85, 1, 420000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (86, 1, 290000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (87, 1, 544000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (88, 1, 259000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (89, 1, 877000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (90, 1, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (91, 1, 60000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (92, 1, 60000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (93, 1, 300000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (94, 1, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (95, 1, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (96, 10, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (97, 13, 300000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-28' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (98, 10, 599000.0000, N'COD', N'ha noi', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (99, 10, 99000.0000, N'VNPAY', N'ha noi', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (100, 10, 290000.0000, N'VNPAY', N'thai binh', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (101, 10, 169000.0000, N'VNPAY', N'thai binh', CAST(N'2024-07-01' AS Date), 348956375)
SET IDENTITY_INSERT [dbo].[bill] OFF
GO
SET IDENTITY_INSERT [dbo].[bill_detail] ON 

INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (40, 45, N'H1', 1, N'XS        ', N'Trắng', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (41, 45, N'H1', 2, N'S         ', N'Xanh', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (42, 46, N'AT533', 2, N'S         ', N'Trắng', 298000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (43, 47, N'H1', 2, N'L         ', N'Xanh', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (44, 48, N'H1', 1, N'XS        ', N'Trắng', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (45, 49, N'AT536', 3, N'S         ', N'Đỏ', 417000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (46, 50, N'H3', 3, N'S         ', N'Xanh', 567000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (47, 51, N'AT536', 2, N'S         ', N'Đỏ', 278000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (48, 52, N'H3', 1, N'S         ', N'Xanh', 189000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (49, 53, N'H3', 1, N'L         ', N'Đen', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (50, 54, N'H4', 1, N'XS        ', N'Trắng', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (51, 55, N'H4', 1, N'XS        ', N'Trắng', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (52, 56, N'H4', 3, N'XS        ', N'Trắng', 810000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (53, 57, N'AT533', 1, N'S         ', N'Trắng', 149000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (54, 58, N'AT536', 3, N'S         ', N'Đỏ', 417000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (55, 59, N'AT533', 1, N'S         ', N'Trắng', 149000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (56, 60, N'H4', 2, N'S         ', N'Xanh', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (57, 60, N'AT536', 1, N'L         ', N'Đỏ', 139000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (58, 61, N'AT536', 1, N'S         ', N'Đỏ', 139000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (59, 62, N'H5', 3, N'S         ', N'Đen', 510000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (60, 62, N'H18', 4, N'S         ', N'Trắng', 2240000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (61, 63, N'H12', 12, N'S         ', N'Trắng', 2880000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (62, 64, N'H10', 1, N'S         ', N'Trắng', 240000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (63, 65, N'H9', 1, N'S         ', N'Xanh', 169000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (64, 66, N'H8', 1, N'S         ', N'Đen', 210000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (65, 67, N'H7', 5, N'S         ', N'Đen', 1450000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (66, 68, N'H22', 10, N'S         ', N'Trắng', 600000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (67, 69, N'H5', 1, N'S         ', N'Xanh', 150000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (68, 70, N'AT533', 2, N'S         ', N'Đen', 298000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (69, 71, N'H5', 2, N'S         ', N'Đỏ', 340000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (70, 71, N'AS8001', 3, N'S         ', N'Đen', 900000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (71, 74, N'H5', 2, N'S         ', N'Trắng', 120000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (72, 75, N'H5', 1, N'S         ', N'Xanh', 150000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (73, 76, N'AS8004', 1, N'S         ', N'Trắng', 60000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (74, 77, N'H5', 2, N'S         ', N'Trắng', 398000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (75, 78, N'T2130', 1, N'S         ', N'Trắng', 25000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (76, 79, N'SW6003', 1, N'S         ', N'Trắng', 420000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (77, 80, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (78, 81, N'SW6009', 1, N'S         ', N'Xanh', 644000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (79, 82, N'S1201', 1, N'S         ', N'Trắng', 199000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (80, 83, N'T2131', 1, N'L         ', N'Trắng', 250000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (81, 84, N'S4007', 1, N'S         ', N'Trắng', 349000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (82, 85, N'SW6003', 1, N'S         ', N'Trắng', 420000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (83, 86, N'T3000', 1, N'S         ', N'Đen', 290000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (84, 87, N'SW6007', 1, N'S         ', N'Xanh', 544000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (85, 88, N'T2127', 1, N'L         ', N'Đen', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (86, 89, N'SW6008', 1, N'S         ', N'Xanh', 544000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (87, 89, N'SA7002', 1, N'S         ', N'Xanh', 333000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (88, 90, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (89, 91, N'AS8004', 1, N'S         ', N'Trắng', 60000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (90, 92, N'AS8004', 1, N'S         ', N'Trắng', 60000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (91, 93, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (92, 94, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (93, 95, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (94, 96, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (95, 97, N'AS8001', 1, N'S         ', N'Đen', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (96, 98, N'H1002', 1, N'S         ', N'Xanh', 599000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (97, 99, N'PL1', 1, N'S         ', N'Trắng', 99000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (98, 100, N'L1', 1, N'M         ', N'Đen', 290000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (99, 101, N'TD509', 1, N'S         ', N'Xanh', 169000.0000)
SET IDENTITY_INSERT [dbo].[bill_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([category_id], [category_name]) VALUES (1, N'Nem')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (2, N'Bánh')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (3, N'Kẹo')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (4, N'Mứt')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (5, N'Cơm')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (6, N'Rim')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (14, N'')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (15, N'')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (16, N'')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (17, N'')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (18, N'')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AS8001', 1, N'Nem Chua Thanh Hóa', 50000.0000, N'<p>Nem chua là món ăn truyền thống Việt Nam được làm từ thịt lợn xay nhuyễn, trộn với bì, tỏi, tiêu, ớt và các gia vị, sau đó lên men tự nhiên tạo nên vị chua nhẹ, giòn dai, thơm ngon. Nem thường được gói trong lá chuối và dùng làm món khai vị hoặc nhắm với bia, rượu.</p>', 300, N'images/AS8001.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AT533', 1, N'Tré', 35000.0000, N'Tré là món ăn truyền thống độc đáo của miền Trung Việt Nam, đặc biệt phổ biến ở các tỉnh như Bình Định, Huế và Đà Nẵng. Đây là món gỏi thịt lên men, kết hợp giữa các nguyên liệu như thịt heo, da heo, tai heo, được trộn đều với riềng, mè, tỏi, thính và gia vị, rồi ủ lên men nhẹ, tạo nên hương vị chua thanh, giòn sật, thơm nồng rất hấp dẫn.', 100, N'images/AT533.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AT536', 1, N'Nem Bùi', 35000.0000, N'<p>Nem Bùi được làm từ thịt lợn tươi, bì lợn thái mảnh, trộn đều với thính gạo rang, tỏi, ớt, lá sung và các loại gia vị, sau đó được gói bằng lá chuối tươi. Nem có vị chua nhẹ, thơm bùi, ăn kèm với lá đinh lăng hoặc lá sung rất hấp dẫn.</p>', 100, N'images/AT536.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H1', 2, N'Bánh Đậu Xanh(nhỏ)', 30000.0000, N'<p>Bánh đậu xanh có màu vàng nhạt, vị ngọt thanh, thơm bùi, tan ngay trong miệng. Bánh thường được đóng thành viên nhỏ hình vuông, gói trong giấy bóng kính hoặc hộp thiếc, rất thích hợp để thưởng trà hoặc làm quà biếu.</p>', 100, N'images/hoodie1.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H1007', 3, N'Kẹo sìu châu ', 20000.0000, N'Kẹo sìu châu là loại kẹo truyền thống có nguồn gốc từ Trung Quốc, du nhập vào Việt Nam và được người dân Phú Liêm gìn giữ, phát triển theo công thức riêng. Kẹo ở đây có hương vị đặc trưng và chất lượng cao, được nhiều người yêu thích, đặc biệt là vào dịp Tết hoặc làm quà biếu.

', 100, N'images/H1007.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H12', 3, N'Muối tôm cay loại 1 500g/gói', 40000.0000, N'Muối tôm cay loại 1 (500g) là loại muối đặc sản nổi tiếng của miền Tây và Tây Nguyên, đặc biệt là Tây Ninh – nơi được mệnh danh là “thủ phủ muối tôm”. Sản phẩm được chế biến từ muối hột nguyên chất, tôm khô loại thượng hạng, ớt tươi xay nhuyễn và gia vị tự nhiên, tạo nên hương vị đậm đà, cay nồng, thơm ngon khó cưỡng.', 100, N'images/H12.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H13', 2, N'Bánh dừa nướng truyền thống 200g/gói', 25000.0000, N'Bánh dừa nướng truyền thống là món đặc sản dân dã, bắt nguồn từ các tỉnh ven biển miền Trung và miền Nam, đặc biệt là Bến Tre – quê hương của những rặng dừa trù phú. Bánh được làm từ cơm dừa tươi kết hợp với bột nếp, đường và sữa, rồi mang đi nướng giòn thủ công, tạo nên hương vị mộc mạc, giòn rụm, thơm béo rất đặc trưng.', 50, N'images/H13.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H14', 2, N'Bánh dừa nướng cacao 200g/gói', 28000.0000, N'Bánh dừa nướng cacao là phiên bản nâng cấp đầy hấp dẫn từ bánh dừa nướng truyền thống. Với sự kết hợp độc đáo giữa cơm dừa tươi và bột cacao nguyên chất, bánh mang đến hương vị béo ngậy, thơm nồng, lại có thêm vị đắng nhẹ đặc trưng của cacao, khiến người ăn mê mẩn ngay từ lần thử đầu tiên.', 50, N'images/H14.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H15', 5, N'Cơm cháy chà bông mắm hành', 70000.0000, N'Cơm cháy chà bông mắm hành là món ăn vặt hấp dẫn, kết hợp hoàn hảo giữa cơm cháy giòn tan, chà bông heo tơi mịn, và nước mắm hành thơm nồng. Đây là món ngon “gây nghiện” không chỉ với giới trẻ mà cả người lớn cũng mê, thường xuyên xuất hiện trong các buổi gặp mặt, liên hoan hay đơn giản là món ăn vặt tại nhà.', 50, N'images/H15.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H16', 5, N'Cơm cháy mắm tỏi ớt', 65000.0000, N'Cơm cháy mắm tỏi ớt là món ăn vặt khoái khẩu với sự kết hợp bùng nổ giữa cơm cháy giòn tan và sốt mắm tỏi ớt đậm đà, cay nồng. Mỗi miếng cơm cháy được áo đều bởi lớp sốt thơm lừng, kích thích mọi giác quan, khiến bạn ăn một lần là nhớ mãi!

', 50, N'images/H16.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H17', 3, N'Kẹo Cu đơ( Loại trắng 1 hộp 600gram)', 60000.0000, N'Kẹo Cu Đơ Trắng là phiên bản thanh ngọt hơn của đặc sản kẹo cu đơ Hà Tĩnh – món quà quê gắn liền với vùng đất miền Trung đầy nắng gió. Không dùng mật mía như cu đơ truyền thống, cu đơ trắng được làm từ đường tinh luyện, kết hợp với lạc rang giòn, gừng tươi, và bánh tráng mỏng tạo nên hương vị nhẹ nhàng, dễ ăn, phù hợp với mọi lứa tuổi.', 50, N'images/H17.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H18', 3, N'Kẹo Cu đơ(Loại đen 1 hộp 900gram)', 105000.0000, N'Kẹo cu đơ đen là phiên bản nguyên gốc và truyền thống nhất của đặc sản kẹo cu đơ xứ Nghệ – Hà Tĩnh. Loại "đen" ở đây không phải do màu cháy, mà vì được làm từ mật mía nguyên chất, khi nấu lên có màu nâu cánh gián đậm đặc trưng. Sự kết hợp giữa mật mía, lạc rang, gừng tươi và bánh tráng tạo nên hương vị đậm đà, nồng nàn, mộc mạc đúng chất miền Trung.

', 50, N'images/H18.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H19', 2, N'Bánh dừa non(Tròn)', 25000.0000, N'Tròn vị( xoài, sầu riêng, cà phê, sữa dừa, là dứa). Bánh dừa non Tròn Vị là dòng bánh dừa hiện đại, kết hợp giữa cơm dừa non mềm dẻo và các hương vị trái cây – cà phê – sữa đặc trưng, tạo nên những chiếc bánh tròn xinh, thơm béo, ngọt dịu. Mỗi miếng bánh là một trải nghiệm hương vị khác nhau, phù hợp làm quà tặng hoặc ăn vặt hằng ngày.', 50, N'images/H19.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H2', 2, N'Bánh Đậu Xanh(loại to)', 50000.0000, N'<p>Bánh đậu xanh có màu vàng nhạt, vị ngọt thanh, thơm bùi, tan ngay trong miệng. Bánh thường được đóng thành viên nhỏ hình vuông, gói trong giấy bóng kính hoặc hộp thiếc, rất thích hợp để thưởng trà hoặc làm quà biếu.</p>', 100, N'images/H2.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H20', 2, N'Bánh dừa non(Vuông)', 30000.0000, N'Vuông vị( xoài, sầu riêng, cà phê, sữa dừa, là dứa). Bánh dừa non vuông vị là dòng bánh dẻo thơm hiện đại, được tạo hình vuông nhỏ xinh, kết hợp cùng cơm dừa non béo ngậy và 5 hương vị tự nhiên đầy hấp dẫn. Bánh có kết cấu mềm dẻo vừa phải, không dính tay, dễ ăn – thích hợp cho mọi lứa tuổi và mọi dịp.', 50, N'images/H20.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H21', 6, N'Tép rim ngọt cay (truyền thống)', 75000.0000, N'Tép rim ngọt cay truyền thống là món ăn dân dã quen thuộc của người Việt, đặc biệt phổ biến ở các tỉnh miền Tây và miền Trung. Với nguyên liệu chính là tép đồng tươi, rim cùng nước mắm ngon, đường, tỏi, ớt và chút tiêu, món ăn mang hương vị mặn – ngọt – cay hòa quyện, thơm nức, rất “hao cơm”.

', 50, N'images/H21.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H22', 6, N'Cá cơm rim mắm tỏi cay', 85000.0000, N'Cá cơm rim mắm tỏi cay là món ăn quen thuộc trong mâm cơm Việt, đặc biệt phổ biến ở miền Trung và miền Nam. Được làm từ cá cơm khô loại ngon, rim cùng nước mắm truyền thống, tỏi phi vàng, ớt tươi và đường, món ăn này mang hương vị mặn – ngọt – cay hài hòa, vô cùng “hao cơm” và dễ bảo quản.', 50, N'images/H22.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H3', 2, N'Bánh sữa Ba Vì(Nguyên Vị)', 25000.0000, N'Bánh sữa Ba Vì nguyên vị là một trong những đặc sản nổi tiếng của huyện Ba Vì, Hà Nội – vùng đất được mệnh danh là “thiên đường bò sữa”. Sản phẩm được làm từ nguồn sữa tươi nguyên chất, mang hương vị thơm ngon, mềm mịn, béo ngậy đặc trưng không thể nhầm lẫn.', 100, N'images/H3.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H4', 2, N'Bánh sữa Ba Vì (Socola)', 30000.0000, N'Bánh sữa Ba Vì vị socola là phiên bản biến tấu từ dòng bánh sữa truyền thống nguyên vị, kết hợp giữa sữa bò tươi nguyên chất và socola nguyên chất thơm lừng. Sản phẩm vừa giữ được độ béo ngậy đặc trưng của sữa Ba Vì, vừa mang hương vị ngọt đậm, quyến rũ của socola – rất được lòng giới trẻ và trẻ em.

', 100, N'images/H4.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H5', 4, N'Mơ núi đá thượng hạng (50g) ', 30000.0000, N' Mơ núi đá thượng hạng Hồng Lam là dòng sản phẩm cao cấp của thương hiệu Hồng Lam – nổi tiếng với các đặc sản quà tặng mang đậm hương vị truyền thống Việt Nam. Được tuyển chọn từ những quả mơ mọc trên vùng núi đá cao tại miền Bắc, sản phẩm không chỉ mang hương vị chua thanh đặc trưng mà còn giàu giá trị dinh dưỡng.', 100, N'images/H5.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H6', 4, N'Xí muội mận không hạt ( 200g) ', 85000.0000, N'Xí muội mận không hạt Hồng Lam là món quà vặt hấp dẫn, được chế biến từ những quả mận chín mọng, tách hạt kỹ lưỡng và sấy dẻo theo công thức truyền thống. Sản phẩm mang đến hương vị chua ngọt hài hòa, hậu vị đậm đà, rất thích hợp để nhâm nhi mỗi ngày hoặc làm quà biếu tinh tế.', 100, N'images/H6.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H7', 2, N'Bánh Pía Đậu xanh, Sầu riêng, Trứng - 260g', 43000.0000, N'Bánh Pía Đậu Xanh – Sầu Riêng – Trứng Muối là sự kết hợp hài hòa giữa ba nguyên liệu truyền thống: đậu xanh bùi mịn, sầu riêng thơm ngậy và trứng muối mặn béo. Đây là món bánh đặc sản nổi tiếng của miền Tây Nam Bộ, đặc biệt phổ biến tại Sóc Trăng – cái nôi của nghề làm bánh Pía lâu đời.', 100, N'images/H7.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H8', 2, N'Bánh Pía Kim Sa - mini - Đậu xanh, Lá dứa - Trứng tan chảy 6 bánh', 25000.0000, N'Bánh Pía Kim Sa Mini là phiên bản hiện đại và thu nhỏ của bánh Pía truyền thống, được kết hợp tinh tế giữa nhân đậu xanh, lá dứa thơm mát và phần trứng muối tan chảy đậm đà. Hộp 6 bánh nhỏ xinh, tiện lợi, thích hợp làm món ăn nhẹ hoặc quà tặng tinh tế.', 100, N'images/H8.jpg')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'H9', 2, N'Bánh tráng phơi sương 1kg', 38000.0000, N'Bánh tráng phơi sương là đặc sản trứ danh của vùng Trảng Bàng – Tây Ninh, nổi bật với độ dẻo, mềm, thơm và dễ cuốn. Khác với bánh tráng nướng hoặc bánh tráng khô thông thường, loại bánh này được tráng thủ công, phơi nắng và "hấp sương" qua đêm, tạo nên hương vị mộc mạc, tinh tế, rất được ưa chuộng trong các món cuốn truyền thống.', 20, N'images/H9.jpg')
GO
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'AS8001', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'AT533', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'AT536', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H100', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1007', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H101', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H102', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H104', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H105', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H13', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H14', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H15', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H16', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H17', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H18', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H19', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H20', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H21', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H22', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S1201', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S1202', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4000', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4001', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4002', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4004', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4005', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4006', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4007', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7001', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7002', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7005', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7006', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'ST300', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SW6000', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2106', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2109', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2119', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2127', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2128', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2129', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2130', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2131', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T3000', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T3132', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'TD481', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'TD509', N'True')
GO
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AS8001', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT533', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT536', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1007', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H2', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H3', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H4', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H5', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H6', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H7', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H8', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H9', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H12', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H13', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H14', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H15', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H16', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H17', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H18', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H19', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H20', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H21', N'Đen')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H22', N'Đen')
GO
SET IDENTITY_INSERT [dbo].[product_comment] ON 

INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name], [admin_reply]) VALUES (2, N'AS8004', 1, CAST(N'2024-06-28T08:43:10.670' AS DateTime), 5, N'ok nhé', NULL, NULL)
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name], [admin_reply]) VALUES (4, N'H1002', 10, CAST(N'2024-07-01T14:06:09.260' AS DateTime), 5, N'đã mua áo đẹp lắm', N'test8', NULL)
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name], [admin_reply]) VALUES (5, N'AS8001', 8, CAST(N'2025-05-20T09:10:43.733' AS DateTime), 3, N'ádasd', N'test6', NULL)
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name], [admin_reply]) VALUES (6, N'AS8001', 8, CAST(N'2025-05-20T09:18:18.387' AS DateTime), 3, N'ádasd', N'test6', NULL)
SET IDENTITY_INSERT [dbo].[product_comment] OFF
GO
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT533', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT536', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H2', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1007', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H12', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H3', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H4', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H5', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H6', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H7', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H8', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H9', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H13', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H14', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H15', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H16', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H17', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H18', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H19', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H20', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H21', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H22', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AS8001', N'S')
GO
SET IDENTITY_INSERT [dbo].[report] ON 

INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (1, 30, N'tôi muốn biết rõ ràng kích thước sản phẩm', N'Vấn đề về tư vấn sản phẩm ', N'anpgkhe172101@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (2, 30, N'kiem tra report', N'toi khong report duoc', N'anpgkhe172101@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (3, 30, N'Tôi không thể đổi mật khẩu trong tài khoản của tôi được', N'Vấn đề về đổi mật khẩu', N'anpgkhe172101@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (4, 30, N'Tôi không thể đổi mật khẩu trong tài khoản của tôi được', N'Vấn đề về đổi mật khẩu', N'anpgkhe172101@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (5, 30, N'Tôi không hiện thông báo gửi phản hồi thành công', N'Vấn đề về thông báo', N'anpgkhe172101@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (6, 30, N'Tôi không hiện thông báo gửi phản hồi thành công lần thứ 2', N'Vấn đề về thông báo', N'anpgkhe172101@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (7, 1, N'áo đẹp lắm', N'Sản phẩm', N'doanhtnhe172637@fpt.edu.vn', NULL)
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email], [admin_reply]) VALUES (9, 10, N'xau', N'san pham', N'test8@gmail.com', NULL)
SET IDENTITY_INSERT [dbo].[report] OFF
GO
SET IDENTITY_INSERT [dbo].[sale_off] ON 

INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (1, N'SALE_001', N'fixed', CAST(10000.00 AS Decimal(10, 2)), CAST(20000.00 AS Decimal(10, 2)), CAST(N'2025-05-01' AS Date), CAST(N'2025-06-01' AS Date), 100)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (2, N'SALE_002', N'percentage', CAST(10.00 AS Decimal(10, 2)), CAST(5000.00 AS Decimal(10, 2)), CAST(N'2025-05-10' AS Date), CAST(N'2025-07-01' AS Date), 150)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (3, N'SALE_003', N'fixed', CAST(15000.00 AS Decimal(10, 2)), CAST(30000.00 AS Decimal(10, 2)), CAST(N'2025-06-01' AS Date), CAST(N'2025-07-15' AS Date), 200)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (4, N'SALE_004', N'percentage', CAST(20.00 AS Decimal(10, 2)), CAST(10000.00 AS Decimal(10, 2)), CAST(N'2025-06-10' AS Date), CAST(N'2025-07-20' AS Date), 250)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (5, N'SALE_005', N'fixed', CAST(12000.00 AS Decimal(10, 2)), CAST(25000.00 AS Decimal(10, 2)), CAST(N'2025-07-01' AS Date), CAST(N'2025-08-01' AS Date), 300)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (6, N'SALE_006', N'percentage', CAST(15.00 AS Decimal(10, 2)), CAST(8000.00 AS Decimal(10, 2)), CAST(N'2025-05-20' AS Date), CAST(N'2025-06-30' AS Date), 120)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (7, N'SALE_007', N'fixed', CAST(20000.00 AS Decimal(10, 2)), CAST(35000.00 AS Decimal(10, 2)), CAST(N'2025-07-05' AS Date), CAST(N'2025-08-10' AS Date), 150)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (8, N'SALE_008', N'percentage', CAST(25.00 AS Decimal(10, 2)), CAST(12000.00 AS Decimal(10, 2)), CAST(N'2025-06-15' AS Date), CAST(N'2025-07-30' AS Date), 100)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (9, N'SALE_009', N'fixed', CAST(5000.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), CAST(N'2025-05-05' AS Date), CAST(N'2025-06-15' AS Date), 180)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (10, N'SALE_010', N'percentage', CAST(12.00 AS Decimal(10, 2)), CAST(7000.00 AS Decimal(10, 2)), CAST(N'2025-06-25' AS Date), CAST(N'2025-08-10' AS Date), 110)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (11, N'SALE_011', N'fixed', CAST(22000.00 AS Decimal(10, 2)), CAST(40000.00 AS Decimal(10, 2)), CAST(N'2025-07-15' AS Date), CAST(N'2025-08-25' AS Date), 250)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (12, N'SALE_012', N'percentage', CAST(30.00 AS Decimal(10, 2)), CAST(15000.00 AS Decimal(10, 2)), CAST(N'2025-07-10' AS Date), CAST(N'2025-09-01' AS Date), 220)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (13, N'SALE_013', N'fixed', CAST(18000.00 AS Decimal(10, 2)), CAST(35000.00 AS Decimal(10, 2)), CAST(N'2025-08-01' AS Date), CAST(N'2025-09-01' AS Date), 170)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (14, N'SALE_014', N'percentage', CAST(5.00 AS Decimal(10, 2)), CAST(4000.00 AS Decimal(10, 2)), CAST(N'2025-05-15' AS Date), CAST(N'2025-06-15' AS Date), 90)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (15, N'SALE_015', N'fixed', CAST(25000.00 AS Decimal(10, 2)), CAST(50000.00 AS Decimal(10, 2)), CAST(N'2025-07-20' AS Date), CAST(N'2025-08-15' AS Date), 130)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (16, N'SALE_016', N'percentage', CAST(10.00 AS Decimal(10, 2)), CAST(6000.00 AS Decimal(10, 2)), CAST(N'2025-05-25' AS Date), CAST(N'2025-06-30' AS Date), 160)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (17, N'SALE_017', N'fixed', CAST(20000.00 AS Decimal(10, 2)), CAST(40000.00 AS Decimal(10, 2)), CAST(N'2025-06-20' AS Date), CAST(N'2025-08-05' AS Date), 140)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (18, N'SALE_018', N'percentage', CAST(8.00 AS Decimal(10, 2)), CAST(3500.00 AS Decimal(10, 2)), CAST(N'2025-06-05' AS Date), CAST(N'2025-07-15' AS Date), 130)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (19, N'SALE_019', N'fixed', CAST(13000.00 AS Decimal(10, 2)), CAST(25000.00 AS Decimal(10, 2)), CAST(N'2025-07-01' AS Date), CAST(N'2025-08-15' AS Date), 110)
INSERT [dbo].[sale_off] ([sale_off_id], [sale_off_code], [discount_type], [discount_value], [max_discount], [start_date], [end_date], [quantity]) VALUES (20, N'SALE_020', N'percentage', CAST(18.00 AS Decimal(10, 2)), CAST(9000.00 AS Decimal(10, 2)), CAST(N'2025-08-01' AS Date), CAST(N'2025-09-01' AS Date), 120)
SET IDENTITY_INSERT [dbo].[sale_off] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (1, N'ADMIN', N'anhmdhe163618@fpt.edu.vn', N'123', N'TRUE', N'2003-06-19', N'Ha Noi', N'0393314726', 0, NULL, NULL)
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (4, N'Duc', N'duc@gmail.com', N'1423', N'TRUE', N'2003-12-02', N'Ha Noi', N'0999999999', 0, N'Good', NULL)
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (5, N'Hoang', N'hoang@gmail.com', N'123', N'FALSE', N'2003-04-03', N'Thai Binh', N'0999999999', 0, N'tốt', N'TRUE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (7, N'test5', N'test5@gmail.com', N'Dtran4673', N'FALSE', N'2003-04-03', N'Thai Binh', N'0999999999', 1, N'ok', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (8, N'test6', N'test6@gmaii.com', N'123', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, NULL)
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (9, N'test7', N'test7@gmail.com', N'', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 1, NULL, NULL)
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (10, N'test8', N'test8@gmail.com', N'Dtran4673', N'FALSE', N'2003-04-03', N'Thai Binhh', N'0999999999', 0, N'', N'TRUE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (12, N'DucAnh', N'DucAnh@gmail.com', N'Ducanh123', N'TRUE', N'2003-04-03', N'Nam Dinh', N'0999999999', 0, N'chăm chỉ', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (13, N'ViệtHoàng', N'hoangtvhe163201@fpt.edu.vn', N'123', N'False', N'2002-07-11', N'đ?a ch? 1', N'0979763115', 0, N'', N'False')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[product_comment] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [banned]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([bill_id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_bill]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_product]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [dbo].[product_comment]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
USE [master]
GO
ALTER DATABASE [ShopYouAndMeVersionFinal2] SET  READ_WRITE 
GO
