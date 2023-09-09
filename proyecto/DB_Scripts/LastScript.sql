USE [PROYECTO_CLASE]
GO
CREATE TABLE languages (
    id INT PRIMARY KEY,
    checksum  VARCHAR(36),
    created_at BIGINT,
    locale NVARCHAR(10),
    name NVARCHAR(100),
    native_name NVARCHAR(100),
    updated_at BIGINT
);
GO
CREATE TABLE multiplayer_modes (
    id	INT PRIMARY KEY,
    campaigncoop VARCHAR(5),	
    checksum	VARCHAR(36),
    dropin	 VARCHAR(5),	
    game	INT,
    lancoop	VARCHAR(5),	
    offlinecoop	VARCHAR(5),	
    offlinecoopmax	INT,
    offlinemax	INT,
    onlinecoop	VARCHAR(5),	
    onlinecoopmax	INT,
    onlinemax	INT,
    platform	INT,
    splitscreen	VARCHAR(5),	
    splitscreenonline VARCHAR(5),	
);
GO
CREATE TABLE platform_families (
    id	INT PRIMARY KEY,
    checksum	VARCHAR(36),
    name	VARCHAR(max),
    slug VARCHAR(max),
);
GO
CREATE TABLE platform_version_companies (
    id	INT PRIMARY KEY,
    checksum	VARCHAR(36),
    comment	VARCHAR(max),
    company	INT,
    developer	VARCHAR(5),	
    manufacturer VARCHAR(5),	
);
GO
CREATE TABLE platform_version_release_dates (
    id	INT PRIMARY KEY,
    category	INT,
    checksum	VARCHAR(36),
    created_at	BIGINT,
    date	BIGINT,
    human	VARCHAR(max),
    m	INT,
    platform_version	INT,
    region	INT,
    updated_at	BIGINT,
    y INT,
);
GO
CREATE TABLE platform_versions (
   id		INT PRIMARY KEY,
   checksum	VARCHAR(36),
   companies	VARCHAR(max), --arr
   connectivity	VARCHAR(max),
   cpu	VARCHAR(max),
   graphics	VARCHAR(max),
   main_manufacturer	INT,
   media		VARCHAR(max),
   memory		VARCHAR(max),
   name		VARCHAR(max),
   online	VARCHAR(max),
   os	VARCHAR(max),
   output	VARCHAR(max),
   platform_logo	INT,
   platform_version_release_dates	VARCHAR(max), --arr
   resolutions	VARCHAR(max),
   slug	VARCHAR(max),
   sound	VARCHAR(max),
   storage	VARCHAR(max),
   summary	VARCHAR(max),
   url VARCHAR(max),
);
GO
CREATE TABLE platform_websites (
    id	INT PRIMARY KEY,
    category	INT,
    checksum	VARCHAR(36),
    trusted	    VARCHAR(5),	
    url VARCHAR(max),
);
GO
CREATE TABLE platforms (
    id	INT PRIMARY KEY,
    abbreviation	VARCHAR(max),
    alternative_name	VARCHAR(max),
    category	INT,
    checksum	VARCHAR(36),
    created_at	BIGINT,
    generation	INT,
    name	VARCHAR(max),
    platform_family	INT,
    platform_logo	INT,
    slug	VARCHAR(max),
    summary	VARCHAR(max),
    updated_at	BIGINT,
    url	VARCHAR(max),
    versions	 VARCHAR(max), --arr
    websites  VARCHAR(max), --arr
);
GO
CREATE TABLE player_perspectives (
    id	INT PRIMARY KEY,
    checksum	VARCHAR(36),
    created_at	BIGINT,
    name	VARCHAR(max),
    slug	VARCHAR(max),
    updated_at	BIGINT,
    url VARCHAR(max),
);
GO
CREATE TABLE regions (
    id	INT PRIMARY KEY,
    category	VARCHAR(max),
    checksum	VARCHAR(36),
    created_at	BIGINT,
    identifier	VARCHAR(max),
    name	VARCHAR(max),
    updated_at BIGINT,
);
GO
CREATE TABLE release_date_statuses (
    id	INT PRIMARY KEY,
    checksum	VARCHAR(36),
    created_at	BIGINT,
    description		VARCHAR(max),
    name		VARCHAR(max),
    updated_at BIGINT,
);
GO
CREATE TABLE release_dates (
    id	INT PRIMARY KEY,
    category	INT,
    checksum	VARCHAR(36),
    created_at	BIGINT,
    date	BIGINT,
    game	INT,
    human	VARCHAR(max),
    m	INT,
    platform	INT,
    region	INT,
    status	INT,
    updated_at	BIGINT,
    y INT,
);
GO
CREATE TABLE search (
    id	INT PRIMARY KEY,
    alternative_name	VARCHAR(max),
    character	INT,
    checksum	VARCHAR(36),
    collection	INT,
    company	INT,
    description	VARCHAR(max),
    game	INT,
    name	VARCHAR(max),
    platform	INT,
    published_at	BIGINT,
    test_dummy	INT,
    theme INT,
);
GO
CREATE TABLE themes (
    id	INT PRIMARY KEY,
    checksum	VARCHAR(36),
    created_at	BIGINT,
    name	VARCHAR(max),
    slug	VARCHAR(max),
    updated_at	BIGINT,
    url     VARCHAR(max),
);
GO
CREATE TABLE websites (
    id	INT PRIMARY KEY,
    category	INT,
    checksum	VARCHAR(36),
    game	INT,
    trusted	VARCHAR(5),	
    url VARCHAR(max),
);