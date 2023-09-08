USE [PROYECTO_CLASE]
GO
CREATE TABLE game_localizations(
    id INT PRIMARY KEY , 
	checksum VARCHAR(36),
    created_at BIGINT,
	name VARCHAR(200),
    updated_at BIGINT
);
