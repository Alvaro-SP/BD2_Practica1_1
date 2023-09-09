USE [master]
GO
/****** Object:  Database [PROYECTO_CLASE]    Script Date: 9/09/2023 08:06:01 ******/
CREATE DATABASE [PROYECTO_CLASE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PROYECTO_CLASE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PROYECTO_CLASE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PROYECTO_CLASE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PROYECTO_CLASE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PROYECTO_CLASE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PROYECTO_CLASE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ARITHABORT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PROYECTO_CLASE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PROYECTO_CLASE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PROYECTO_CLASE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PROYECTO_CLASE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET RECOVERY FULL 
GO
ALTER DATABASE [PROYECTO_CLASE] SET  MULTI_USER 
GO
ALTER DATABASE [PROYECTO_CLASE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PROYECTO_CLASE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PROYECTO_CLASE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PROYECTO_CLASE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PROYECTO_CLASE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PROYECTO_CLASE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PROYECTO_CLASE', N'ON'
GO
ALTER DATABASE [PROYECTO_CLASE] SET QUERY_STORE = ON
GO
ALTER DATABASE [PROYECTO_CLASE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PROYECTO_CLASE]
GO
/****** Object:  Table [dbo].[age_rating_content_descriptions]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[age_rating_content_descriptions](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK_age_rating_content_descriptions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[age_ratings]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[age_ratings](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[content_descriptions] [varchar](max) NULL,
	[rating] [varchar](max) NULL,
	[rating_cover_url] [varchar](max) NULL,
	[synopsis] [varchar](max) NULL,
 CONSTRAINT [PK_age_ratings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alternative_names]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alternative_names](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[comment] [varchar](max) NULL,
	[game] [int] NULL,
	[name] [varchar](max) NULL,
 CONSTRAINT [PK_alternative_names] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[character_mug_shots]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[character_mug_shots](
	[id] [int] NOT NULL,
	[alpha_channel] [varchar](5) NULL,
	[animated] [varchar](5) NULL,
	[checksum] [varchar](36) NULL,
	[height] [int] NULL,
	[image_id] [varchar](max) NULL,
	[width] [int] NULL,
 CONSTRAINT [PK_character_mug_shots] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[characters]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[characters](
	[id] [int] NOT NULL,
	[akas] [varchar](max) NULL,
	[checksum] [varchar](36) NULL,
	[country_name] [varchar](max) NULL,
	[created_at] [int] NULL,
	[description] [varchar](max) NULL,
	[games] [varchar](max) NULL,
	[gender] [int] NULL,
	[mug_shot] [int] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[species] [int] NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_characters] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[collections]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[collections](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [int] NULL,
	[games] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_collections] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[companies]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[companies](
	[id] [int] NOT NULL,
	[change_date] [int] NULL,
	[change_date_category] [int] NULL,
	[changed_company_id] [int] NULL,
	[checksum] [varchar](36) NULL,
	[country] [int] NULL,
	[created_at] [int] NULL,
	[description] [varchar](max) NULL,
	[developed] [varchar](max) NULL,
	[logo] [int] NULL,
	[name] [varchar](max) NULL,
	[parent] [int] NULL,
	[published] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[start_date] [int] NULL,
	[start_date_category] [int] NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
	[websites] [varchar](max) NULL,
 CONSTRAINT [PK_companies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_websites]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_websites](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[trusted] [varchar](5) NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_company_websites] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[external_games]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[external_games](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[countries] [varchar](max) NULL,
	[created_at] [int] NULL,
	[game] [int] NULL,
	[media] [int] NULL,
	[name] [varchar](max) NULL,
	[platform] [int] NULL,
	[uid] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
	[year] [int] NULL,
 CONSTRAINT [PK_external_games] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[franchises]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[franchises](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [int] NULL,
	[games] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_franchises] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_engines]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_engines](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[companies] [varchar](max) NULL,
	[created_at] [int] NULL,
	[description] [varchar](max) NULL,
	[logo] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[platforms] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
 CONSTRAINT [PK_game_engines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_localizations]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_localizations](
	[id] [int] NOT NULL,
	[cover] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[region] [int] NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_modes]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_modes](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_version_feature_values]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_version_feature_values](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[included_feature] [int] NULL,
	[note] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_version_features]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_version_features](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[category] [int] NULL,
	[description] [varchar](max) NULL,
	[position] [int] NULL,
	[tittle] [varchar](max) NULL,
	[values_] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_versions]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_versions](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[features] [varchar](max) NULL,
	[game] [int] NULL,
	[games] [varchar](max) NULL,
	[created_at] [bigint] NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_videos]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_videos](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[name] [varchar](max) NULL,
	[video_id] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[games]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[games](
	[id] [int] NOT NULL,
	[age_ratings] [varchar](max) NULL,
	[aggregated_rating] [float] NULL,
	[aggregated_rating_count] [int] NULL,
	[alternative_names] [varchar](max) NULL,
	[artworks] [varchar](max) NULL,
	[bundles] [varchar](max) NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[collection] [int] NULL,
	[cover] [int] NULL,
	[created_at] [int] NULL,
	[dlcs] [varchar](max) NULL,
	[expanded_games] [varchar](max) NULL,
	[expansions] [varchar](max) NULL,
	[external_games] [varchar](max) NULL,
	[first_release_date] [int] NULL,
	[follows] [int] NULL,
	[forks] [varchar](max) NULL,
	[franchise] [int] NULL,
	[franchises] [varchar](max) NULL,
	[game_engines] [varchar](max) NULL,
	[game_localizations] [varchar](max) NULL,
	[game_modes] [varchar](max) NULL,
	[genres] [varchar](max) NULL,
	[hypes] [int] NULL,
	[involved_companies] [varchar](max) NULL,
	[keywords] [varchar](max) NULL,
	[language_supports] [varchar](max) NULL,
	[multiplayer_modes] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[parent_game] [int] NULL,
	[platforms] [varchar](max) NULL,
	[player_perspectives] [varchar](max) NULL,
	[ports] [varchar](max) NULL,
	[rating] [float] NULL,
	[rating_count] [int] NULL,
	[release_dates] [varchar](max) NULL,
	[remakes] [varchar](max) NULL,
	[remasters] [varchar](max) NULL,
	[screenshots] [varchar](max) NULL,
	[similar_games] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[standalone_expansions] [varchar](max) NULL,
	[status] [int] NULL,
	[storyline] [varchar](max) NULL,
	[summary] [varchar](max) NULL,
	[tags] [varchar](max) NULL,
	[themes] [varchar](max) NULL,
	[total_rating] [float] NULL,
	[total_rating_count] [int] NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL,
	[version_parent] [int] NULL,
	[version_title] [varchar](max) NULL,
	[videos] [varchar](max) NULL,
	[websites] [varchar](max) NULL,
 CONSTRAINT [PK_games] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[genres]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[genres](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[involved_companies]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[involved_companies](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[company] [int] NULL,
	[created_at] [bigint] NULL,
	[developer] [varchar](max) NULL,
	[game] [int] NULL,
	[porting] [varchar](max) NULL,
	[publisher] [varchar](max) NULL,
	[supporting] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[keywords]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[keywords](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](500) NULL,
	[slug] [varchar](500) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[language_support_types]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[language_support_types](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[language_supports]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[language_supports](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[language] [int] NULL,
	[language_support_type] [int] NULL,
	[created_at] [bigint] NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[languages]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[languages](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[locale] [nvarchar](10) NULL,
	[name] [nvarchar](100) NULL,
	[native_name] [nvarchar](100) NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[multiplayer_modes]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[multiplayer_modes](
	[id] [int] NOT NULL,
	[campaigncoop] [varchar](5) NULL,
	[checksum] [varchar](36) NULL,
	[dropin] [varchar](5) NULL,
	[game] [int] NULL,
	[lancoop] [varchar](5) NULL,
	[offlinecoop] [varchar](5) NULL,
	[offlinecoopmax] [int] NULL,
	[offlinemax] [int] NULL,
	[onlinecoop] [varchar](5) NULL,
	[onlinecoopmax] [int] NULL,
	[onlinemax] [int] NULL,
	[platform] [int] NULL,
	[splitscreen] [varchar](5) NULL,
	[splitscreenonline] [varchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_families]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_families](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_version_companies]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_version_companies](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[comment] [varchar](max) NULL,
	[company] [int] NULL,
	[developer] [varchar](5) NULL,
	[manufacturer] [varchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_version_release_dates]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_version_release_dates](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[date] [bigint] NULL,
	[human] [varchar](max) NULL,
	[m] [int] NULL,
	[platform_version] [int] NULL,
	[region] [int] NULL,
	[updated_at] [bigint] NULL,
	[y] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_versions]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_versions](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[companies] [varchar](max) NULL,
	[connectivity] [varchar](max) NULL,
	[cpu] [varchar](max) NULL,
	[graphics] [varchar](max) NULL,
	[main_manufacturer] [int] NULL,
	[media] [varchar](max) NULL,
	[memory] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[online] [varchar](max) NULL,
	[os] [varchar](max) NULL,
	[output] [varchar](max) NULL,
	[platform_logo] [int] NULL,
	[platform_version_release_dates] [varchar](max) NULL,
	[resolutions] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[sound] [varchar](max) NULL,
	[storage] [varchar](max) NULL,
	[summary] [varchar](max) NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platform_websites]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platform_websites](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[trusted] [varchar](5) NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platforms]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platforms](
	[id] [int] NOT NULL,
	[abbreviation] [varchar](max) NULL,
	[alternative_name] [varchar](max) NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[generation] [int] NULL,
	[name] [varchar](max) NULL,
	[platform_family] [int] NULL,
	[platform_logo] [int] NULL,
	[slug] [varchar](max) NULL,
	[summary] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
	[versions] [varchar](max) NULL,
	[websites] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[player_perspectives]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[player_perspectives](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[regions]    Script Date: 9/09/2023 08:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[regions](
	[id] [int] NOT NULL,
	[category] [varchar](max) NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[identifier] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[release_date_statuses]    Script Date: 9/09/2023 08:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release_date_statuses](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[description] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[release_dates]    Script Date: 9/09/2023 08:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release_dates](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[date] [bigint] NULL,
	[game] [int] NULL,
	[human] [varchar](max) NULL,
	[m] [int] NULL,
	[platform] [int] NULL,
	[region] [int] NULL,
	[status] [int] NULL,
	[updated_at] [bigint] NULL,
	[y] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[search]    Script Date: 9/09/2023 08:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[search](
	[id] [int] NOT NULL,
	[alternative_name] [varchar](max) NULL,
	[character] [int] NULL,
	[checksum] [varchar](36) NULL,
	[collection] [int] NULL,
	[company] [int] NULL,
	[description] [varchar](max) NULL,
	[game] [int] NULL,
	[name] [varchar](max) NULL,
	[platform] [int] NULL,
	[published_at] [bigint] NULL,
	[test_dummy] [int] NULL,
	[theme] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[themes]    Script Date: 9/09/2023 08:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[themes](
	[id] [int] NOT NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [bigint] NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [bigint] NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[websites]    Script Date: 9/09/2023 08:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[websites](
	[id] [int] NOT NULL,
	[category] [int] NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[trusted] [varchar](5) NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[alternative_names]  WITH CHECK ADD  CONSTRAINT [FK_alternative_names_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[alternative_names] CHECK CONSTRAINT [FK_alternative_names_games]
GO
ALTER TABLE [dbo].[characters]  WITH CHECK ADD  CONSTRAINT [FK_characters_character_mug_shots] FOREIGN KEY([mug_shot])
REFERENCES [dbo].[character_mug_shots] ([id])
GO
ALTER TABLE [dbo].[characters] CHECK CONSTRAINT [FK_characters_character_mug_shots]
GO
ALTER TABLE [dbo].[companies]  WITH CHECK ADD  CONSTRAINT [FK_companies_companies] FOREIGN KEY([changed_company_id])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[companies] CHECK CONSTRAINT [FK_companies_companies]
GO
ALTER TABLE [dbo].[companies]  WITH CHECK ADD  CONSTRAINT [FK_companies_companies1] FOREIGN KEY([parent])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[companies] CHECK CONSTRAINT [FK_companies_companies1]
GO
ALTER TABLE [dbo].[external_games]  WITH CHECK ADD  CONSTRAINT [FK_external_games_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[external_games] CHECK CONSTRAINT [FK_external_games_games]
GO
ALTER TABLE [dbo].[game_version_feature_values]  WITH CHECK ADD  CONSTRAINT [FK_game_version_feature_values_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[game_version_feature_values] CHECK CONSTRAINT [FK_game_version_feature_values_games]
GO
ALTER TABLE [dbo].[game_versions]  WITH CHECK ADD  CONSTRAINT [FK_game_versions_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[game_versions] CHECK CONSTRAINT [FK_game_versions_games]
GO
ALTER TABLE [dbo].[game_videos]  WITH CHECK ADD  CONSTRAINT [FK_game_videos_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[game_videos] CHECK CONSTRAINT [FK_game_videos_games]
GO
ALTER TABLE [dbo].[games]  WITH CHECK ADD  CONSTRAINT [FK_games_collections] FOREIGN KEY([collection])
REFERENCES [dbo].[collections] ([id])
GO
ALTER TABLE [dbo].[games] CHECK CONSTRAINT [FK_games_collections]
GO
ALTER TABLE [dbo].[games]  WITH CHECK ADD  CONSTRAINT [FK_games_franchises] FOREIGN KEY([franchise])
REFERENCES [dbo].[franchises] ([id])
GO
ALTER TABLE [dbo].[games] CHECK CONSTRAINT [FK_games_franchises]
GO
ALTER TABLE [dbo].[involved_companies]  WITH CHECK ADD  CONSTRAINT [FK_involved_companies_companies] FOREIGN KEY([company])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[involved_companies] CHECK CONSTRAINT [FK_involved_companies_companies]
GO
ALTER TABLE [dbo].[involved_companies]  WITH CHECK ADD  CONSTRAINT [FK_involved_companies_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[involved_companies] CHECK CONSTRAINT [FK_involved_companies_games]
GO
ALTER TABLE [dbo].[language_supports]  WITH CHECK ADD  CONSTRAINT [FK_language_supports_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[language_supports] CHECK CONSTRAINT [FK_language_supports_games]
GO
ALTER TABLE [dbo].[language_supports]  WITH CHECK ADD  CONSTRAINT [FK_language_supports_language_support_types] FOREIGN KEY([language_support_type])
REFERENCES [dbo].[language_support_types] ([id])
GO
ALTER TABLE [dbo].[language_supports] CHECK CONSTRAINT [FK_language_supports_language_support_types]
GO
ALTER TABLE [dbo].[multiplayer_modes]  WITH CHECK ADD  CONSTRAINT [FK_multiplayer_modes_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[multiplayer_modes] CHECK CONSTRAINT [FK_multiplayer_modes_games]
GO
ALTER TABLE [dbo].[multiplayer_modes]  WITH CHECK ADD  CONSTRAINT [FK_multiplayer_modes_platforms] FOREIGN KEY([platform])
REFERENCES [dbo].[platforms] ([id])
GO
ALTER TABLE [dbo].[multiplayer_modes] CHECK CONSTRAINT [FK_multiplayer_modes_platforms]
GO
ALTER TABLE [dbo].[platform_version_companies]  WITH CHECK ADD  CONSTRAINT [FK_platform_version_companies_companies] FOREIGN KEY([company])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[platform_version_companies] CHECK CONSTRAINT [FK_platform_version_companies_companies]
GO
ALTER TABLE [dbo].[platform_version_release_dates]  WITH CHECK ADD  CONSTRAINT [FK_platform_version_release_dates_platform_versions] FOREIGN KEY([platform_version])
REFERENCES [dbo].[platform_versions] ([id])
GO
ALTER TABLE [dbo].[platform_version_release_dates] CHECK CONSTRAINT [FK_platform_version_release_dates_platform_versions]
GO
ALTER TABLE [dbo].[platform_versions]  WITH CHECK ADD  CONSTRAINT [FK_platform_versions_platform_version_companies] FOREIGN KEY([main_manufacturer])
REFERENCES [dbo].[platform_version_companies] ([id])
GO
ALTER TABLE [dbo].[platform_versions] CHECK CONSTRAINT [FK_platform_versions_platform_version_companies]
GO
ALTER TABLE [dbo].[platforms]  WITH CHECK ADD  CONSTRAINT [FK_platforms_platform_families] FOREIGN KEY([platform_family])
REFERENCES [dbo].[platform_families] ([id])
GO
ALTER TABLE [dbo].[platforms] CHECK CONSTRAINT [FK_platforms_platform_families]
GO
ALTER TABLE [dbo].[release_dates]  WITH CHECK ADD  CONSTRAINT [FK_release_dates_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[release_dates] CHECK CONSTRAINT [FK_release_dates_games]
GO
ALTER TABLE [dbo].[release_dates]  WITH CHECK ADD  CONSTRAINT [FK_release_dates_platforms] FOREIGN KEY([platform])
REFERENCES [dbo].[platforms] ([id])
GO
ALTER TABLE [dbo].[release_dates] CHECK CONSTRAINT [FK_release_dates_platforms]
GO
ALTER TABLE [dbo].[release_dates]  WITH CHECK ADD  CONSTRAINT [FK_release_dates_release_date_statuses] FOREIGN KEY([status])
REFERENCES [dbo].[release_date_statuses] ([id])
GO
ALTER TABLE [dbo].[release_dates] CHECK CONSTRAINT [FK_release_dates_release_date_statuses]
GO
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK_search_collections] FOREIGN KEY([collection])
REFERENCES [dbo].[collections] ([id])
GO
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK_search_collections]
GO
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK_search_companies] FOREIGN KEY([company])
REFERENCES [dbo].[companies] ([id])
GO
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK_search_companies]
GO
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK_search_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK_search_games]
GO
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK_search_platforms] FOREIGN KEY([platform])
REFERENCES [dbo].[platforms] ([id])
GO
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK_search_platforms]
GO
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK_search_themes] FOREIGN KEY([theme])
REFERENCES [dbo].[themes] ([id])
GO
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK_search_themes]
GO
ALTER TABLE [dbo].[websites]  WITH CHECK ADD  CONSTRAINT [FK_websites_games] FOREIGN KEY([game])
REFERENCES [dbo].[games] ([id])
GO
ALTER TABLE [dbo].[websites] CHECK CONSTRAINT [FK_websites_games]
GO
USE [master]
GO
ALTER DATABASE [PROYECTO_CLASE] SET  READ_WRITE 
GO
