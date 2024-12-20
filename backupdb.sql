USE [master]
GO
/****** Object:  Database [Opal_Exe]    Script Date: 11/12/2024 6:15:57 PM ******/
CREATE DATABASE [Opal_Exe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Opal_Exe', FILENAME = N'/var/opt/mssql/data/Opal_Exe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Opal_Exe_log', FILENAME = N'/var/opt/mssql/data/Opal_Exe_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Opal_Exe] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Opal_Exe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Opal_Exe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Opal_Exe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Opal_Exe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Opal_Exe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Opal_Exe] SET ARITHABORT OFF 
GO
ALTER DATABASE [Opal_Exe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Opal_Exe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Opal_Exe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Opal_Exe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Opal_Exe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Opal_Exe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Opal_Exe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Opal_Exe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Opal_Exe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Opal_Exe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Opal_Exe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Opal_Exe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Opal_Exe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Opal_Exe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Opal_Exe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Opal_Exe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Opal_Exe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Opal_Exe] SET RECOVERY FULL 
GO
ALTER DATABASE [Opal_Exe] SET  MULTI_USER 
GO
ALTER DATABASE [Opal_Exe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Opal_Exe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Opal_Exe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Opal_Exe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Opal_Exe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Opal_Exe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Opal_Exe', N'ON'
GO
ALTER DATABASE [Opal_Exe] SET QUERY_STORE = ON
GO
ALTER DATABASE [Opal_Exe] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Opal_Exe]
GO
/****** Object:  Table [dbo].[Customizations]    Script Date: 11/12/2024 6:15:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customizations](
	[customization_id] [int] IDENTITY(1,1) NOT NULL,
	[ui_color] [nvarchar](50) NULL,
	[font_color] [nvarchar](50) NULL,
	[font_1] [nvarchar](50) NULL,
	[font_2] [nvarchar](50) NULL,
	[textBox_color] [nvarchar](50) NULL,
	[button_color] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[customization_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[event_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[event_title] [nvarchar](255) NOT NULL,
	[event_description] [nvarchar](max) NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[notification_time] [datetime] NULL,
	[recurring] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[priority] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[notification_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[task_id] [nvarchar](36) NULL,
	[event_id] [nvarchar](36) NULL,
	[notification_time] [datetime] NOT NULL,
	[is_sent] [bit] NULL,
	[notification_type] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OTPCode]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OTPCode](
	[Id] [nvarchar](36) NOT NULL,
	[OTP] [char](6) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[IsUsed] [bit] NOT NULL,
	[CreatedBy] [nvarchar](36) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[subscription_id] [nvarchar](36) NULL,
	[transaction_id] [nvarchar](100) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[payment_method] [nvarchar](50) NOT NULL,
	[payment_date] [datetime] NULL,
	[status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[token_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[refresh_token] [nvarchar](255) NOT NULL,
	[issued_at] [datetime] NULL,
	[expires_at] [datetime] NOT NULL,
	[is_revoked] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[token_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seeds]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seeds](
	[seed_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[percent_growth] [float] NULL,
	[seed_count] [int] NULL,
	[parrot_level] [int] NULL,
	[created_at] [datetime] NULL,
	[LastFedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[seed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subscriptions]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscriptions](
	[subscription_id] [nvarchar](36) NOT NULL,
	[SubName] [nvarchar](150) NOT NULL,
	[Duration] [int] NOT NULL,
	[Price] [decimal](10, 2) NULL,
	[SubDescription] [nvarchar](max) NOT NULL,
	[status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[subscription_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[task_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[priority] [nvarchar](50) NULL,
	[due_date] [datetime] NULL,
	[time_task] [time](7) NULL,
	[is_completed] [bit] NULL,
	[status] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[task_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theme](
	[theme_id] [int] IDENTITY(1,1) NOT NULL,
	[background_bird] [nvarchar](50) NULL,
	[background_home] [nvarchar](50) NULL,
	[bird] [nvarchar](50) NULL,
	[bird1] [nvarchar](50) NULL,
	[icon1] [nvarchar](50) NULL,
	[icon2] [nvarchar](50) NULL,
	[icon3] [nvarchar](50) NULL,
	[icon4] [nvarchar](50) NULL,
	[icon5] [nvarchar](50) NULL,
	[icon6] [nvarchar](50) NULL,
	[icon7] [nvarchar](50) NULL,
	[icon8] [nvarchar](50) NULL,
	[icon9] [nvarchar](50) NULL,
	[icon10] [nvarchar](50) NULL,
	[icon13] [nvarchar](50) NULL,
	[icon14] [nvarchar](50) NULL,
	[icon15] [nvarchar](50) NULL,
	[login_opal] [nvarchar](50) NULL,
	[logo] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[theme_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCustomizations]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCustomizations](
	[userCustomization_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[customization_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[userCustomization_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [nvarchar](36) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[fullname] [nvarchar](255) NULL,
	[email] [varchar](100) NULL,
	[gender] [nvarchar](100) NULL,
	[phone_number] [varchar](20) NULL,
	[subscription_plan] [nvarchar](50) NULL,
	[Devicetoken] [nvarchar](max) NULL,
	[role] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSub]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSub](
	[UserSubID] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[subscription_id] [nvarchar](36) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[status] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserSubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTheme]    Script Date: 11/12/2024 6:15:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTheme](
	[userTheme_id] [nvarchar](36) NOT NULL,
	[user_id] [nvarchar](36) NULL,
	[theme_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[userTheme_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customizations] ON 

INSERT [dbo].[Customizations] ([customization_id], [ui_color], [font_color], [font_1], [font_2], [textBox_color], [button_color], [created_at]) VALUES (1, N'0xFFFFE29A', N'0xFF008000', N'Arista', N'KeepCalm', N'0xFFFFA965', N'0xFFFFA965', CAST(N'2024-10-14T08:22:09.170' AS DateTime))
INSERT [dbo].[Customizations] ([customization_id], [ui_color], [font_color], [font_1], [font_2], [textBox_color], [button_color], [created_at]) VALUES (2, N'0xFFFFCD99', N'0xFF548BB4', N'Arista', N'KeepCalm', N'0xFF2F61AB', N'0xFF2F61AB', CAST(N'2024-10-14T08:22:09.170' AS DateTime))
INSERT [dbo].[Customizations] ([customization_id], [ui_color], [font_color], [font_1], [font_2], [textBox_color], [button_color], [created_at]) VALUES (3, N'0xFF548BB4', N'0xFFffBD61', N'Arista', N'KeepCalm', N'0xFFC0E0FF', N'0xFFC0E0FF', CAST(N'2024-10-14T08:22:09.170' AS DateTime))
INSERT [dbo].[Customizations] ([customization_id], [ui_color], [font_color], [font_1], [font_2], [textBox_color], [button_color], [created_at]) VALUES (4, N'0xFFC2CFF9', N'0xFF5B6E85', N'Arista', N'KeepCalm', N'0xFFFFD9E6', N'0x9BCB55', NULL)
SET IDENTITY_INSERT [dbo].[Customizations] OFF
GO
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'06C64447-9F07-403F-BF96-EAAC50E618EF', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', CAST(N'2024-10-22T09:00:00.000' AS DateTime), CAST(N'2024-10-22T17:00:00.000' AS DateTime), CAST(N'2024-10-22T08:55:00.000' AS DateTime), 1, CAST(N'2024-10-22T08:01:29.360' AS DateTime), CAST(N'2024-10-22T08:01:29.360' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'2AF969B6-78F0-4C04-8E6A-D04819AA8835', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', N'123', N'123', CAST(N'2024-11-07T09:00:00.000' AS DateTime), CAST(N'2024-11-07T17:00:00.000' AS DateTime), CAST(N'2024-11-07T08:55:00.000' AS DateTime), 1, CAST(N'2024-11-07T20:21:22.447' AS DateTime), CAST(N'2024-11-07T20:21:22.447' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'2D62C74F-5D55-4C15-87F9-64CE329F3E62', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'222', N'222', CAST(N'2024-11-02T09:00:00.000' AS DateTime), CAST(N'2024-11-02T17:00:00.000' AS DateTime), CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, CAST(N'2024-11-02T16:50:11.600' AS DateTime), CAST(N'2024-11-02T16:50:11.600' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'3A44B094-1774-42F2-AD53-76A4414FBAD6', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', CAST(N'2024-10-22T09:00:00.000' AS DateTime), CAST(N'2024-10-22T17:00:00.000' AS DateTime), CAST(N'2024-10-22T08:55:00.000' AS DateTime), 1, CAST(N'2024-10-22T03:02:58.023' AS DateTime), CAST(N'2024-10-22T03:02:58.023' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'4B3BE489-867D-4C4D-9757-CE24E8407DA9', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', CAST(N'2024-10-22T09:00:00.000' AS DateTime), CAST(N'2024-10-22T17:00:00.000' AS DateTime), CAST(N'2024-10-22T08:55:00.000' AS DateTime), 1, CAST(N'2024-10-22T03:01:39.343' AS DateTime), CAST(N'2024-10-22T03:01:39.343' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'87A35570-C05F-4C01-A3EC-5EF7BF10E6C0', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'Test', N'Test', CAST(N'2024-11-02T09:00:00.000' AS DateTime), CAST(N'2024-11-02T17:00:00.000' AS DateTime), CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, CAST(N'2024-11-02T18:29:37.110' AS DateTime), CAST(N'2024-11-02T18:29:37.110' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'88801A42-6082-477B-A7E1-975A57582548', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'Test2', N'Test2', CAST(N'2024-11-02T09:00:00.000' AS DateTime), CAST(N'2024-11-02T17:00:00.000' AS DateTime), CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, CAST(N'2024-11-02T18:29:57.443' AS DateTime), CAST(N'2024-11-02T18:29:57.443' AS DateTime), N'Thường')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'979F4699-F634-4D97-94EC-B9E7C798773C', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', N'HỌP EXE202', N'- Chiến lược marketing
- Lên kế hoạch tuần sau', CAST(N'2024-11-02T13:16:00.000' AS DateTime), CAST(N'2024-11-02T17:00:00.000' AS DateTime), CAST(N'2024-11-02T13:11:00.000' AS DateTime), 1, CAST(N'2024-11-02T18:32:50.057' AS DateTime), CAST(N'2024-11-02T18:32:50.057' AS DateTime), N'Bình thường')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'9EF4C025-83F2-4462-A0A7-235A64BA42EE', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'Sinh nhat', N'Sinh nhat', CAST(N'2024-10-29T09:00:00.000' AS DateTime), CAST(N'2024-10-29T17:00:00.000' AS DateTime), CAST(N'2024-10-29T08:55:00.000' AS DateTime), 1, CAST(N'2024-10-29T10:01:04.227' AS DateTime), CAST(N'2024-10-29T10:01:04.227' AS DateTime), N'Bình thường')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'E3AAB256-C366-459C-B17C-47BA6716EF39', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', CAST(N'2024-10-27T20:16:00.000' AS DateTime), CAST(N'2024-10-27T22:00:00.000' AS DateTime), CAST(N'2024-10-27T20:11:00.000' AS DateTime), 1, CAST(N'2024-10-27T20:09:44.830' AS DateTime), CAST(N'2024-10-27T20:09:44.833' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'E3FA3FFF-7D3D-4354-937B-ED52F10820D7', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'On tap', N'On Tap', CAST(N'2024-10-29T09:00:00.000' AS DateTime), CAST(N'2024-10-29T22:00:00.000' AS DateTime), CAST(N'2024-10-29T08:55:00.000' AS DateTime), 1, CAST(N'2024-10-29T09:56:06.643' AS DateTime), CAST(N'2024-10-29T09:56:06.643' AS DateTime), N'Bình thường')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'E450419D-6AF8-4DDC-97C2-5240DE7133EB', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', CAST(N'2024-10-26T09:00:00.000' AS DateTime), CAST(N'2024-10-26T17:00:00.000' AS DateTime), CAST(N'2024-10-26T08:55:00.000' AS DateTime), 1, CAST(N'2024-10-26T21:11:18.700' AS DateTime), CAST(N'2024-10-26T21:11:18.700' AS DateTime), N'Quan trọng')
INSERT [dbo].[Events] ([event_id], [user_id], [event_title], [event_description], [start_time], [end_time], [notification_time], [recurring], [created_at], [updated_at], [priority]) VALUES (N'F7AD607C-8F0E-43AC-96AC-F2E7C33E3945', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'Test1', N'Test1', CAST(N'2024-11-02T09:00:00.000' AS DateTime), CAST(N'2024-11-02T17:00:00.000' AS DateTime), CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, CAST(N'2024-11-02T18:29:46.170' AS DateTime), CAST(N'2024-11-02T18:29:46.170' AS DateTime), N'Bình thường')
GO
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'0D6845C4-B072-42F4-9ED3-D1DA68A0A210', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', NULL, N'87A35570-C05F-4C01-A3EC-5EF7BF10E6C0', CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'23BE0F1C-A76E-4824-9146-ADFACACA7F9E', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', NULL, N'88801A42-6082-477B-A7E1-975A57582548', CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'2FCA7C84-6844-45D9-AED7-1B0407DEC40D', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', NULL, N'979F4699-F634-4D97-94EC-B9E7C798773C', CAST(N'2024-11-02T13:11:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'7307EDD7-134C-462C-9779-A0A513A6EB6C', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', NULL, N'2D62C74F-5D55-4C15-87F9-64CE329F3E62', CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'73810B5E-74DA-4794-96BA-E964FDB6F62A', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', NULL, N'4B3BE489-867D-4C4D-9757-CE24E8407DA9', CAST(N'2024-10-22T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'74032815-3CBA-4C33-8673-1A89CDAA2505', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', NULL, N'9EF4C025-83F2-4462-A0A7-235A64BA42EE', CAST(N'2024-10-29T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'863DA37E-D54B-42A7-8C29-D0DCAA86E9C8', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', NULL, N'E3AAB256-C366-459C-B17C-47BA6716EF39', CAST(N'2024-10-27T20:11:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'9B038664-E002-432C-B54A-0D5BD679F368', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', NULL, N'2AF969B6-78F0-4C04-8E6A-D04819AA8835', CAST(N'2024-11-07T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'BCFF21DD-CFBE-487D-A077-5F13F644B787', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', NULL, N'3A44B094-1774-42F2-AD53-76A4414FBAD6', CAST(N'2024-10-22T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'BFB7E585-FD9F-4FDE-BBD7-CCDB5F3F1D14', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', NULL, N'E450419D-6AF8-4DDC-97C2-5240DE7133EB', CAST(N'2024-10-26T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'C96326BB-63A8-43E7-B05A-01236A40D25D', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', NULL, N'F7AD607C-8F0E-43AC-96AC-F2E7C33E3945', CAST(N'2024-11-02T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'EDE0CC88-3BA8-447E-B692-F3C5EFBC0012', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', NULL, N'E3FA3FFF-7D3D-4354-937B-ED52F10820D7', CAST(N'2024-10-29T08:55:00.000' AS DateTime), 1, N'EventReminder')
INSERT [dbo].[Notifications] ([notification_id], [user_id], [task_id], [event_id], [notification_time], [is_sent], [notification_type]) VALUES (N'FC4AD4C7-78F1-4EDE-8A77-4F24EB0F0AD2', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', NULL, N'06C64447-9F07-403F-BF96-EAAC50E618EF', CAST(N'2024-10-22T08:55:00.000' AS DateTime), 1, N'EventReminder')
GO
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'05a95f02-f947-428d-b02f-0567b0bbd0af', N'7049  ', CAST(N'2024-11-07T20:26:51.743' AS DateTime), 1, N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'13884bbc-a384-4cb3-b5ea-c8f743048f70', N'4609  ', CAST(N'2024-10-22T00:08:03.557' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'1d19cd69-c2da-466b-a99c-d6f4a16fe305', N'5661  ', CAST(N'2024-10-20T20:04:06.557' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'3d2280e5-3950-48de-9d56-a9c8057e7dd7', N'9475  ', CAST(N'2024-11-02T18:41:58.657' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'5027b6cf-c1d2-4885-b11b-894eaef25d6f', N'5242  ', CAST(N'2024-10-22T00:05:10.183' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'541652de-38ea-4905-9382-b6589ffe50ec', N'6121  ', CAST(N'2024-10-14T22:52:47.247' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'72b4dbf9-5ea4-4847-baca-555487f3231f', N'5431  ', CAST(N'2024-11-02T18:23:46.320' AS DateTime), 1, N'78f87b20-610f-4dc5-bd39-a42129b3edd5')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'920289ee-0100-4cee-a375-11af3b7a8e3e', N'9297  ', CAST(N'2024-10-20T19:57:31.587' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'cf29fbb1-0f51-49d4-ac7f-c2419a7235ef', N'9848  ', CAST(N'2024-10-14T22:52:47.077' AS DateTime), 0, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
INSERT [dbo].[OTPCode] ([Id], [OTP], [CreatedAt], [IsUsed], [CreatedBy]) VALUES (N'dbd9d0a9-df06-4b1b-b820-6332cbeebb18', N'4712  ', CAST(N'2024-11-02T18:22:01.153' AS DateTime), 1, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843')
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (75, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'3F61E73B-455E-4951-A623-3B749408DF2E', N'c7cc69fc-0e04-487a-9d69-045f429abe49', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-28T16:06:41.513' AS DateTime), N'PENDING')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (76, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'231a9f2c-a5bf-495b-86cf-5a9f2855c2fd', CAST(1000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-27T20:16:23.273' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (77, N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'58e75b78-03dc-4abb-b987-e00be0ce6e2e', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-27T20:17:45.997' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (78, N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'0f193ad9-50c8-42ff-8a1e-70a27053ebc3', CAST(99000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-27T20:48:45.793' AS DateTime), N'CANCELLED')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (79, N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'9d06be34-e40d-4b88-a6ba-11a839b20119', CAST(19000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-27T20:48:54.463' AS DateTime), N'CANCELLED')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (80, N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'b644550e-eff2-436a-a2ba-fc08de56c9f8', CAST(99000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-27T20:50:16.847' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (91, N'd89c05f5-89ac-472c-9bfd-ba7603b01119', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'6a2e8927-b4cd-4a07-90e8-d2104ea451b0', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T08:46:57.310' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (92, N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'0fe001b8-7226-4fdb-a3da-85430f9dd6dc', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T09:47:04.763' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (93, N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'389a8112-205f-45f7-a7d4-fd22af0ddfe8', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T09:47:15.063' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (94, N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'3F61E73B-455E-4951-A623-3B749408DF2E', N'2eedf53a-03c7-4d9f-bf59-665552da2589', CAST(179000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T10:25:22.337' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (95, N'49bc6950-cbb9-44fc-a589-575e07299083', N'3F61E73B-455E-4951-A623-3B749408DF2E', N'33e66b4d-42bd-4c68-b30e-48ec236ba965', CAST(179000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T10:28:38.343' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (96, N'49bc6950-cbb9-44fc-a589-575e07299083', N'3F61E73B-455E-4951-A623-3B749408DF2E', N'695a64f2-5331-426d-9746-a8f73e622e0c', CAST(179000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T10:28:46.983' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (97, N'49bc6950-cbb9-44fc-a589-575e07299083', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'4c0a158a-bdfa-45aa-8fe4-3c7cc5b44d66', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T10:30:27.413' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (98, N'49bc6950-cbb9-44fc-a589-575e07299083', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'0ad00308-cbe6-4dfc-90da-77e39bcfbf23', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T10:31:02.467' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (99, N'841e443d-49b6-4951-bb4f-7c13ddbd47f2', N'3F61E73B-455E-4951-A623-3B749408DF2E', N'f6ace4fb-a8e2-479e-8a65-622dd7876389', CAST(179000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T10:55:13.383' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (100, N'c7710656-e341-425b-8c85-57a2c85c6ad7', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'71569e12-4023-462e-b54f-8617b8fdf1b2', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T11:02:07.903' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (101, N'583645ae-54b6-43fd-8a81-b73ec30947e8', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'9c1102f3-8a6b-44d5-b437-0a80e41436aa', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-29T13:10:09.847' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (102, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'2e54c2ca-84f2-4467-bdbc-d3dd8d9a5b6b', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:54:54.147' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (103, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'0124def6-ac27-4be0-bc14-40f3c46c4c37', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:06.247' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (104, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'a5ddffca-d24b-49c0-8014-b59754fb747b', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:07.057' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (105, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'4b0c5417-6687-419f-b891-faa670b1f9b7', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:07.170' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (106, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'0e9c71e1-0843-425d-9d4b-4ee15263f4c4', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:07.363' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (107, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'3a928a1d-3a9d-4297-b132-46feeabdf037', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:07.497' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (108, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'a84ebb34-d2b0-49da-a128-34019d9d5263', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:10.143' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (109, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'accbbd47-6c3f-4f08-b2e0-07cfda46e8a7', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:10.287' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (110, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'd5897d18-99a2-4381-98b7-3841a0f84b58', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:10.430' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (111, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'd97e6224-b166-4c25-a9dc-a963809bdcb2', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:10.607' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (112, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'aa805cf9-1d03-4a4d-bea2-a82d14a11bdb', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:10.793' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (113, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'ac5d215a-2d26-4915-988c-753c7bc3ecfa', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:11.223' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (114, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'22c873f0-2363-4b4d-8ead-efd5a045270c', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:11.340' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (115, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'f5f81b98-953f-4fec-a617-857e120c191d', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:11.507' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (116, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'1bab6483-7b53-45c9-8dfc-bdb5c7ef9686', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:12.273' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (117, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'60e2099b-6d16-4699-a025-09e65489f1ab', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:12.407' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (118, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'72a9bdd5-08a4-49c2-bedf-a55e93c2fc1e', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:12.550' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (119, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'c6608951-d334-4411-9ac3-3473b54070c2', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:12.957' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (120, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'f6c847af-6fb3-44ec-9a17-8bf2e0076d72', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:41.417' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (121, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'a8def442-00a1-44a8-90d0-18e605811e86', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:42.010' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (122, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'4e61a351-ff67-43de-97b7-156552e34663', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:42.490' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (123, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'826a5193-f223-4106-bc1d-0e56f58d5cb6', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:42.643' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (124, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'489fb46a-3161-4f0d-985b-2c4cdf525a87', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:43.620' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (125, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'3d5aa448-3b0e-433a-b422-4dd0210391f4', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:43.760' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (126, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'd3ef000b-b89c-4dfd-8cb7-b86ebd7a5d7f', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:43.960' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (127, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'ea0258f6-a9db-478f-8e73-7ee3bb9a6328', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:44.153' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (128, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'9032602f-f10b-4fb8-856b-cae4131dea03', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:44.557' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (129, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'19883bef-4043-4237-811a-e6faac88f727', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:44.710' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (130, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'558f2bde-6e34-45bb-99fc-411a388c2428', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:44.863' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (131, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'e43f9e86-e54d-42f6-965f-8f00e60d5f8b', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:55:45.447' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (132, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'001fba0f-4dec-4439-b9b8-eb0076e74979', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:56:05.343' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (133, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'bcf2d4a2-78be-4e28-89a2-20f745aa58b7', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T20:57:09.303' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (134, N'86da20bb-23eb-41db-bf3b-1676ae5e4e79', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'cbb0217a-cc8e-470e-bd5a-04de1faf68b3', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T21:00:10.977' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (135, N'86da20bb-23eb-41db-bf3b-1676ae5e4e79', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'eb1284c0-2f2d-4439-9e9b-4356d9a7b6f1', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T21:04:22.627' AS DateTime), N'CANCELLED')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (136, N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'6d4334e2-4ba6-40bc-92d2-cfda44cdbe06', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T21:06:30.510' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (137, N'a842c297-b7a2-4027-9f42-a9027c5cac56', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'4cd21e6a-0fb7-4f3a-b8b1-ebcb0e473e8c', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-30T21:24:27.123' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (138, N'3c0ca692-4d6b-48b6-a0c0-26fb89407431', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'3c958c39-48c4-43c1-ae43-750eea07f112', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-31T10:46:45.380' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (139, N'bd8a9e64-1929-4873-bd63-7740e9b24fbe', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'7f06b360-aa9c-47e5-8a29-5b7ef2da7412', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-31T22:03:41.577' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (140, N'48d480b0-ca54-4476-b158-59bac9e8ec2d', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'be1b5622-6e3b-4dd6-b91f-1c3767abb58f', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-31T22:07:13.890' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (141, N'92eedb60-26a9-4297-a657-93fb95a81342', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'8e24a42a-52d1-412a-9c58-e470d8dc2cf0', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-31T22:16:28.813' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (142, N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'5ca53a67-9497-4dc0-b05a-416e311165d7', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-10-31T22:17:15.410' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (143, N'48d480b0-ca54-4476-b158-59bac9e8ec2d', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'05006436-c21c-46fd-8a9a-c66c963ec2e1', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-01T08:31:48.557' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (144, N'000c98cf-7091-4837-ab00-04222f37e6ac', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'3af42009-57dc-4ea5-8d73-40e7504112fd', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-03T15:43:39.700' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (145, N'75101d07-653c-49f4-96c7-daba267655e4', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'3d7a9525-5139-47c4-8898-c48f33c1f1c4', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-02T23:45:58.187' AS DateTime), N'CANCELLED')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (146, N'35e5b61d-5756-4380-93df-fe5946eb65bc', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'a08d142f-fac0-4592-b60d-4824296cc395', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-03T15:35:03.810' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (147, N'7320ebff-4178-4dd9-9b23-31a175b2f27e', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'f20eb6f4-9da2-4096-8fd1-dff99e24c0fc', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T11:25:45.970' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (148, N'0c084d9e-98af-4168-8d48-12527f18d999', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'30f99d55-bfc1-4668-b4e3-ff450ed6a2b6', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T21:07:21.207' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (149, N'7634460e-814a-44a0-a142-3195f004fde0', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'efc2e6db-9cb2-4f45-bda2-15fd4045d9d8', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T21:16:41.163' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (150, N'e560f4e8-3530-4f22-938b-981acce04871', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'38bc4961-7585-402d-bb34-0d0fde5114ad', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T22:53:25.973' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (151, N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'38566217-5718-4b29-8603-7bb9ca850063', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T23:25:56.997' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (152, N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'c9a35164-ecb7-42d3-8be6-0d7857abc7da', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T23:26:09.177' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (153, N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'3F61E73B-455E-4951-A623-3B749408DF2E', N'70004114-c36e-4f8d-8d55-4c57468d6f81', CAST(179000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T23:26:11.723' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (154, N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'8a1a9b91-8864-4a7d-bc7f-83d8fc509d84', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T23:26:14.770' AS DateTime), N'Pending')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (155, N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'b3156876-1568-4607-a23b-17332943aacc', CAST(399000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-04T23:27:00.273' AS DateTime), N'PAID')
INSERT [dbo].[Payments] ([payment_id], [user_id], [subscription_id], [transaction_id], [amount], [payment_method], [payment_date], [status]) VALUES (156, N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'70d8a447-b857-4f7a-87ab-41aebcb65c8a', CAST(39000.00 AS Decimal(10, 2)), N'Card', CAST(N'2024-11-07T20:23:10.030' AS DateTime), N'PAID')
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'027ad42d-ca19-41a7-9449-c99ac19eb4ac', N'd57cb9b5-fa9e-42c0-8901-55f82c9ea8ff', 0, 0, 1, CAST(N'2024-11-03T19:58:00.803' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'05a8073d-a19e-4f83-9ee4-fc0df74c098a', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', 0, 1, 1, CAST(N'2024-11-02T16:32:21.560' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'066a1827-5a36-42aa-80ad-a0bd9efb77c3', N'75101d07-653c-49f4-96c7-daba267655e4', 0, 0, 1, CAST(N'2024-11-02T23:34:59.070' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'07acfb80-d4a0-4c43-813b-fa773c051594', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', 33.33, 0, 1, CAST(N'2024-11-07T20:20:11.637' AS DateTime), CAST(N'2024-11-07T20:21:40.610' AS DateTime))
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'0b7c7ab7-5bf3-428b-9d1e-270abb8f7b64', N'f30f9e29-8f16-43fe-95c7-2037315caa3d', 0, 0, 1, CAST(N'2024-11-02T23:24:39.813' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'1260e832-a6b1-4f24-842e-7ecd3d0eb593', N'84f4ff38-856e-473d-9136-d530b8fb571e', 0, 0, 1, CAST(N'2024-11-04T21:24:32.887' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'14dedb02-24d9-4dbf-89c7-c605ca0d609d', N'ef594831-0a94-4abb-a779-ea87fff195af', 0, 0, 1, CAST(N'2024-11-03T20:01:31.047' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'164caded-c3dd-4874-ab31-e43bcd50b5ed', N'5ba85337-3ab0-4564-ab0d-20206ccefc38', 0, 0, 1, CAST(N'2024-11-02T23:22:13.773' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'1e28f4aa-8047-4451-be35-d31458abcf0e', N'dd99a10f-9f9c-4f47-bb8d-dca7b2deb170', 0, 0, 1, CAST(N'2024-11-02T23:25:23.570' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'221daff8-cebb-4b6e-95df-ccc318aad07f', N'3eb1b76c-e1e7-49c3-a864-f393098319ad', 0, 0, 1, CAST(N'2024-11-02T23:17:31.007' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'298494ff-7630-4d8e-a217-cfc57d3073d3', N'8dbcc99b-e073-4fad-a23f-ed3839fe3965', 0, 0, 1, CAST(N'2024-11-04T15:24:09.477' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'2a110d94-eb41-43e2-816d-2040fd59960e', N'637278ef-a976-464f-b21f-f61c817baaea', 0, 0, 1, CAST(N'2024-10-28T20:05:24.993' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'2ccc099e-4bab-4981-94de-25ec3beee988', N'45c53f27-8b00-4096-84ee-063f2362cf78', 0, 0, 1, CAST(N'2024-11-02T23:26:47.163' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'2d269c7f-6f22-404a-b733-ea351b58d63b', N'409670f0-1b60-4ca2-b6c8-f9d9f52eee7e', 0, 0, 1, CAST(N'2024-11-04T15:22:43.057' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'3084ba00-e1f1-4248-a5f9-c98630a56274', N'833f0ba7-6c0f-4b8a-8939-b133f23b9dad', 0, 0, 1, CAST(N'2024-11-02T09:54:37.967' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'33321592-48e7-4a09-9276-3c8dd546b7d3', N'c7710656-e341-425b-8c85-57a2c85c6ad7', 0, 0, 1, CAST(N'2024-10-29T10:59:27.010' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'3ca0f5e5-9f1d-40a3-b9de-508d187a83bc', N'd58a260a-1378-4e46-9045-b1c80caa1216', 0, 0, 1, CAST(N'2024-11-04T21:26:31.690' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'4005a6c5-7f81-4a02-a767-a43ab0c57aab', N'a842c297-b7a2-4027-9f42-a9027c5cac56', 0, 1, 1, CAST(N'2024-10-30T20:58:42.837' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'46201728-8a4e-449d-a7e3-e37267143a63', N'16a0f432-54db-4451-a74c-e234ce67a897', 0, 0, 1, CAST(N'2024-11-04T21:28:12.830' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'48641358-8d93-4aad-a046-0f1a8702a9f1', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', 0.017077636718749289, 100, 3, CAST(N'2024-10-14T21:01:38.543' AS DateTime), CAST(N'2024-10-26T21:26:47.790' AS DateTime))
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'4fe89474-086f-442c-994b-442553c57256', N'000c98cf-7091-4837-ab00-04222f37e6ac', 0, 0, 1, CAST(N'2024-10-27T21:23:30.287' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'512577ba-8751-422b-a7be-9e7fef3e2550', N'583645ae-54b6-43fd-8a81-b73ec30947e8', 0, 2, 1, CAST(N'2024-10-29T13:05:21.013' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'5335d948-33c1-43fe-81b5-b5fdb9da1858', N'd6f7ccdc-f9eb-4518-9eac-93f881b34c75', 0, 0, 1, CAST(N'2024-11-02T10:01:11.513' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'551180c2-2566-4cfa-b436-4c30d78e1327', N'814e50d5-efca-4f1e-9d31-0cb99dd92a6d', 0, 0, 1, CAST(N'2024-11-03T20:04:53.210' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'55203935-2581-4c75-81be-48edc8012365', N'717b9b48-99ac-4f89-a5fb-39c9a47ec029', 0, 0, 1, CAST(N'2024-11-02T23:18:50.013' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'558f7626-cd0d-4dd3-a214-3855c99d7aa3', N'4be6d90e-cf8c-43b3-87e2-ed313a015294', 0, 0, 1, CAST(N'2024-11-02T23:18:05.150' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'55f3c185-1548-450f-83c4-11abbbe715cc', N'bbd10b9b-284b-487d-84ec-2c3fb1f83727', 0, 0, 1, CAST(N'2024-11-03T20:00:10.343' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'597209d4-1e5a-4e57-a5f9-1ca55566e0eb', N'cd304b04-0da4-4cad-8b2f-92fb6a846ddc', 0, 0, 1, CAST(N'2024-11-04T21:27:23.140' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'5aa079a0-562a-44f8-9fd7-dc32236ef5db', N'48d480b0-ca54-4476-b158-59bac9e8ec2d', 0, 0, 1, CAST(N'2024-10-31T22:03:36.797' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'62627c15-3e25-426e-bdfa-0a993c8fa886', N'918dc1d9-186d-40e7-8726-93646f31ad2f', 0, 0, 1, CAST(N'2024-11-02T09:59:42.193' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'6bdf972e-76cf-4bcd-9962-58aaeccf2d1f', N'fac983a3-6ba6-4e25-a1c4-c4d7f65db16e', 0, 0, 1, CAST(N'2024-11-02T09:55:18.020' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'701aeda2-55ec-4768-a673-278aaa07e5a8', N'bd8a9e64-1929-4873-bd63-7740e9b24fbe', 0, 0, 1, CAST(N'2024-10-31T22:00:38.390' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'70834208-8ec9-4ed9-998d-1503fe6646eb', N'92eedb60-26a9-4297-a657-93fb95a81342', 0, 0, 1, CAST(N'2024-10-31T22:12:03.367' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'72a545e7-1d54-4c65-92ad-e55133964937', N'd89c05f5-89ac-472c-9bfd-ba7603b01119', 0, 0, 1, CAST(N'2024-10-29T08:24:31.400' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'73547dc2-cc60-4145-84b8-6197a0515402', N'43eea021-3e39-4ac4-8973-173bfca8b22a', 0, 0, 1, CAST(N'2024-11-04T15:26:09.453' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'775b8474-697f-48da-8e2f-24ae08ad6f40', N'bae4f2b2-1c0e-441f-927b-5fa89db8d713', 0, 0, 1, CAST(N'2024-11-03T19:59:21.950' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'7df76fc1-759c-4309-95df-05413ee1bc58', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', 0, 1, 4, CAST(N'2024-10-29T10:22:32.127' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'80d16ff2-c76b-489c-8f5d-ab9c4e31241b', N'2eed2c9d-3514-41f7-9801-5bfa4f42045e', 0, 0, 1, CAST(N'2024-11-04T15:21:55.700' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'852e7b62-97d8-4ca7-abf0-c5e8c6c5a969', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', 0.31999999999999318, 59, 4, CAST(N'2024-10-29T09:44:09.940' AS DateTime), CAST(N'2024-10-29T10:36:25.263' AS DateTime))
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'8a0ba6af-a29e-409f-9a50-cbc53353d160', N'49bc6950-cbb9-44fc-a589-575e07299083', 100, 0, 4, CAST(N'2024-10-29T10:26:13.797' AS DateTime), CAST(N'2024-10-29T10:36:43.277' AS DateTime))
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'90f6dd2b-7d9c-464a-8d15-e9848b59ed30', N'7d9997c6-3840-4ab5-b969-ff663cac3ae3', 0, 0, 1, CAST(N'2024-11-03T20:02:17.230' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'970c8ff4-7ead-499b-a225-2fc65be27b4e', N'764f3f62-c21f-41a2-b05a-6ee34d31a99f', 0, 0, 1, CAST(N'2024-11-02T23:16:48.960' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'987c7e6d-7da6-4d82-ad58-1f3899546ab3', N'c861f854-922c-4513-98b2-7d7b69918d8c', 0, 0, 1, CAST(N'2024-11-02T09:58:40.413' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'98b922b4-1e57-4c7d-a13a-90682abd070b', N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', 0.1301953125, 0, 1, CAST(N'2024-10-27T20:46:46.633' AS DateTime), CAST(N'2024-10-27T20:49:14.143' AS DateTime))
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'9aae2c65-0863-4729-adc6-5fed46f8f000', N'e560f4e8-3530-4f22-938b-981acce04871', 0, 0, 1, CAST(N'2024-11-04T22:28:16.663' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'9ca9ffd5-42a3-4e54-874d-7710eb0adfc7', N'55580139-98ce-489e-a6aa-8400fa86a46b', 0, 0, 1, CAST(N'2024-11-04T15:24:55.517' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'9ecfc69a-f757-45f4-8950-934e0da1d898', N'c465f3af-7928-4ab3-8101-a7bb03b0d6ad', 0, 0, 1, CAST(N'2024-11-02T09:55:47.537' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'9fc05206-d27e-4aff-800c-433d13f89543', N'03882d8d-ab53-4240-847d-6d6a4553806b', 0, 0, 1, CAST(N'2024-10-27T20:29:11.380' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'a2861e91-9e29-48a9-a33f-7bf516410949', N'0f663bf3-a9f9-47fb-b76f-3b2c790e9d7a', 0, 0, 1, CAST(N'2024-11-04T15:27:37.417' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'b1ccdd60-9020-4a0d-8bf5-ab31430a836d', N'31690749-7ede-4241-88ef-0a32f3b9cf22', 0, 0, 1, CAST(N'2024-11-04T21:25:32.480' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'b917838d-dfae-4504-b519-ee0b04f3cb53', N'd9134203-e96f-4ba3-a7c9-bfdc5acb0b75', 0, 0, 1, CAST(N'2024-10-31T22:07:17.130' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'bbb620cd-6407-4613-aa15-a1ec8563a268', N'b1c6f65b-bbf0-4300-aef6-1f17e9e3eea7', 0, 0, 1, CAST(N'2024-11-04T21:25:01.977' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'bcdd1c69-c72a-4414-a444-ef89e380fd6c', N'b125833c-7b07-46ab-9fbd-38b39e78c4fc', 0, 0, 1, CAST(N'2024-11-03T20:03:04.533' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'c302968d-29c4-47d8-8f07-0cb1ba72a61e', N'c7c412f0-c764-4f83-94c7-da01ba14879a', 1.38640625, 200, 4, CAST(N'2024-11-04T23:23:44.193' AS DateTime), CAST(N'2024-11-04T23:33:22.790' AS DateTime))
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'c395f9a5-9b7f-45fe-a5b3-fe5b72c170ba', N'8c0a697f-4657-466a-831f-4b810e118d80', 0, 0, 1, CAST(N'2024-11-02T09:58:06.967' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'c4af8de8-5150-41c7-a08f-57a9821e2db2', N'b380c110-cd2e-4734-bbbe-09343f97a4f1', 0, 0, 1, CAST(N'2024-11-02T10:01:39.800' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'c58fccd1-0277-418a-b7fd-c11e7c401dfb', N'6718bd8e-a579-48f3-bc8f-93072acb16fd', 0, 0, 1, CAST(N'2024-11-03T19:57:27.407' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'c7b3e99c-9e48-4954-9386-a246249c2c76', N'7634460e-814a-44a0-a142-3195f004fde0', 0, 0, 1, CAST(N'2024-11-04T21:13:55.037' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'c8a81f23-4d8b-4557-b074-4a468fd32d54', N'7320ebff-4178-4dd9-9b23-31a175b2f27e', 0, 0, 1, CAST(N'2024-11-04T11:01:25.110' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'd4a29bac-c347-4338-8be9-c3ecd26594ce', N'd0773dc7-85de-4aeb-8183-0f9f4f1d6056', 0, 0, 1, CAST(N'2024-11-03T20:04:21.843' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'e203ce7d-4431-482b-9999-0f28900e1011', N'767dfb90-b9ec-4f91-9217-c49f6de43d08', 0, 0, 1, CAST(N'2024-11-02T23:24:06.183' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'e4f1c180-413d-4bcc-b262-96eefd57707e', N'fc7dea98-1d50-484c-9f42-8b91db72d74d', 0, 0, 1, CAST(N'2024-11-04T15:27:02.143' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'eb8f8bd7-6137-4341-8574-b9bb3917dc7f', N'841e443d-49b6-4951-bb4f-7c13ddbd47f2', 0, 0, 1, CAST(N'2024-10-29T10:51:00.623' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'eeaf9f1e-1308-497b-bdad-4bedcebc24f0', N'3c0ca692-4d6b-48b6-a0c0-26fb89407431', 0, 0, 1, CAST(N'2024-10-31T10:18:45.390' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'f340f0f5-7e8c-4a32-960b-f772ad1cc835', N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', 0, 0, 1, CAST(N'2024-10-31T22:12:09.263' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'f3fbe998-2d8f-41f7-ba1b-ea8062f8b8f9', N'35e5b61d-5756-4380-93df-fe5946eb65bc', 0, 0, 1, CAST(N'2024-11-03T15:31:01.893' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'f8130e23-fc1b-4dec-8bf9-2df736fd00cd', N'f1c810c2-f656-45f2-8f59-7db2507b919e', 0, 0, 1, CAST(N'2024-11-03T20:00:44.083' AS DateTime), NULL)
INSERT [dbo].[Seeds] ([seed_id], [user_id], [percent_growth], [seed_count], [parrot_level], [created_at], [LastFedDate]) VALUES (N'fe1f5ee4-1665-4c17-84db-87fdd2d75d94', N'0c084d9e-98af-4168-8d48-12527f18d999', 0, 0, 1, CAST(N'2024-11-04T21:00:41.063' AS DateTime), NULL)
GO
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', N'VIP', 365, CAST(399000.00 AS Decimal(10, 2)), N'12-months VIP subscription', N'Active')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'28EF80BD-199D-45CB-9267-D56E8B2C2C7F', N'Basic Plan', 1, CAST(2000.00 AS Decimal(10, 2)), N'1-month basic subscription', N'Not Active')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'3AF26812-112E-4859-8EB4-863AE4FD8110', N'Student Plan', 12, CAST(90000.00 AS Decimal(10, 2)), N'12-month student subscription', N'Not Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'3F61E73B-455E-4951-A623-3B749408DF2E', N'Enterprise', 180, CAST(179000.00 AS Decimal(10, 2)), N'6-months enterprise subscription', N'Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'6CDB18E9-7F42-4069-BED7-0B43E8D32E77', N'Pro Plan', 1, CAST(15000.00 AS Decimal(10, 2)), N'1-month pro subscription', N'Not Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'8F5DDE57-C3FF-4F03-8167-35CCA5EC174E', N'Family Plan', 6, CAST(29999.00 AS Decimal(10, 2)), N'6-month family subscription', N'Not Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'E0815EB9-7E40-4539-A35B-18CAE0E66509', N'Standard Plan', 3, CAST(12000.00 AS Decimal(10, 2)), N'3-month standard subscription', N'Not Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'E8D87ECB-59CD-4C39-A2B6-AE6490C607D3', N'Premium Plan', 6, CAST(19000.00 AS Decimal(10, 2)), N'6-month premium subscription', N'Not Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', N'Ultimate', 30, CAST(39000.00 AS Decimal(10, 2)), N'1-month ultimate subscription', N'Active ')
INSERT [dbo].[Subscriptions] ([subscription_id], [SubName], [Duration], [Price], [SubDescription], [status]) VALUES (N'FF6F4844-707F-4CA0-8BAC-3ADBD3988BAA', N'Advanced Plan', 3, CAST(2500000.00 AS Decimal(10, 2)), N'2 years advanced subscription', N'Not Active ')
GO
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'1938f4cb-2924-43ae-9eb6-0d7e52e6aff2', N'a842c297-b7a2-4027-9f42-a9027c5cac56', N'Tien bucu Duc', N'Tien bucu Duc nha', N'Bình Thường', CAST(N'2024-10-30T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-30T14:04:11.323' AS DateTime), CAST(N'2024-10-30T14:04:11.323' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'22d7c567-dc48-42d0-9255-6605c532a677', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', N'123', N'123', N'Quan trọng', CAST(N'2024-11-07T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-11-07T13:21:05.843' AS DateTime), CAST(N'2024-11-07T13:21:05.843' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'23212897-ac6b-4a54-907a-1270bee113aa', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', N'Quan trọng', CAST(N'2024-10-26T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-10-26T14:09:30.847' AS DateTime), CAST(N'2024-10-26T14:09:30.847' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'2af90dbb-34ca-46e0-8e2d-8754c58a5402', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'Hoc bai', N'Hoc bai', N'Bình Thường', CAST(N'2024-10-29T00:00:00.000' AS DateTime), CAST(N'10:00:00' AS Time), 1, N'True', CAST(N'2024-10-29T02:52:16.120' AS DateTime), CAST(N'2024-10-29T02:52:16.120' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'2d00c4de-8d5a-4434-ae61-282b3f686595', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'Test', N'Test', N'Quan trọng', CAST(N'2024-11-02T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-11-02T11:26:46.833' AS DateTime), CAST(N'2024-11-02T11:26:46.833' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'36047ed5-a8ab-42e6-9a11-c747d3917517', N'49bc6950-cbb9-44fc-a589-575e07299083', N'new task', N'new task', N'Quan trọng', CAST(N'2024-10-30T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-29T03:34:26.603' AS DateTime), CAST(N'2024-10-29T03:34:26.603' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'75240153-f660-4d2f-87b6-9a9b88d5ae4a', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', N'Quan trọng', CAST(N'2024-10-14T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-14T14:24:10.253' AS DateTime), CAST(N'2024-10-14T14:24:10.253' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'7cf9b962-4fc7-4132-b909-80754fae5a08', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'test2', N'test2', N'Thường', CAST(N'2024-11-02T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-11-02T11:27:06.660' AS DateTime), CAST(N'2024-11-02T11:27:06.660' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'812a14eb-cd9f-4240-a627-6ecf1341b36b', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', N'Làm bài tập PRE', N'', N'Quan trọng', CAST(N'2024-11-02T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-11-02T12:00:42.170' AS DateTime), CAST(N'2024-11-02T12:00:42.170' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'8ca2d31e-27bd-41f2-8bff-9fa41c8a1acd', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', N'Quan trọng', CAST(N'2024-10-27T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-10-26T14:02:50.213' AS DateTime), CAST(N'2024-10-26T14:02:50.213' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'94fcec17-ec3a-4120-8ace-ffda09bbebe9', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', N'Quan trọng', CAST(N'2024-10-22T00:00:00.000' AS DateTime), CAST(N'11:00:00' AS Time), 0, N'False', CAST(N'2024-10-21T20:06:03.433' AS DateTime), CAST(N'2024-10-21T20:06:03.433' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'a40569da-00a0-46a8-b35d-29e57258ddbd', N'583645ae-54b6-43fd-8a81-b73ec30947e8', N'hxjxjdnd', N'gshe', N'Quan trọng', CAST(N'2024-10-29T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-10-29T06:10:28.987' AS DateTime), CAST(N'2024-10-29T06:10:28.987' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'b0e9bacf-0581-42fb-93e1-0bef1c13b1d5', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'123', N'123', N'Thường', CAST(N'2024-10-26T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-10-26T14:09:17.300' AS DateTime), CAST(N'2024-10-26T14:09:17.300' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'b297cb2a-e5e7-4749-9766-b4836371e753', N'49bc6950-cbb9-44fc-a589-575e07299083', N'task 2', N'task 2', N'Quan trọng', CAST(N'2024-10-29T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-29T03:34:57.750' AS DateTime), CAST(N'2024-10-29T03:34:57.750' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'b72e78b0-793a-417c-b2ef-0e0921d65617', N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', N'3D', N'Anim nhân vật', N'Quan trọng', CAST(N'2024-10-31T00:00:00.000' AS DateTime), CAST(N'11:30:00' AS Time), 0, N'False', CAST(N'2024-10-31T15:21:36.670' AS DateTime), CAST(N'2024-10-31T15:21:36.670' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'bd650a98-376b-43bf-8661-9d741466f2a7', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'Hoc bai PRM', N'Hoc on FE', N'Bình Thường', CAST(N'2024-10-30T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-29T02:54:13.063' AS DateTime), CAST(N'2024-10-29T02:54:13.063' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'cfc09a62-3d79-4bce-b164-769f923f1d2a', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', N'Đi chợ mua đồ ăn', N'', N'Bình Thường', CAST(N'2024-11-02T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-11-02T11:36:58.520' AS DateTime), CAST(N'2024-11-02T11:36:58.520' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'e9599ce4-6999-4083-a652-9473d5b59c88', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'test1', N'test1', N'Bình Thường', CAST(N'2024-11-02T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 0, N'False', CAST(N'2024-11-02T11:26:56.387' AS DateTime), CAST(N'2024-11-02T11:26:56.387' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'f00a15f9-e670-45dc-8881-ad404a29cdc7', N'583645ae-54b6-43fd-8a81-b73ec30947e8', N'tét', N'tét', N'Bình Thường', CAST(N'2024-10-29T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-29T06:06:35.420' AS DateTime), CAST(N'2024-10-29T06:06:35.420' AS DateTime))
INSERT [dbo].[Tasks] ([task_id], [user_id], [title], [description], [priority], [due_date], [time_task], [is_completed], [status], [created_at], [updated_at]) VALUES (N'fa9e838f-c0ae-48e2-96cf-a8116320eb7a', N'583645ae-54b6-43fd-8a81-b73ec30947e8', N'tét', N'tét', N'Quan trọng', CAST(N'2024-10-29T00:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), 1, N'True', CAST(N'2024-10-29T06:06:51.523' AS DateTime), CAST(N'2024-10-29T06:06:51.523' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Theme] ON 

INSERT [dbo].[Theme] ([theme_id], [background_bird], [background_home], [bird], [bird1], [icon1], [icon2], [icon3], [icon4], [icon5], [icon6], [icon7], [icon8], [icon9], [icon10], [icon13], [icon14], [icon15], [login_opal], [logo]) VALUES (1, N'assets/background.png', N'assets/Theme Christmas Opal-11.png', N'assets/bird.png', N'assets/bird1.png', N'assets/icon opal-01.png', NULL, NULL, NULL, N'assets/icon opal-05.png', NULL, N'assets/icon opal-07.png', N'assets/icon opal-08.png', N'assets/icon opal-09.png', NULL, NULL, NULL, NULL, N'assets/login-opal.png', N'assets/logo.png')
INSERT [dbo].[Theme] ([theme_id], [background_bird], [background_home], [bird], [bird1], [icon1], [icon2], [icon3], [icon4], [icon5], [icon6], [icon7], [icon8], [icon9], [icon10], [icon13], [icon14], [icon15], [login_opal], [logo]) VALUES (2, N'assets/Theme Christmas Opal-11.png', N'assets/Theme Christmas Opal-11.png', N'assets/Theme Christmas Opal-01.png', N'assets/Theme Christmas Opal-01.5.png', N'assets/icon1.png', N'assets/Theme Christmastask.png', N'assets/Theme ChristmasEvent.png', N'assets/Frame19.png', N'assets/Theme Christmas Opal-05.png', N'assets/Theme Christmas Opal-06.png', N'assets/Theme Christmas Opal-07.png', N'assets/Theme Christmas Opal-08.png', N'assets/Theme Christmas Opal-09.png', N'assets/Theme Christmas Opal-10.png', N'assets/Theme Christmashome.png', N'assets/Theme Christmas Opal-12.png', N'assets/Theme Christmas.png', N'assets/Theme Christmas Opal-15.png', N'assets/Theme Christmas Opal-15.png')
SET IDENTITY_INSERT [dbo].[Theme] OFF
GO
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'0a8c7f88-1b31-429b-8209-2a50f34614b7', N'2eed2c9d-3514-41f7-9801-5bfa4f42045e', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'0c656586-1b2d-43aa-a53b-1c89aca8539f', N'637278ef-a976-464f-b21f-f61c817baaea', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'10b746b8-d810-43e2-a672-ef04094dfa72', N'8c0a697f-4657-466a-831f-4b810e118d80', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'13454d27-b04f-4870-ab7b-6d31ca1c570c', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', 3)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'135c926f-ca36-47a7-ae81-06708f2e8853', N'bd8a9e64-1929-4873-bd63-7740e9b24fbe', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'14935fc8-e212-482f-a45e-004ba632ad98', N'49bc6950-cbb9-44fc-a589-575e07299083', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'1628bcb6-fbcf-4ba0-8d8e-654120027e92', N'92eedb60-26a9-4297-a657-93fb95a81342', 3)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'17a30ff1-0617-4b61-bd29-1d1b6a372ce2', N'43eea021-3e39-4ac4-8973-173bfca8b22a', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'1c6caa1e-1eaa-4595-b710-2224ad18ce2a', N'4be6d90e-cf8c-43b3-87e2-ed313a015294', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'1d3173dd-9893-4528-b3f3-ab08bc514291', N'767dfb90-b9ec-4f91-9217-c49f6de43d08', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'222b5eff-13cd-4054-81af-a9185d854ab7', N'409670f0-1b60-4ca2-b6c8-f9d9f52eee7e', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'2d8bf184-fe7d-4847-8f7e-8e4280344763', N'd58a260a-1378-4e46-9045-b1c80caa1216', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'2DD3F697-CBAD-4528-8950-98E99A24597C', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'34e20f26-7354-408d-9dd8-9e2ec5ecf140', N'7634460e-814a-44a0-a142-3195f004fde0', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'3b832806-e79a-47ba-8376-ae8bbb3d4e68', N'000c98cf-7091-4837-ab00-04222f37e6ac', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'3c2b2ac0-75a8-42d3-b536-4cbe96c9cb84', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'429c7935-42fb-40cd-a66f-b3dc03e2f934', N'd0773dc7-85de-4aeb-8183-0f9f4f1d6056', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'44269b56-42e1-48af-a00c-bbd7c28b5af7', N'cd304b04-0da4-4cad-8b2f-92fb6a846ddc', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'45fec3b6-1b35-41d0-bad2-1d9cbf797414', N'c465f3af-7928-4ab3-8101-a7bb03b0d6ad', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'46b40a83-b028-4e7a-bfbf-65f0135261f3', N'b125833c-7b07-46ab-9fbd-38b39e78c4fc', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'4bca6bb0-77a5-4ab5-bea9-1cb16eb2d93b', N'8dbcc99b-e073-4fad-a23f-ed3839fe3965', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'4e59d717-ac01-4820-8c1b-36f7ef144679', N'fac983a3-6ba6-4e25-a1c4-c4d7f65db16e', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'4f2cf6a8-b314-4763-bdea-3ddd1c5c194e', N'03882d8d-ab53-4240-847d-6d6a4553806b', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'5016b746-1274-4b18-b2d5-6a56ee446621', N'45c53f27-8b00-4096-84ee-063f2362cf78', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'526e70ea-4269-4216-a68a-00b0f0e0d487', N'dd99a10f-9f9c-4f47-bb8d-dca7b2deb170', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'54e7a43e-096a-4292-914f-b9f748e0021e', N'd57cb9b5-fa9e-42c0-8901-55f82c9ea8ff', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'5eb09c11-2d29-47e3-acfb-5af1e2d99aa2', N'55580139-98ce-489e-a6aa-8400fa86a46b', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'617dfbf1-1205-4bd8-ae46-70a83e3b389a', N'c7c412f0-c764-4f83-94c7-da01ba14879a', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'62b2ced3-89e4-4480-ae9f-d1c646cfbd56', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'65f91902-0529-48f4-85a9-a841ad0f11ee', N'918dc1d9-186d-40e7-8726-93646f31ad2f', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'66166e89-91a7-4ddc-830a-855a69135ab1', N'b1c6f65b-bbf0-4300-aef6-1f17e9e3eea7', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'6aa03e1f-e66f-49d4-9a3a-ccf1b2afdb0f', N'b380c110-cd2e-4734-bbbe-09343f97a4f1', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'6aecdd84-6f19-4d3f-ac28-3f9868fdb93e', N'5ba85337-3ab0-4564-ab0d-20206ccefc38', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'70a183a8-46a6-4cb0-8253-b254ee7b49b7', N'16a0f432-54db-4451-a74c-e234ce67a897', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'75d8db1d-5b6b-4fbd-9911-985ffc055fb2', N'c7710656-e341-425b-8c85-57a2c85c6ad7', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'78108aeb-fc81-485b-b8d6-d56ae6eb6def', N'a842c297-b7a2-4027-9f42-a9027c5cac56', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'79d425ee-75bc-4c95-926d-c95136b05146', N'f30f9e29-8f16-43fe-95c7-2037315caa3d', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'83231779-82c6-4d36-aec8-d35f9c9db385', N'717b9b48-99ac-4f89-a5fb-39c9a47ec029', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'84fb80cc-e8b1-40cd-833e-6f4c32a100da', N'd89c05f5-89ac-472c-9bfd-ba7603b01119', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'883f717d-9b78-44fe-84c0-097a313fff03', N'35e5b61d-5756-4380-93df-fe5946eb65bc', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'8f8800f9-d75b-47c7-87f2-ce7e134d93df', N'd6f7ccdc-f9eb-4518-9eac-93f881b34c75', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'8ffd6a0f-055e-477e-8f3c-cafb401743b5', N'764f3f62-c21f-41a2-b05a-6ee34d31a99f', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'9512c8a9-cdc0-41b3-82d1-070db04f0851', N'e560f4e8-3530-4f22-938b-981acce04871', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'9a14e0a3-19c5-4f6f-b618-70f9f4627754', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'9dda3f57-2f81-404b-a076-e1c553c49215', N'84f4ff38-856e-473d-9136-d530b8fb571e', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'a5a196cb-ec36-4abb-9d09-ac8cf0334ec2', N'f1c810c2-f656-45f2-8f59-7db2507b919e', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'a5bd0150-de99-4848-b422-390c29a00335', N'583645ae-54b6-43fd-8a81-b73ec30947e8', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'a6d3ee6c-021e-496c-a68d-f677c2e82ee8', N'841e443d-49b6-4951-bb4f-7c13ddbd47f2', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'ac77aa6f-bf97-4c3a-a6dd-d62b84b7c10a', N'75101d07-653c-49f4-96c7-daba267655e4', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'afb7ca5d-46b7-4a4b-8e53-3bf52962bbc2', N'7320ebff-4178-4dd9-9b23-31a175b2f27e', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'b5c6e333-fab0-4d27-9ce6-523add8ffbc6', N'6718bd8e-a579-48f3-bc8f-93072acb16fd', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'ba77a105-b94e-453c-837f-178cd9d83f02', N'3eb1b76c-e1e7-49c3-a864-f393098319ad', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'bc51b9b2-dd8c-42a2-a80a-83abca2b88a8', N'ef594831-0a94-4abb-a779-ea87fff195af', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'bc71f0c3-e673-4f90-8c97-caa35db1b2be', N'bae4f2b2-1c0e-441f-927b-5fa89db8d713', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'bc98b4fd-9bac-4dba-9277-53ecc9767a88', N'48d480b0-ca54-4476-b158-59bac9e8ec2d', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'bd40ba7b-505b-4bab-9ba8-421a517e1cd7', N'0c084d9e-98af-4168-8d48-12527f18d999', 4)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'c47983fb-6c61-4c3b-b8ff-b8b9937973c6', N'3c0ca692-4d6b-48b6-a0c0-26fb89407431', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'ca9bdc6d-e1c2-4d74-9ee6-6bd255eab759', N'c861f854-922c-4513-98b2-7d7b69918d8c', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'cea1a1c3-d4db-40ff-8a63-fba059193529', N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'd4750d8c-c454-4a36-b990-06b39315a9ab', N'fc7dea98-1d50-484c-9f42-8b91db72d74d', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'e18110cc-ce4f-49df-89c5-76d008842bef', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'e882c9ef-da84-4ae8-ac02-6bbbbfdd7338', N'0f663bf3-a9f9-47fb-b76f-3b2c790e9d7a', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'e9299842-77a5-4542-bf7e-f085a97aff50', N'd9134203-e96f-4ba3-a7c9-bfdc5acb0b75', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'eba67a6c-30c8-4fb7-b091-02081dfbe5e1', N'31690749-7ede-4241-88ef-0a32f3b9cf22', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'f1a6b269-9c32-483f-b5a0-8706dace3630', N'833f0ba7-6c0f-4b8a-8939-b133f23b9dad', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'f2f5457f-1408-4241-a02b-8ea1ee32439f', N'bbd10b9b-284b-487d-84ec-2c3fb1f83727', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'f63cc6eb-31a7-455f-ac86-b36453914fcb', N'814e50d5-efca-4f1e-9d31-0cb99dd92a6d', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'f944a889-203c-4d9d-84fd-5fba5a0d7296', N'7d9997c6-3840-4ab5-b969-ff663cac3ae3', 1)
INSERT [dbo].[UserCustomizations] ([userCustomization_id], [user_id], [customization_id]) VALUES (N'fb30156e-adeb-409c-82fb-cf546b7afeb1', N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', 4)
GO
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'000c98cf-7091-4837-ab00-04222f37e6ac', N'tuanbui46789@gmail.com', N'061435d2b8bbe428d89d6665e2497fd4e27f20ab6dd6d8d82f5f44d448efe0d4', N'Bùi Đức Việt Tuấn', N'tuanbui46789@gmail.com', N'', N'0869618179', N'Premium', N'em2SBfDxTweDOeMY-ibGFW:APA91bGahrB0hgVTHC2MNuUePf5rb5G9PszLuog1quMoO7bKCCACcvcTFIg0Fw1hbYo7iITGTrpy8WDMh_xkwNaeAjXM7R3qCvCKiFyDX91zf2kICDE0-MKEfhtONNsVuS9UKZ8Fe4iL', N'User', CAST(N'2024-10-27T21:23:27.610' AS DateTime), CAST(N'2024-10-27T21:23:27.610' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'03882d8d-ab53-4240-847d-6d6a4553806b', N'nhoxnaughty2810@gmail.com ', N'70e074d6f5e18882a775c40c2179f59f5ba9afddd0fcc69044e5180e08d53543', N'Toàn Ngô', N'nhoxnaughty2810@gmail.com ', N'', N'0945330766', N'Premium', N'fUYb_xRcSu2vcMfxwY__vW:APA91bGUepXE5flvOmBgLBeYRLFEKcrlg8zFfbOP2IMB5QqlkK2cmrBkXVMo8UYA2aei7I7QyUBbmYfUEiNSgxz90cJcE9tZcBj5ntIM04hpE2KrIB3XjRylnx9UkXfEZ6uq4mPYrtX2', N'User', CAST(N'2024-10-27T20:29:08.207' AS DateTime), CAST(N'2024-10-27T20:29:08.207' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'0c084d9e-98af-4168-8d48-12527f18d999', N'bbktrisVy@gmail.com', N'5d47d45daa50607a0485d12ff9247409d82e52040be138d4e586ac287d713a05', N'Nguyen Trieu Vy', N'bbktrisVy@gmail.com', N'', N'09073113433', N'Premium', NULL, N'User', CAST(N'2024-11-04T21:00:38.057' AS DateTime), CAST(N'2024-11-04T21:00:38.057' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'0f663bf3-a9f9-47fb-b76f-3b2c790e9d7a', N'ducvingo@gmail.com', N'dc671e55d24e8c8cfd57e2ce2cbc3c5dcb3529cb8868c00d76b3fa82b71ab0da', N'Ngo Vi Duong', N'ducvingo@gmail.com', N'', N'09376439287', N'Free', NULL, N'User', CAST(N'2024-11-04T15:27:35.107' AS DateTime), CAST(N'2024-11-04T15:27:35.107' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'16a0f432-54db-4451-a74c-e234ce67a897', N'vominhphuo@gmail.com', N'7490c0aa95af7c74958d6a5279e0881df389d39b6ea97f8b46c471cc520dd8a7', N'Hoang Vo Dao Minh', N'vominhphuo@gmail.com', N'', N'09022269872', N'Free', NULL, N'User', CAST(N'2024-11-04T21:28:10.523' AS DateTime), CAST(N'2024-11-04T21:28:10.523' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', N'ngohongquyen040503@gmail.com ', N'9b5555aa85501abd00c6a6257a4bbcbc1f57bd3aaf33c9745effa31d2f3ecb76', N'Ngô Quyên', N'ngohongquyen040503@gmail.com ', N'', N'0334623503', N'Free', N'fYiYbbK3T5CeWon7WTYkQE:APA91bFIdEBy_beVyD-l_ce8Hw-DfCzKjpIO7SuP7oM4glQ9ajgDis8sA_TotgBVNPZwmCvrGp0_ZEsxJMRsmobMjMr_QgmwhV2yMPgZeE1ofJddHNOlaCg', N'User', CAST(N'2024-11-02T16:32:19.087' AS DateTime), CAST(N'2024-11-02T16:32:19.087' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'2eed2c9d-3514-41f7-9801-5bfa4f42045e', N'viettoan@gmail.com', N'353221b8d496ff981b36dc8e1c37095ea6bf050b3170bf84616bc2bb3daa5274', N'Tran Viet Toan', N'viettoan@gmail.com', N'', N'0949836552', N'Free', NULL, N'User', CAST(N'2024-11-04T15:21:53.380' AS DateTime), CAST(N'2024-11-04T15:21:53.380' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'31690749-7ede-4241-88ef-0a32f3b9cf22', N'tranheooog@gmail.com', N'69546c084d4f1fc6a273410784fc37f7db6c078b5eb78c86836b002675b42e4f', N'Vo Hoang Tran', N'tranheooog@gmail.com', N'', N'09063398752', N'Free', NULL, N'User', CAST(N'2024-11-04T21:25:30.160' AS DateTime), CAST(N'2024-11-04T21:25:30.160' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'nguyevitien2003@gmail.com', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'nguyevitien', N'nguyevitien2003@gmail.com', N'', N'0903764392', N'Premium', N'eqrTf4jWSGOENmkLcIfZ4T:APA91bHOaCEadoj7rNfIqrGkTzDD4QsxnQnaqvtpjvZNIKx5_YRwNLfT1xqt8irMOk48sf-VN93wU8B4Aay1lE5OUIlnxN1WZKvx_9sM33AiWB5h2K-PqzU', N'User', CAST(N'2024-10-14T21:01:35.130' AS DateTime), CAST(N'2024-10-22T00:33:11.087' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'35e5b61d-5756-4380-93df-fe5946eb65bc', N'ngocanhbl03@gmail.com', N'53972873531f19e35bef39fdd84376b4c3ca4ec6a92b8a97b82bdb0497fc8725', N'NGUYEN NGOC ANH', N'ngocanhbl03@gmail.com', N'', N'0912717472', N'Premium', N'ewpktMMtQxe-dDtm5xVl-A:APA91bFB16oDfgN_zRULTIcy3-bdUu1x0ztzcpZ2Sp_EXtk18dnJ3zeDa2OWnE-cjv1ISAeWb15BpYqXlXq9I1Le89_sPppD0gPZSRENAhbFV0V_HgN-n58', N'User', CAST(N'2024-11-03T15:30:59.330' AS DateTime), CAST(N'2024-11-03T15:30:59.330' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', N'khanhmai11800@gmail.com', N'2ef6be5f9aecf48118384574b174e493642e2040f488f5caa4797ef433c8a971', N'Khánh Mai', N'khanhmai11800@gmail.com', N'Khác', N'0343096645', N'Premium', N'fOcpvGLDSruXax_tRzEIDQ:APA91bHD-QBEpkPzsU9GQpS7nzHVyB1AG8Y7v3mt-0ViBpcsnxHOo712vOG9roO7laTHQ-kRg2CBeVzSt0x1A5D1yZ0vjuemKQ8zuk6lIIGrKE3GQNSVj-0', N'User', CAST(N'2024-10-31T22:12:07.080' AS DateTime), CAST(N'2024-10-31T22:12:07.080' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'3bdce20c-2d03-43f1-85c1-eac95a417ee3', N'admin@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'123', N'admin@gmail.com', NULL, N'0903764344', NULL, NULL, N'Admin', NULL, NULL)
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'3c0ca692-4d6b-48b6-a0c0-26fb89407431', N'haochinguyen132@gmail.com', N'dc2ca91ecf940342989c3f1ce776706cd97ee9caca070038e85ddf5e077202af', N'Nguyen Chi Hao', N'haochinguyen132@gmail.com', N'', N'0764136075', N'Premium', NULL, N'User', CAST(N'2024-10-31T10:18:42.783' AS DateTime), CAST(N'2024-10-31T10:18:42.783' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'3eb1b76c-e1e7-49c3-a864-f393098319ad', N'duongduchoang@gmail.com', N'794fde143691e3a2c62ae85474d65875b78d7406e60ee189ec8ac1615f32b0ec', N'Duong Duc Hoang', N'duongduchoang@gmail.com', N'', N'0973563124', N'Free', NULL, N'User', CAST(N'2024-11-02T23:17:28.650' AS DateTime), CAST(N'2024-11-02T23:17:28.650' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'409670f0-1b60-4ca2-b6c8-f9d9f52eee7e', N'hoangminhvuduc@gmail.com', N'3ba29a854fde115f958bea79ddba344777d8caed6af1ba58dd5e64bd08afce1a', N'Hoang Minh Vu Duc', N'hoangminhvuduc@gmail.com', N'', N'0919694562', N'Free', NULL, N'User', CAST(N'2024-11-04T15:22:40.690' AS DateTime), CAST(N'2024-11-04T15:22:40.690' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'43eea021-3e39-4ac4-8973-173bfca8b22a', N'ngocnguyen@gmail.com', N'a47dd546afc37a2d33c09537672e75ed460ee557eb3c110778b2940f97928f22', N'To Nguyen Ngoc Nguyen', N'ngocnguyen@gmail.com', N'', N'0908965874', N'Free', NULL, N'User', CAST(N'2024-11-04T15:26:07.187' AS DateTime), CAST(N'2024-11-04T15:26:07.187' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'45c53f27-8b00-4096-84ee-063f2362cf78', N'lehoangvy@gmail.com', N'284ef0d42fa0accd454f5302da3122477f7a05806050e84fd3eb5ce92feee5c7', N'Le Hoang Vy', N'lehoangvy@gmail.com', N'', N'0946321307', N'Free', NULL, N'User', CAST(N'2024-11-02T23:26:44.890' AS DateTime), CAST(N'2024-11-02T23:26:44.890' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'48d480b0-ca54-4476-b158-59bac9e8ec2d', N'nqt8977@gmail.com', N'e1f75b77ec82e2836b942ed25768abd557991455ac13f24a072d806e07df59e7', N'Nguyễn Quốc Thắng', N'nqt8977@gmail.com', N'', N'0983427576', N'Premium', N'ekgUhFN2SPyo7uQKOOUrOF:APA91bFM2tapofDKe59rEQ-mT4AKxzY9DdJQlR632eISDQRBHXWh1WxGdQaY9VWRDFyTMr78ApNCYQmAHjUjbWcn1XzhzirTVkfYn5P4T0n1Iit3MenjRa8', N'User', CAST(N'2024-10-31T22:03:34.380' AS DateTime), CAST(N'2024-10-31T22:03:34.380' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'49bc6950-cbb9-44fc-a589-575e07299083', N'khaitranvu1011@gmail.com', N'8cfe02b8149bae60ebb93e68a644d166b242400a1280dcbfef5db6039fe3fe64', N'Vu Khai', N'khaitranvu1011@gmail.com', N'Nam', N'0916973969', N'Premium', N'e_7SSgWHT8i6Tvv_qzcar7:APA91bF7TMuaZ4Ku3GCpcUfgKshR3RgTE9iVv02IpQ2gixEMZJn_aYfguUfhwNU-2XBqGBVbA4I4ly7NRSGeeYE0HUEyOr0flAR-1h88AcjGaSeJ-61nRAM', N'User', CAST(N'2024-10-29T10:26:10.860' AS DateTime), CAST(N'2024-10-29T10:26:10.860' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'4be6d90e-cf8c-43b3-87e2-ed313a015294', N'hoangduongminhduc@gmail.com', N'1fb11799d37b661bc5a16bfbdae0b886c80d9ce12189a32a97d41db4579667f1', N'Hoang Duong Minh Duc', N'hoangduongminhduc@gmail.com', N'', N'0973567824', N'Free', NULL, N'User', CAST(N'2024-11-02T23:18:02.237' AS DateTime), CAST(N'2024-11-02T23:18:02.237' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'55580139-98ce-489e-a6aa-8400fa86a46b', N'ngothienan98@gmail.com', N'bbe5155421279dd3d7716da409becf107fdaa3ee958f8a91a260654afb0e6ae9', N'Ngo Thien An', N'ngothienan98@gmail.com', N'', N'09078693298', N'Free', NULL, N'User', CAST(N'2024-11-04T15:24:53.350' AS DateTime), CAST(N'2024-11-04T15:24:53.350' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'583645ae-54b6-43fd-8a81-b73ec30947e8', N'minhnqdse2003@gmail.com', N'8c2d7e1bdc93c1a54e446a5c76f7a52dc7e433dd2c09702374a76a1d2ad10d68', N'Minh Nguyen', N'minhnqdse2003@gmail.com', N'', N'0913188033', N'Premium', N'dq1Mk90vRROAVK1XFu8NIe:APA91bGjcscInCtkKqMVh1ysN3i53LTumdVC1vozYKN9gUPxthSLSK2WgAF33ywdD9jFJ31GpFzbStcQyHEtqedtejyy_hqMPf_G6_kgBsIZqd6p77FkoeQ', N'User', CAST(N'2024-10-29T13:05:18.463' AS DateTime), CAST(N'2024-10-29T13:05:18.463' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'5ba85337-3ab0-4564-ab0d-20206ccefc38', N'phuctoine@gmail.com', N'7513673d9e3a5c5eb8f44e3357c3fcd323f8714f98d1ef36ca3f1e54b7eee707', N'Nguyen Minh Duc', N'phuctoine@gmail.com', N'', N'0973547394', N'Free', NULL, N'User', CAST(N'2024-11-02T23:22:11.457' AS DateTime), CAST(N'2024-11-02T23:22:11.457' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'637278ef-a976-464f-b21f-f61c817baaea', N'pcc1327@gmail.com', N'95f766c134375b381e715ea78b6664d61a1a28864dfc2a9321c66ba054a9be49', N'Phong Phạm', N'pcc1327@gmail.com', N'', N'0945493370', N'Free', N'c6BxUFqPTnea9z_8djE9N8:APA91bFvn_cMWpaaqWao2dth_xcSWsfkIlcIniUTvJ58gPrlKqqlpvb5KX15X4R6INHx5CLizoKoj2iQZBxfnGmaVe4rpZTppP97gxvAzf42bnRHEfSO1s7-JNbv58YL0Qe417WBc5mK', N'User', CAST(N'2024-10-28T20:05:22.007' AS DateTime), CAST(N'2024-10-28T20:05:22.007' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'6718bd8e-a579-48f3-bc8f-93072acb16fd', N'hieuvuu@gmail.com', N'3fb60bec9958d202b06d3d77a994dab7ac3c7565cb587baa44b9f3a0e97ca612', N'Vu Tran Manh Hieu', N'hieuvuu@gmail.com', N'', N'0946336487', N'Free', NULL, N'User', CAST(N'2024-11-03T19:57:24.127' AS DateTime), CAST(N'2024-11-03T19:57:24.127' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', N'tiennvse171676@fpt.edu.vn', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Nguyen Vi Tien', N'tiennvse171676@fpt.edu.vn', N'Nam', N'0902768349', N'Premium', NULL, N'User', CAST(N'2024-11-07T20:20:09.000' AS DateTime), CAST(N'2024-11-07T20:20:09.000' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'6c64e390-46b3-41d9-a12b-afa5b5ce7146', N'admin@gamil.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'123', N'admin@gamil.com', NULL, N'0903764348', NULL, NULL, N'Admin', NULL, NULL)
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'717b9b48-99ac-4f89-a5fb-39c9a47ec029', N'luutrieuvinehh@gmail.com', N'14ab33cb933e1fd7264e6b6cd40148fa5329a4d6602089252753153b4b1623b0', N'Luu Trieu Vi', N'luutrieuvinehh@gmail.com', N'', N'0973567394', N'Free', NULL, N'User', CAST(N'2024-11-02T23:18:47.770' AS DateTime), CAST(N'2024-11-02T23:18:47.770' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'7320ebff-4178-4dd9-9b23-31a175b2f27e', N'trongpham930@gmail.com', N'c2ad53ccc31e52bf0ed40e8daad7a1cf2234f0890579ad79c9bfe6086f97899a', N'Phạm Tuyết Nhi', N'trongpham930@gmail.com', N'Khác', N'0334663122', N'Premium', N'eqR-_H29S56mjarKCOyijS:APA91bFV1EfPfF-1woR3DGUBw0GXKr8b4jVjkSaeSWg2M36-riBek4wsQ8B3d62gVIdiMGij_i1jG1g4klYPKOTMDEMmwUMQTqVF4MMxJGFXq66_qh4cx9k', N'User', CAST(N'2024-11-04T11:01:22.710' AS DateTime), CAST(N'2024-11-04T11:01:22.710' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'75101d07-653c-49f4-96c7-daba267655e4', N'trieuvyneh@gmail.com', N'f241fb81d94970f8973731712f004acb832d0940d6f057ab200529e67ffbd2d2', N'Nguyen Trieu Vy', N'trieuvyneh@gmail.com', N'', N'0973113433', N'Free', NULL, N'User', CAST(N'2024-11-02T23:34:56.737' AS DateTime), CAST(N'2024-11-02T23:34:56.737' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'7634460e-814a-44a0-a142-3195f004fde0', N'phuhoangcute@gmail.com', N'e2da017c478066e495b5d4733ec2822bff86e97df472f3085e2cb5c5170bfce7', N'Hoang Duong Minh Phu', N'phuhoangcute@gmail.com', N'', N'0978783691', N'Premium', NULL, N'User', CAST(N'2024-11-04T21:13:52.773' AS DateTime), CAST(N'2024-11-04T21:13:52.773' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'764f3f62-c21f-41a2-b05a-6ee34d31a99f', N'trandanh2k@gmail.com', N'66842ed206efe5e7c4592cea05809d66521e850ed133d75b3c652a61fb2b1181', N'Tran Danh', N'trandanh2k@gmail.com', N'', N'0985563124', N'Free', NULL, N'User', CAST(N'2024-11-02T23:16:46.557' AS DateTime), CAST(N'2024-11-02T23:16:46.557' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'767dfb90-b9ec-4f91-9217-c49f6de43d08', N'vothanhdanhh1012@gmail.com', N'35ee44d9f225e3c58a20cd420a6e4f8181815a908d7e0e5c8b9d96d762126386', N'Vo Thanh Danh', N'vothanhdanhh1012@gmail.com', N'', N'0953547394', N'Free', NULL, N'User', CAST(N'2024-11-02T23:24:03.727' AS DateTime), CAST(N'2024-11-02T23:24:03.727' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'vitienneh@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Nguyen Viet Hoang', N'vitienneh@gmail.com', N'', N'0903767777', N'Premium', NULL, N'User', CAST(N'2024-10-29T10:22:29.333' AS DateTime), CAST(N'2024-10-29T10:22:29.333' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'7d9997c6-3840-4ab5-b969-ff663cac3ae3', N'nguyenminhtu@gmail.com', N'adba9b200449034fe73b37cd865a6f32026e2e6a2f34c1547da58dedd0a7912b', N'Nguyen Minh Tu', N'nguyenminhtu@gmail.com', N'', N'09019966332', N'Free', NULL, N'User', CAST(N'2024-11-03T20:02:14.897' AS DateTime), CAST(N'2024-11-03T20:02:14.897' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'814e50d5-efca-4f1e-9d31-0cb99dd92a6d', N'khangquocle@gmail.com', N'721408988e73783e504e6544a5dc8301bef53929de7a9f69912dd7ffc1acc903', N'Le Quoc Khang', N'khangquocle@gmail.com', N'', N'0901134889', N'Free', NULL, N'User', CAST(N'2024-11-03T20:04:51.020' AS DateTime), CAST(N'2024-11-03T20:04:51.020' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'833f0ba7-6c0f-4b8a-8939-b133f23b9dad', N'levannguyen@gnail.com', N'f2598e7079a9dc3f7846208505dedf1e99818a88b2138949524cbfc89a34ebd5', N'Le Van Nguyen', N'levannguyen@gnail.com', N'', N'0978563214', N'Free', NULL, N'User', CAST(N'2024-11-02T09:54:35.320' AS DateTime), CAST(N'2024-11-02T09:54:35.320' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'841e443d-49b6-4951-bb4f-7c13ddbd47f2', N'phunguyenngoc2003@gmail.com', N'1976745cfefdfc294bcb26d487d50ad90bfe2d6cc23d85e455029caaf191fbc2', N'Ph', N'phunguyenngoc2003@gmail.com', N'', N'0963569126', N'Premium', N'cuZZGP3hSyyIY1qoZl2WKy:APA91bHEYJZT6KUh0J0D2YthVTS30N2MtDAGYWg1gQH8em1YA2TRvHDaPWCtkdQ5vNa3w18WG_Bl9kNhVQHtzihrg4itqdyN3uIf48TpMHxErpjlGgEWeM4', N'User', CAST(N'2024-10-29T10:50:58.020' AS DateTime), CAST(N'2024-10-29T10:50:58.020' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'84f4ff38-856e-473d-9136-d530b8fb571e', N'trungdonghoangggg@gmail.com', N'8dc13d65d651078e00b56ec523ac0c34a0e6cb1fb43478381f3bbcbe2efebc69', N'Hoang Trung Dong', N'trungdonghoangggg@gmail.com', N'', N'09052222384', N'Free', NULL, N'User', CAST(N'2024-11-04T21:24:30.407' AS DateTime), CAST(N'2024-11-04T21:24:30.407' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'86da20bb-23eb-41db-bf3b-1676ae5e4e79', N'nguyenxuanduc280703@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Nguyen Xuan Duc', N'nguyenxuanduc280703@gmail.com', NULL, N'05062141887', N'Premium', N'eqrTf4jWSGOENmkLcIfZ4T:APA91bHOaCEadoj7rNfIqrGkTzDD4QsxnQnaqvtpjvZNIKx5_YRwNLfT1xqt8irMOk48sf-VN93wU8B4Aay1lE5OUIlnxN1WZKvx_9sM33AiWB5h2K-PqzU', N'User', NULL, NULL)
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'8c0a697f-4657-466a-831f-4b810e118d80', N'hoangbaominh1608@gmail.com', N'ab850ed7bcd727dab0e8369495ed01093ae819472428dd50dc8e067f4c9df262', N'Hoang Phi Hung ', N'hoangbaominh1608@gmail.com', N'', N'0978563158', N'Free', NULL, N'User', CAST(N'2024-11-02T09:58:03.917' AS DateTime), CAST(N'2024-11-02T09:58:03.917' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'8dbcc99b-e073-4fad-a23f-ed3839fe3965', N'lamhoangkhai1601@gmail.com', N'39423e4368592f8c8ce0857d59017c5eb5695385ace381c47ca10ede1b768ced', N'Lam Hoang Khai', N'lamhoangkhai1601@gmail.com', N'', N'09031686839', N'Free', NULL, N'User', CAST(N'2024-11-04T15:24:07.140' AS DateTime), CAST(N'2024-11-04T15:24:07.140' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'918dc1d9-186d-40e7-8726-93646f31ad2f', N'hoanglexuantu1012@gmail.com', N'6bb0b593fe7b72b090497a7eb3ed53ab1e7d7c4f2df38b54ec954807696c0d22', N'Hoang Le Xuan Tu', N'hoanglexuantu1012@gmail.com', N'', N'0978494358', N'Free', NULL, N'User', CAST(N'2024-11-02T09:59:38.780' AS DateTime), CAST(N'2024-11-02T09:59:38.780' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'92eedb60-26a9-4297-a657-93fb95a81342', N'luan115269@gmail.com', N'fc6d7e92209978cca849005f4c64bcbeb62c2fb66685333fbe6d33058b6d05d1', N'Phạm Thành Luân', N'luan115269@gmail.com', N'', N'0971761403', N'Premium', N'e05UewbrR4ip34Uh5RQS75:APA91bHsHqgZx2q9IfsvWLhtWw5kVI7iekTfdrh9uLuEsJEPIEg8vCH-0achxt2niIa2P6s4b-ZzPPaa0jlRP69larkD7pxqOj8sXFB5vgu2yar0g7uqTSc', N'User', CAST(N'2024-10-31T22:12:00.153' AS DateTime), CAST(N'2024-10-31T22:12:00.153' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'a842c297-b7a2-4027-9f42-a9027c5cac56', N'tienvaducladoibanthan@gmail.com', N'd49c1c40117c45d826903fb141906f76405d67390cabebb0d55be3f72bc5ce18', N'Nguyễn Phương Nam', N'tienvaducladoibanthan@gmail.com', N'', N'0911991199', N'Premium', N'eEmN1RB4Rn-kq92Z1JY_gO:APA91bGb0cQX3fgVsxSOKJ0BXCgStv7iChXugWsD3MUODVrOqIpG-2p9VZauVIx-vEToNHHhSDyvxWBo5NE0kkZXQ1Ci3uooIJqAmDJGjPJyiAJKXjdCRmM', N'User', CAST(N'2024-10-30T20:58:40.210' AS DateTime), CAST(N'2024-10-30T20:58:40.210' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'b125833c-7b07-46ab-9fbd-38b39e78c4fc', N'linhnguyenk333@gmail.com', N'4dbfd5f06cff8b9c5e34b65de4e2f7eb166189566cf4127dd3c13dce3a6a334c', N'Nguyen Minh Linh', N'linhnguyenk333@gmail.com', N'', N'0916963345', N'Free', NULL, N'User', CAST(N'2024-11-03T20:03:02.103' AS DateTime), CAST(N'2024-11-03T20:03:02.103' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'b1c6f65b-bbf0-4300-aef6-1f17e9e3eea7', N'cuaxinh2kg@gmail.com', N'442ec452cdab34c071cd6116ef8859b96f85fd78bae5ef5cd148650ab17e60b7', N'Vu Nhu Y', N'cuaxinh2kg@gmail.com', N'', N'09047896662', N'Free', NULL, N'User', CAST(N'2024-11-04T21:24:59.643' AS DateTime), CAST(N'2024-11-04T21:24:59.643' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'b380c110-cd2e-4734-bbbe-09343f97a4f1', N'KhaiHoang@gmail.com', N'f48b8e3523a0a52985d77569b484fc6ae8450f32edf48b476056fc233098ad95', N'Tran Hoang Khai', N'KhaiHoang@gmail.com', N'', N'0977196658', N'Free', NULL, N'User', CAST(N'2024-11-02T10:01:37.543' AS DateTime), CAST(N'2024-11-02T10:01:37.543' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'bae4f2b2-1c0e-441f-927b-5fa89db8d713', N'minhcangthang2k3@gmail.com', N'30fbb2e2c94589576836aa68f9e65665439ed91c512840cbf8ce8f2ef8037fd9', N'Nguyen Van Minh', N'minhcangthang2k3@gmail.com', N'', N'0955696277', N'Free', NULL, N'User', CAST(N'2024-11-03T19:59:19.517' AS DateTime), CAST(N'2024-11-03T19:59:19.517' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'bbd10b9b-284b-487d-84ec-2c3fb1f83727', N'tanphuccneh@gmail.com', N'33959432fa7c41050766f311fb25e61e01fad63596862c4388a08b765a4c40bf', N'Le Hoang Tan Phuc', N'tanphuccneh@gmail.com', N'', N'0955523508', N'Free', NULL, N'User', CAST(N'2024-11-03T20:00:07.870' AS DateTime), CAST(N'2024-11-03T20:00:07.870' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'bd8a9e64-1929-4873-bd63-7740e9b24fbe', N'claudius.peachy@gmail.com', N'51881832b8d879193b53c5ea6158569db64a5cbe3810bbd13ef9ad3b17cecbf3', N'Trương Gia Bảo', N'claudius.peachy@gmail.com', N'', N'0382575703', N'Free', N'dNA8wOQ9TLGUx1ps8sazwX:APA91bHzaUFnarfBjsaAd0sk1qLO95YSiMEAr_GOdtVCde4f7sML-4EANLpmmPJ0L5O6HG1AJZFwmhRbNIFgsaC6mpyzQcvjMiAMfNKCr_CJmmdFdnIUrcQ', N'User', CAST(N'2024-10-31T22:00:34.230' AS DateTime), CAST(N'2024-10-31T22:00:34.230' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'c465f3af-7928-4ab3-8101-a7bb03b0d6ad', N'nguyenxuanhao0809@gnail.com', N'dbc56a78a9a624199de66a79ddb6cb78f9d34fb81a539838c8d36d884c59acae', N'Nguyen Xuan Hao', N'nguyenxuanhao0809@gnail.com', N'', N'0968248523', N'Free', NULL, N'User', CAST(N'2024-11-02T09:55:45.070' AS DateTime), CAST(N'2024-11-02T09:55:45.070' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'c7710656-e341-425b-8c85-57a2c85c6ad7', N'minh06122002@gmail.com', N'8a751510d05d70e73c0a58e89328215af4954a631ca100d01e97ddb51e9b7856', N'Nguyen Nhat Minh', N'minh06122002@gmail.com', N'', N'0898064874', N'Premium', N'dVJed4rOSXe7bgi8g0u6po:APA91bHDGHqLroF4uvvnLJ3lnjFlf5uEPnv53M4JFxTb00vS3mLTkKUbrjBzvEuB_ICoKzDSrVS2NkgYkyUcgQES-DHgjN6NfHWgEvry59Hl6RNzS4Ztihk', N'User', CAST(N'2024-10-29T10:59:24.737' AS DateTime), CAST(N'2024-10-29T10:59:24.737' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'phuclocsieucapdangyeu@gmail.com', N'8829f391e4ac5b5e119f160f791aaa1da909a3db57097c393f0fd4246ccc9fb0', N'Nguyen Thuy Phuc Loc', N'phuclocsieucapdangyeu@gmail.com', N'', N'0823120703', N'Premium', N'cLYPnlrXRnqQGmHMAnPwf_:APA91bHvA3vOf7BGSBd8pFXq6yznd3qcTTZ7HpbF50fs61wPHILAc8RdZw25B61iizupSeWfkiC0PfM-k6G6uCQFU_zP7ocZrWr7ZCRieDvMtWCx7CWcih8', N'User', CAST(N'2024-11-04T23:23:41.640' AS DateTime), CAST(N'2024-11-04T23:23:41.640' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'c861f854-922c-4513-98b2-7d7b69918d8c', N'tungduong1608@gmail.com', N'b32766cd2c0581775cbd0f62d83ee8e9de22036ce366e3cc5fa0183d2b935b9e', N'Duong Bao Tung', N'tungduong1608@gmail.com', N'', N'0978410158', N'Free', NULL, N'User', CAST(N'2024-11-02T09:58:38.057' AS DateTime), CAST(N'2024-11-02T09:58:38.057' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'cd304b04-0da4-4cad-8b2f-92fb6a846ddc', N'minhzuizerrg@gmail.com', N'cc062346ed6cd8855bb64210d7ed60a33793e517069b7960c732a64b3167d6d9', N'Nguyen Hoang Nhat Minh', N'minhzuizerrg@gmail.com', N'', N'0902036589', N'Free', NULL, N'User', CAST(N'2024-11-04T21:27:20.843' AS DateTime), CAST(N'2024-11-04T21:27:20.843' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'd0773dc7-85de-4aeb-8183-0f9f4f1d6056', N'longpham3k@gmail.com', N'384e4d1bc6e4ba61d36ef27487fb595324fb1b9f7942a9abf13f6cbae8c7a7ec', N'Pham Thanh Long', N'longpham3k@gmail.com', N'', N'0912233442', N'Free', NULL, N'User', CAST(N'2024-11-03T20:04:18.760' AS DateTime), CAST(N'2024-11-03T20:04:18.760' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'd57cb9b5-fa9e-42c0-8901-55f82c9ea8ff', N'nhuy17082003@gmail.com', N'991967e79d9a589454e9af093ce22932dd0f20ce44bceeea6b045f3842f6950e', N'Nguyen Nhu Y', N'nhuy17082003@gmail.com', N'', N'09220389747', N'Free', NULL, N'User', CAST(N'2024-11-03T19:57:58.273' AS DateTime), CAST(N'2024-11-03T19:57:58.273' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'd58a260a-1378-4e46-9045-b1c80caa1216', N'minhcangthang@gmail.com', N'0daf5fa1488899733dbe133a8c4310c1cc029b666b6016ec0d9bc0277f5be306', N'Nguyen Nhat Minh', N'minhcangthang@gmail.com', N'', N'09013666297', N'Free', NULL, N'User', CAST(N'2024-11-04T21:26:29.523' AS DateTime), CAST(N'2024-11-04T21:26:29.523' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'd6f7ccdc-f9eb-4518-9eac-93f881b34c75', N'hungcutephomai@gmail.com', N'a58a231b7aef0a308b100a60fbd613efb1a4b899b10e76b4cea78eadf277f762', N'Le Viet Hung', N'hungcutephomai@gmail.com', N'', N'0978496658', N'Free', NULL, N'User', CAST(N'2024-11-02T10:01:08.977' AS DateTime), CAST(N'2024-11-02T10:01:08.977' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'd89c05f5-89ac-472c-9bfd-ba7603b01119', N'hoangthekiet1412@gmail.com', N'63640264849a87c90356129d99ea165e37aa5fabc1fea46906df1a7ca50db492', N'Kiet123', N'hoangthekiet1412@gmail.com', N'', N'0919491039', N'Premium', N'cFQ9WJVfRUWEHkIGkpogkw:APA91bEMX4znqycASNe2GAbyWnkTEPa-dTistqhGGlxKYwgQ3wNAKPT0XXIi0Z7MNUdbhxnWLwUGyQmqWzrNCZ28rHL9U2noIQ9ABVYUByxsF-Pa8x6f7eQ', N'User', CAST(N'2024-10-29T08:24:28.477' AS DateTime), CAST(N'2024-10-29T08:24:28.477' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'd9134203-e96f-4ba3-a7c9-bfdc5acb0b75', N'qinnou2503@gmail.com', N'9a3826bb4f4f773f04d68497050e6922367a81a498a5a854fc5b2dea09a499a8', N'Wyh Hin', N'qinnou2503@gmail.com', N'', N'0355854277', N'Free', N'c3xYkakdTOGvMh5CU7WmRi:APA91bHWN_kmMB92jQUmUpq0sfdWkcND9OmOsQHDxdaEWNlyXTVunsuPdggjkjfHpvL3miJ9ju6XANithTQCMInz4CF6ezeFUnhAO75xv09AvasZ7MjmuYw', N'User', CAST(N'2024-10-31T22:07:14.713' AS DateTime), CAST(N'2024-10-31T22:07:14.713' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'dd99a10f-9f9c-4f47-bb8d-dca7b2deb170', N'minhtuankuan@gmail.com', N'3ea3bc97af05bf9a8685e1a2d24235a7add9910f6668af87d59467873040cd6e', N'Dang Minh Tuan', N'minhtuankuan@gmail.com', N'', N'0907985631', N'Free', NULL, N'User', CAST(N'2024-11-02T23:25:20.937' AS DateTime), CAST(N'2024-11-02T23:25:20.937' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', N'duongbao2k3@gmail.com', N'0e2764034d01453aa51e65e7bd83497ba239fb9e9f98a02f35d6402c2fd215b8', N'duong bao', N'duongbao2k3@gmail.com', N'Nam', N'0909113114', N'Free', N'ei8rjCLxSfmmbJq9RlzItE:APA91bFrJSS7yk8NjXSYMxEPjpsjzisz3U7iaFfsl4PU7DxRycXSxI0Oacxv_BfKYh0ZzXdpeTXEm-4ahpxGxMrK8WHPfbiJX5JhfB4zFRsRJk8Uz6fene_SicMGt18Js9n3LkPl544E', N'User', CAST(N'2024-10-27T20:46:44.223' AS DateTime), CAST(N'2024-10-27T20:46:44.223' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'tunguyen100312@gmail.com', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'Nguyễn Tú', N'tunguyen100312@gmail.com', N'', N'0792628243', N'Premium', N'fB3wGPczRk61yJoWBxbVsL:APA91bGllRvVJHlmTCv9R9Zxwt1mXVKYnmQLekf52QCx7-_FYo_ylADCIvpw7lEuiBWI7wl9W4Ixohp1gEVTtrGOUoTCEk-aCsH7nJ4RgN5Ij_-znAfmX74', N'User', CAST(N'2024-10-29T09:44:06.017' AS DateTime), CAST(N'2024-10-29T09:44:06.017' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'e560f4e8-3530-4f22-938b-981acce04871', N'khangnqbse171663@fpt.edu.vn', N'c5152d4ad1ad63730d5630494001a0651f89d423a4e830193957d3136c20510d', N'Nguyen Quang Bao Khang', N'khangnqbse171663@fpt.edu.vn', N'', N'0834351375', N'Premium', N'dTVhPrHoRU6_R2F6FzTiY6:APA91bEZlK4Ky_9TyGYLzTUS_w4wG95cHyN-9limQrsoTiJBKcoonbCv40eL6j1QRpPHVL0F0zazHvRayPPhV1zFtcQ_41tpzKXKGi5s2yIROoCeDToYgLU', N'User', CAST(N'2024-11-04T22:28:13.977' AS DateTime), CAST(N'2024-11-04T22:28:13.977' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'ef594831-0a94-4abb-a779-ea87fff195af', N'phanlethanhvy@gmail.com', N'9d2e8f42aca6ad2ae6e6b49972ba815ae9058166654dd846c34771d54d0167d0', N'Phan Le thanh Vy', N'phanlethanhvy@gmail.com', N'', N'090169966384', N'Free', NULL, N'User', CAST(N'2024-11-03T20:01:27.890' AS DateTime), CAST(N'2024-11-03T20:01:27.890' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'f1c810c2-f656-45f2-8f59-7db2507b919e', N'maiquynhanh@gmail.com', N'1832e9e75dfa5a07d0354641f8f308957aaeb4694ebcb9d30f04955cce80a80d', N'Mai Quynh Anh', N'maiquynhanh@gmail.com', N'', N'0907593842', N'Free', NULL, N'User', CAST(N'2024-11-03T20:00:41.673' AS DateTime), CAST(N'2024-11-03T20:00:41.673' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'f30f9e29-8f16-43fe-95c7-2037315caa3d', N'giahuyheo2003@gmail.com', N'e99b48003b936a4e36cc6affa5a5382736409127319757f20e0f9b7a7a93cbf4', N'Nguyen Gia Huy', N'giahuyheo2003@gmail.com', N'', N'09144449868', N'Free', NULL, N'User', CAST(N'2024-11-02T23:24:36.673' AS DateTime), CAST(N'2024-11-02T23:24:36.673' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'fac983a3-6ba6-4e25-a1c4-c4d7f65db16e', N'nguyenquangngocthienn@gnail.com', N'93055f218e1c43ee0be8f12cb29b12f0f97c8c7fffd86015dc8c7f851a05cffa', N'Nguyen Quang Ngoc Thien', N'nguyenquangngocthienn@gnail.com', N'', N'0968748523', N'Free', NULL, N'User', CAST(N'2024-11-02T09:55:15.817' AS DateTime), CAST(N'2024-11-02T09:55:15.817' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password], [fullname], [email], [gender], [phone_number], [subscription_plan], [Devicetoken], [role], [created_at], [updated_at]) VALUES (N'fc7dea98-1d50-484c-9f42-8b91db72d74d', N'tranminhhieu@gmail.com', N'441c8034363b84da335652c9b5c9cb007fd43377b7f8f82ad89e7b0cf4409b51', N'Hieu thu ba', N'tranminhhieu@gmail.com', N'', N'09074422638', N'Free', NULL, N'User', CAST(N'2024-11-04T15:26:59.517' AS DateTime), CAST(N'2024-11-04T15:26:59.517' AS DateTime))
GO
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'0995b662-cbdf-47f8-a369-25ba8c403577', N'c7c412f0-c764-4f83-94c7-da01ba14879a', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-11-04' AS Date), CAST(N'2025-11-04' AS Date), N'ACTIVE', CAST(N'2024-11-04T23:27:00.277' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'0c06a6ae-59f7-4734-953e-72b1a5f0585a', N'000c98cf-7091-4837-ab00-04222f37e6ac', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-03' AS Date), CAST(N'2024-12-03' AS Date), N'ACTIVE', CAST(N'2024-11-03T15:43:39.703' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'31bab53d-2ed0-4b5b-8b6b-e7360fbe39ed', N'48d480b0-ca54-4476-b158-59bac9e8ec2d', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-01' AS Date), CAST(N'2024-12-01' AS Date), N'ACTIVE', CAST(N'2024-11-01T08:31:48.563' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'439dfa39-725a-4b81-b994-11e2f9f9dcbf', N'03882d8d-ab53-4240-847d-6d6a4553806b', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-10-30' AS Date), CAST(N'2024-11-29' AS Date), N'ACTIVE', CAST(N'2024-10-30T21:06:30.513' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'47be0f80-9816-443f-bde6-b94de5fb643d', N'c7710656-e341-425b-8c85-57a2c85c6ad7', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-10-29' AS Date), CAST(N'2025-10-29' AS Date), N'ACTIVE', CAST(N'2024-10-29T11:02:07.910' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'55b336cf-373a-46cf-8a1f-72c7b4bd94f3', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-10-29' AS Date), CAST(N'2025-10-29' AS Date), N'ACTIVE', CAST(N'2024-10-29T09:47:04.767' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'59b233f0-a6ee-44d6-b1d2-ac4e149bed27', N'3c0ca692-4d6b-48b6-a0c0-26fb89407431', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-10-31' AS Date), CAST(N'2025-10-31' AS Date), N'ACTIVE', CAST(N'2024-10-31T10:46:45.387' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'6fd60636-b071-4d8d-97e6-388be054a3ab', N'd89c05f5-89ac-472c-9bfd-ba7603b01119', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-10-29' AS Date), CAST(N'2024-11-28' AS Date), N'ACTIVE', CAST(N'2024-10-29T08:46:57.323' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'7af13bf6-6dbd-4a8e-aad6-15cce3d93969', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', N'3F61E73B-455E-4951-A623-3B749408DF2E', CAST(N'2024-10-29' AS Date), CAST(N'2025-04-27' AS Date), N'ACTIVE', CAST(N'2024-10-29T10:25:22.353' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'802bdb34-68e0-4e70-bbd9-8b241ca9e7c4', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'28EF80BD-199D-45CB-9267-D56E8B2C2C7F', CAST(N'2024-10-22' AS Date), CAST(N'2024-11-22' AS Date), N'ACTIVE', CAST(N'2024-10-22T08:58:16.343' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'8abb7c9c-42e2-444b-9f02-dd9a8fc2b5a6', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-07' AS Date), CAST(N'2024-12-07' AS Date), N'ACTIVE', CAST(N'2024-11-07T20:23:10.033' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'94d72f29-478e-4ede-a8ad-9c49c545f26b', N'49bc6950-cbb9-44fc-a589-575e07299083', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-10-29' AS Date), CAST(N'2025-10-29' AS Date), N'ACTIVE', CAST(N'2024-10-29T10:30:27.420' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'9efdfd85-3ef6-4909-befa-322a67bb5b01', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'28EF80BD-199D-45CB-9267-D56E8B2C2C7F', CAST(N'2024-10-22' AS Date), CAST(N'2024-11-22' AS Date), N'ACTIVE', CAST(N'2024-10-22T08:22:13.203' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'a79cd63f-1bd1-4b6f-8dcc-dbda49f17dfb', N'35e5b61d-5756-4380-93df-fe5946eb65bc', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-03' AS Date), CAST(N'2024-12-03' AS Date), N'ACTIVE', CAST(N'2024-11-03T15:35:03.813' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'aaf5814a-c61a-4fe3-8e28-7b888f03d89e', N'841e443d-49b6-4951-bb4f-7c13ddbd47f2', N'3F61E73B-455E-4951-A623-3B749408DF2E', CAST(N'2024-10-29' AS Date), CAST(N'2025-04-27' AS Date), N'ACTIVE', CAST(N'2024-10-29T10:55:13.390' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'b12da6b0-b34b-4c2e-aae8-552ce054948d', N'0c084d9e-98af-4168-8d48-12527f18d999', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-04' AS Date), CAST(N'2024-12-04' AS Date), N'ACTIVE', CAST(N'2024-11-04T21:07:21.213' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'cf8f444f-0b99-48ce-9e48-e6f14b592b84', N'e560f4e8-3530-4f22-938b-981acce04871', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-04' AS Date), CAST(N'2024-12-04' AS Date), N'ACTIVE', CAST(N'2024-11-04T22:53:25.977' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'd4361d3e-44ed-4d12-a888-434416566584', N'92eedb60-26a9-4297-a657-93fb95a81342', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-10-31' AS Date), CAST(N'2024-11-30' AS Date), N'ACTIVE', CAST(N'2024-10-31T22:16:28.817' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'd74ee9fb-b070-41d7-a5de-ae8b2817167e', N'a842c297-b7a2-4027-9f42-a9027c5cac56', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-10-30' AS Date), CAST(N'2025-10-30' AS Date), N'ACTIVE', CAST(N'2024-10-30T21:24:27.130' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'dd8919c6-934b-4718-b162-831efe905404', N'583645ae-54b6-43fd-8a81-b73ec30947e8', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-10-29' AS Date), CAST(N'2024-11-28' AS Date), N'ACTIVE', CAST(N'2024-10-29T13:10:09.850' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'e0c86c5b-98c8-4808-a445-64198856d710', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-10-27' AS Date), CAST(N'2024-11-08' AS Date), N'ACTIVE', CAST(N'2024-10-27T20:17:46.013' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'e362a631-08f5-4390-9243-c72576a7b162', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'28EF80BD-199D-45CB-9267-D56E8B2C2C7F', CAST(N'2024-10-25' AS Date), CAST(N'2024-11-25' AS Date), N'ACTIVE', CAST(N'2024-10-25T00:45:03.403' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'ef9024f5-10e1-4e8a-bb5d-199925a06719', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', N'28EF80BD-199D-45CB-9267-D56E8B2C2C7F', CAST(N'2024-10-25' AS Date), CAST(N'2024-11-25' AS Date), N'ACTIVE', CAST(N'2024-10-25T00:45:03.140' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'f4bc2d59-979a-4169-9893-1c0e977198c1', N'7634460e-814a-44a0-a142-3195f004fde0', N'EF788DD7-9524-49A4-88B8-24078ED9E9B3', CAST(N'2024-11-04' AS Date), CAST(N'2024-12-04' AS Date), N'ACTIVE', CAST(N'2024-11-04T21:16:41.167' AS DateTime))
INSERT [dbo].[UserSub] ([UserSubID], [user_id], [subscription_id], [start_date], [end_date], [status], [created_at]) VALUES (N'fc6be90b-eba2-41f8-9512-510255f988ce', N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', N'12FADEEE-8F69-4AC8-89B8-01B30E5F8923', CAST(N'2024-10-31' AS Date), CAST(N'2025-10-31' AS Date), N'ACTIVE', CAST(N'2024-10-31T22:17:15.413' AS DateTime))
GO
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'0043f245-fa15-4126-acce-de8275bcd4d4', N'0c084d9e-98af-4168-8d48-12527f18d999', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'0386f4b1-2ac1-4c94-80a1-3de63a798c5f', N'767dfb90-b9ec-4f91-9217-c49f6de43d08', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'04673b42-bf69-43e8-a549-d5b21f19fa5f', N'bbd10b9b-284b-487d-84ec-2c3fb1f83727', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'054f1a88-facb-44a0-a8b4-694f300e2682', N'dd99a10f-9f9c-4f47-bb8d-dca7b2deb170', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'0AD57B82-6953-49E3-9B1D-ECCCA497FDEC', N'e55e7239-2881-45fc-aa20-4bf8b5f52b22', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'0f76c51a-772d-422d-8dc6-e1def54a0667', N'c465f3af-7928-4ab3-8101-a7bb03b0d6ad', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'0f9087a5-9e8f-4ba0-b5fa-16efa224db18', N'16a0f432-54db-4451-a74c-e234ce67a897', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'1899004b-80aa-43d8-a2ec-b6013ace5ca7', N'49bc6950-cbb9-44fc-a589-575e07299083', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'1bccd10e-a33e-43d4-9cf7-062c15d2cb8f', N'c7710656-e341-425b-8c85-57a2c85c6ad7', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'1dbc33a8-0c2e-4363-a334-079e44cd3bac', N'814e50d5-efca-4f1e-9d31-0cb99dd92a6d', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'24A2B8A8-FB28-46F7-9436-4FC420E40432', N'3bdce20c-2d03-43f1-85c1-eac95a417ee3', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'269bdb7b-45b4-47a7-83e6-64f7f69ac9f2', N'48d480b0-ca54-4476-b158-59bac9e8ec2d', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'27A4A251-1021-49AE-A746-0C54F4A1F63D', N'637278ef-a976-464f-b21f-f61c817baaea', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'2D08DAC8-D1FE-4F0A-B4A3-C3C1879128EF', N'000c98cf-7091-4837-ab00-04222f37e6ac', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'2fd32ca9-5521-4d50-aecc-dd9ae986b12a', N'bae4f2b2-1c0e-441f-927b-5fa89db8d713', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'34bea123-633b-4edc-854d-e1b8f6baab33', N'f30f9e29-8f16-43fe-95c7-2037315caa3d', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'34e53ede-9463-4c5a-9103-c57c989c96ac', N'2434cc29-76a4-4bd7-acfd-f502ce0c551c', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'3581b570-83c8-456d-86ac-28872b3d6862', N'45c53f27-8b00-4096-84ee-063f2362cf78', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'364e8779-9e1c-466a-9828-803ebf4ccd3d', N'fc7dea98-1d50-484c-9f42-8b91db72d74d', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'385849f7-5a52-4d3c-99cc-08d7828a538b', N'6a52d3c9-007a-4c14-9713-c34b7e7bcef6', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'3ea18416-3127-4ffa-b780-b9677e1f69eb', N'8c0a697f-4657-466a-831f-4b810e118d80', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'3fe6ff82-8534-4191-9498-e04bd4ba015f', N'78f87b20-610f-4dc5-bd39-a42129b3edd5', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'4bc50795-ea86-4893-888e-d186645ed02c', N'3b7d9b21-3fa5-4302-a8bf-57334c6b1331', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'4bc7a6b7-2e6f-4cc6-9234-8cbfcab4352b', N'84f4ff38-856e-473d-9136-d530b8fb571e', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'4cd160a9-a1f9-41ee-9b80-a3f0fded2647', N'0f663bf3-a9f9-47fb-b76f-3b2c790e9d7a', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'4d1565ac-751a-4d7c-ae98-dba31ff80ca4', N'92eedb60-26a9-4297-a657-93fb95a81342', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'53cf271c-afe7-4b26-b6b8-1096cf2408db', N'a842c297-b7a2-4027-9f42-a9027c5cac56', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'54ead4a9-7f53-490d-a087-222916947940', N'3c0ca692-4d6b-48b6-a0c0-26fb89407431', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'57b218c1-6eaa-4d27-972b-6fe3fbef5ac3', N'55580139-98ce-489e-a6aa-8400fa86a46b', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'5e604412-ceac-4d63-aa1a-924f42a0c090', N'35e5b61d-5756-4380-93df-fe5946eb65bc', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'5ecbcc31-b738-462a-8121-572daa3b7fa4', N'841e443d-49b6-4951-bb4f-7c13ddbd47f2', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'5f2f21bc-cbf7-494c-bbce-e5af9df0ba55', N'833f0ba7-6c0f-4b8a-8939-b133f23b9dad', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'6062f81e-7fe6-45c9-912f-03ac165363ef', N'd9134203-e96f-4ba3-a7c9-bfdc5acb0b75', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'6a350218-b46e-4fd5-b28f-fcc9d7295142', N'c861f854-922c-4513-98b2-7d7b69918d8c', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'6bdc72f4-adda-4946-81c1-ccb296e45506', N'583645ae-54b6-43fd-8a81-b73ec30947e8', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'6C618796-AFA1-446A-9B79-41162A91765F', N'35a8f69a-db8a-4eea-aaca-2dcd046e2843', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'6ca4ff42-7735-4fdf-9bcc-873e8dffe340', N'764f3f62-c21f-41a2-b05a-6ee34d31a99f', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'73526c4d-c0f5-48c1-8465-ec165f13d933', N'6718bd8e-a579-48f3-bc8f-93072acb16fd', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'7ca9ad35-657c-4fd6-8593-57120af97185', N'7634460e-814a-44a0-a142-3195f004fde0', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'8058eecf-5a71-4e0d-8430-5ce95b9737f6', N'2eed2c9d-3514-41f7-9801-5bfa4f42045e', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'82c56222-0696-4f4a-82cd-214dca713f6a', N'75101d07-653c-49f4-96c7-daba267655e4', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'8312441d-fa78-446e-8ba0-96b078074154', N'cd304b04-0da4-4cad-8b2f-92fb6a846ddc', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'860f4027-82dc-4bad-a82d-e726836d621a', N'7d9997c6-3840-4ab5-b969-ff663cac3ae3', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'8b4ff527-71c8-4327-81f7-5c0ca8d58a35', N'b125833c-7b07-46ab-9fbd-38b39e78c4fc', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'8BCE0AFB-B604-4502-8F14-C1CB4E557973', N'd89c05f5-89ac-472c-9bfd-ba7603b01119', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'8E76CAA9-15D7-4CC4-B0CB-17E6EEB1E96F', N'e3b8bbe4-84c3-4202-8f38-55f90efbae71', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'8f3cdd85-e3c8-4db7-a7cf-8b17ab0b911e', N'4be6d90e-cf8c-43b3-87e2-ed313a015294', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'92854014-dc25-414f-8ea5-374a482cb82f', N'918dc1d9-186d-40e7-8726-93646f31ad2f', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'92f5bd16-8401-42aa-bd19-64bbe32d84c1', N'bd8a9e64-1929-4873-bd63-7740e9b24fbe', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'99febcd1-da63-440f-ac55-3368f2448031', N'5ba85337-3ab0-4564-ab0d-20206ccefc38', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'aa104cc8-10f4-4d49-ab39-21bcbd57e1a0', N'ef594831-0a94-4abb-a779-ea87fff195af', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ac74c3e6-3613-4fab-a45f-e746e86d7a7b', N'717b9b48-99ac-4f89-a5fb-39c9a47ec029', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ae758d0d-19c4-4d0a-a993-5c42aac328be', N'b380c110-cd2e-4734-bbbe-09343f97a4f1', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'afbe61a6-9028-4111-8fd4-a88250e36cd6', N'3eb1b76c-e1e7-49c3-a864-f393098319ad', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'c5867047-54fa-4f99-8b98-05a42b9bdc7a', N'b1c6f65b-bbf0-4300-aef6-1f17e9e3eea7', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'c80da94a-6d3a-4e5e-b7de-4043ca5af34e', N'f1c810c2-f656-45f2-8f59-7db2507b919e', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'c8691443-f564-4960-943a-b55c719106aa', N'c7c412f0-c764-4f83-94c7-da01ba14879a', 2)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ce7fa3b2-2f7a-464e-9932-047702d87eff', N'8dbcc99b-e073-4fad-a23f-ed3839fe3965', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ce8912b6-6908-42d8-ad0c-971fb9c779fa', N'409670f0-1b60-4ca2-b6c8-f9d9f52eee7e', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'd0aeac5b-9a44-4b95-8b59-b48eeb9165bd', N'd58a260a-1378-4e46-9045-b1c80caa1216', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'd6b78b76-13bc-4ff5-80be-044347d1dc1f', N'7320ebff-4178-4dd9-9b23-31a175b2f27e', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'd6be675a-065a-4601-a359-a249522a42b0', N'43eea021-3e39-4ac4-8973-173bfca8b22a', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'e736d338-31c8-406e-9334-3ad25c918633', N'e560f4e8-3530-4f22-938b-981acce04871', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ec311bde-bd1b-48a6-8a2f-db0b00399098', N'd0773dc7-85de-4aeb-8183-0f9f4f1d6056', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ec482256-811b-4351-a6dc-87f9a823346c', N'fac983a3-6ba6-4e25-a1c4-c4d7f65db16e', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'f849ccd7-8b54-4680-8b3d-3cff58a47ef5', N'd57cb9b5-fa9e-42c0-8901-55f82c9ea8ff', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'F8B22A5E-72F5-45CF-A53D-F0B08A654914', N'03882d8d-ab53-4240-847d-6d6a4553806b', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'fd2dcb3f-8e6b-4360-af89-57e74da54b1b', N'd6f7ccdc-f9eb-4518-9eac-93f881b34c75', 1)
INSERT [dbo].[UserTheme] ([userTheme_id], [user_id], [theme_id]) VALUES (N'ff6f84b8-f4bb-407c-904e-6baa35bddb98', N'31690749-7ede-4241-88ef-0a32f3b9cf22', 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Payments__85C600AE2743961B]    Script Date: 11/12/2024 6:15:59 PM ******/
ALTER TABLE [dbo].[Payments] ADD UNIQUE NONCLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572B4F4852D]    Script Date: 11/12/2024 6:15:59 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT (newid()) FOR [event_id]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (newid()) FOR [notification_id]
GO
ALTER TABLE [dbo].[OTPCode] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT (newid()) FOR [token_id]
GO
ALTER TABLE [dbo].[Seeds] ADD  DEFAULT (newid()) FOR [seed_id]
GO
ALTER TABLE [dbo].[Subscriptions] ADD  DEFAULT (newid()) FOR [subscription_id]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT (newid()) FOR [task_id]
GO
ALTER TABLE [dbo].[UserCustomizations] ADD  DEFAULT (newid()) FOR [userCustomization_id]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (newid()) FOR [user_id]
GO
ALTER TABLE [dbo].[UserSub] ADD  DEFAULT (newid()) FOR [UserSubID]
GO
ALTER TABLE [dbo].[UserTheme] ADD  DEFAULT (newid()) FOR [userTheme_id]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([event_id])
REFERENCES [dbo].[Events] ([event_id])
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([task_id])
REFERENCES [dbo].[Tasks] ([task_id])
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[OTPCode]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([subscription_id])
REFERENCES [dbo].[Subscriptions] ([subscription_id])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Seeds]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[UserCustomizations]  WITH CHECK ADD FOREIGN KEY([customization_id])
REFERENCES [dbo].[Customizations] ([customization_id])
GO
ALTER TABLE [dbo].[UserCustomizations]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[UserSub]  WITH CHECK ADD FOREIGN KEY([subscription_id])
REFERENCES [dbo].[Subscriptions] ([subscription_id])
GO
ALTER TABLE [dbo].[UserSub]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[UserTheme]  WITH CHECK ADD FOREIGN KEY([theme_id])
REFERENCES [dbo].[Theme] ([theme_id])
GO
ALTER TABLE [dbo].[UserTheme]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
USE [master]
GO
ALTER DATABASE [Opal_Exe] SET  READ_WRITE 
GO
