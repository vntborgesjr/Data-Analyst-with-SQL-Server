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

-- Select the title column from the album table where the album_id is 213.
-- Select the album
SELECT 
  title 
FROM 
  album 
WHERE 
  album_id = 213;
-- UPDATE the title to 'Pure Cult: The Best of The Cult'
UPDATE 
  album
-- SET the new title    
SET 
  title = 'Pure Cult: The Best Of The Cult'
WHERE album_id = 213;
-- Run the query again
SELECT 
  title 
FROM 
  album;

-- DELETE
-- DELETE the record from album where album_id is 1
-- Run the query
SELECT 
  * 
FROM 
  album 
  -- DELETE the record
DELETE FROM 
album 
WHERE 
  album_id = 1 
  -- Run the query again
SELECT 
  * 
FROM 
  album;
  
-- Variables and temporary tables
-- DECLARE and SET a variable
-- DECLARE the variable @region, which has adata tyoe of VARCHAR and length of 10
DECLARE @region varchar(10)

-- SER the variable value to 'RFC'
SET @region = 'RFC'

SELECT description,
       nerc_region,
       demand_loss_mw,
       affected_customers
FROM grid
WHERE nerc_region = @region;

-- Declare a new variable called @start of type DATE
DECLARE @start DATE

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- Declare a new variable called @stop of type DATE
DECLARE @stop DATE

-- SET @stop to '2014-07-02'
SET @stop = '2014-07-02'

-- Declare a new variable called @affected of type INT
DECLARE @affected INT

-- Set @affected to 5000
SET @affected = 5000 

-- Retrieve all rows where event_data is BETWEEN @start and @stop and affected_customers
-- is greater than or equal to @affected
SELECT 
  description,
  nerc_region,
  demand_loss_mw,
  affected_customers
FROM 
  grid
-- Specify the date range of the event_date and the value for @affected
WHERE event_date BETWEEN @start AND @stop
AND affected_customers >= @affected;

-- Create a Temporary Table woth the longest track from every album
-- Create a temporary table called maxtracks. Make sure the table name starts with #.
-- Join album to artist using atisti_id, and track to album using album_id.
-- Run the final SELECT statement to retrieve all the columns from your new table.
SELECT  album.title AS album_title,
  artist.name as artist,
  MAX(track.milliseconds / (1000 * 60) % 60 ) AS max_track_length_mins
-- Name the temp table #maxtracks
INTO #maxtracks
FROM album
-- Join album to artist using artist_id
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Join track to album using album_id
INNER JOIN track ON album.album_id = track.album_id
GROUP BY artist.artist_id, album.title, artist.name,album.album_id
-- Run the final SELECT query to retrieve the results from the temporary table
SELECT album_title, artist, max_track_length_mins
FROM  #maxtracks
ORDER BY max_track_length_mins DESC, artist;