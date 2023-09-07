use games_api;


-- Game localizations table
CREATE TABLE game_localizations(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
    created_at BIGINT,
	name VARCHAR(200),
    updated_at BIGINT
);

-- Game modes table
CREATE TABLE game_modes(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
    created_at BIGINT,
	name VARCHAR(200),
	slug VARCHAR(500),
    updated_at BIGINT,
	url VARCHAR(500)
);

-- Game versions table
CREATE TABLE game_versions(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
    created_at BIGINT,
    updated_at BIGINT,
	url VARCHAR(500)
);


-- Game version feature table
CREATE TABLE game_version_features(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	category INT,
	description VARCHAR(500),
	position INT,
	tittle VARCHAR(500)
);


-- Game version feature value table
CREATE TABLE game_version_feature_values(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	included_feature INT,
	note VARCHAR(500)
);

-- Game videos table
CREATE TABLE game_videos(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	name VARCHAR(500),
	video_id VARCHAR(500)
);


-- Genre table
CREATE TABLE genres(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	name VARCHAR(500),
	slug VARCHAR(500),
	updated_at BIGINT,
	url VARCHAR(500)
);


-- Involved company table
CREATE TABLE involved_companies(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	developer VARCHAR(50),
	porting VARCHAR(50),
	publisher VARCHAR(50),
	supporting VARCHAR(50),
	updated_at BIGINT
);


-- Keyword  table
CREATE TABLE keywords(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	name VARCHAR(500),
	slug VARCHAR(500),
	updated_at BIGINT,
	url VARCHAR(500)
);



-- Language support  table
CREATE TABLE language_supports(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	updated_at BIGINT
);


-- Language support  type table
CREATE TABLE language_support_types(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	name VARCHAR(500),
	updated_at BIGINT
);
