use games_api;


-- Game localizations table
CREATE TABLE game_localizations(
    id INT PRIMARY KEY , 
	cover INT,
	checksum VARCHAR(36),
    created_at BIGINT,
	name VARCHAR(max),
	region INT,
    updated_at BIGINT
);

-- Game modes table
CREATE TABLE game_modes(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
    created_at BIGINT,
	name VARCHAR(max),
	slug VARCHAR(max),
    updated_at BIGINT,
	url VARCHAR(max)
);

-- Game versions table
CREATE TABLE game_versions(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	features VARCHAR(max),
	game INT,
	games VARCHAR(max),
    created_at BIGINT,
    updated_at BIGINT,
	url VARCHAR(max)
);


-- Game version feature table
CREATE TABLE game_version_features(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	category INT,
	description VARCHAR(max),
	position INT,
	tittle VARCHAR(max),
	values_ VARCHAR(max)
);


-- Game version feature value table
CREATE TABLE game_version_feature_values(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	game INT,
	included_feature INT,
	note VARCHAR(max)
);

-- Game videos table
CREATE TABLE game_videos(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	game INT,
	name VARCHAR(max),
	video_id VARCHAR(max)
);


-- Genre table
CREATE TABLE genres(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	name VARCHAR(max),
	slug VARCHAR(max),
	updated_at BIGINT,
	url VARCHAR(max)
);


-- Involved company table
CREATE TABLE involved_companies(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	company INT,
	created_at BIGINT,
	developer VARCHAR(max),
	game INT,
	porting VARCHAR(max),
	publisher VARCHAR(max),
	supporting VARCHAR(max),
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
	game INT,
	language INT,
	language_support_type INT,
	created_at BIGINT,
	updated_at BIGINT
);


-- Language support  type table
CREATE TABLE language_support_types(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
	created_at BIGINT,
	name VARCHAR(max),
	updated_at BIGINT
);
