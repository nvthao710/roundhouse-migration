USE master
IF NOT EXISTS(SELECT * FROM sys.databases WHERE [name] = 'RoundHouse')
BEGIN
	CREATE DATABASE RoundHouse
	-- signal success
	SELECT 1
END