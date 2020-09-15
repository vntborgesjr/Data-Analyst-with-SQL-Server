-- Introduction to SQL Server - Create Tables and Insete Data
-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

-- CRUDE operations
-- CREATE
  -- Databases, Tables or views
-- READ
  -- Example: SELECT
-- UPDATE
  -- Amend existing database records
-- DELETE


-- Create a table named 'results' with 3 VARCHAR columns called track, artist, and album, with
-- lengths 200, 120, and 160, repectively.
-- Create the table
CREATE TABLE results (
  -- Create track column
  track VARCHAR(200),
  -- Create artist column
  artist VARCHAR(120),
  -- Create album column
  album VARCHAR(160)
  );

-- Create one integer column called track_length_mins
CREATE TABLE results (
  -- Create track column
  track VARCHAR(200),
  -- Create artist column
  artist VARCHAR(120),
  -- Create album column
  album VARCHAR(160),
  track_length_mins INT
  );

-- SELECT all the columns from your new table. No rows will be returned, but you can confirm
-- that the table has been created.
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);

-- Select all columns from the table
SELECT 
  track, 
  artist, 
  album, 
  track_length_mins 
FROM 
  results;
  
-- INSERT, UPDATE, and DELETE
-- Create a table called tracks with 2 VARCHAR columns named track and album, and one integer
-- column named trck_length_mins. Then, select all columns from the new table using the * 
-- notation
-- Create the table
CREATE TABLE tracks(
  -- Create track aolumn
  track VARCHAR(200),
  -- Create album column
  album VARCHAR(160),
  -- Create track_length_mins column
  track_length_mins INT
  );

-- Insert track 'Basket Case', from the album 'Dookie', with a track length of 3, into the 
-- appropriate columns.
INSERT INTO tracks
-- Specify the destination columns
(track, album, track_length_mins)
-- Insert the appropriate values for track, album and track length
VALUES
  ('Basket Case', 'Dookie', 3);
  
-- Select all columns from the new table

-- Select all columns from the new table
SELECT
  *
FROM
  tracks;

-- 