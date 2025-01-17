USE [PROYECTO_CLASE]
GO
/****** Object:  Table [dbo].[age_rating_content_descriptions]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[age_ratings]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[alternative_names]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[artworks]    Script Date: 7/09/2023 23:03:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[artworks](
	[id] [int] NOT NULL,
	[alpha_channel] [varchar](5) NULL,
	[animated] [varchar](5) NULL,
	[checksum] [varchar](36) NULL,
	[game] [int] NULL,
	[height] [int] NULL,
	[image_id] [varchar](max) NULL,
	[url] [varchar](max) NULL,
	[width] [int] NULL,
 CONSTRAINT [PK_artworks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[character_mug_shots]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[characters]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[collections]    Script Date: 7/09/2023 23:03:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[collections](
	[id] [int] NULL,
	[checksum] [varchar](36) NULL,
	[created_at] [int] NULL,
	[games] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[slug] [varchar](max) NULL,
	[updated_at] [int] NULL,
	[url] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[companies]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[company_websites]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[external_games]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[franchises]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[game_engines]    Script Date: 7/09/2023 23:03:41 ******/
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
/****** Object:  Table [dbo].[games]    Script Date: 7/09/2023 23:03:41 ******/
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
