-- Introduction to SQL Server - Joining tables
-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

-- INNER JOIN
-- Perform an INNER JOIN between album and track using the album_id column
SELECT
  track_id,
  name AS track_name,
  title AS album_title
FROM track
  -- Complete the join type and the common joining column
  INNER JOIN album on album.album_id = track.album_id;
  
-- Select the album_id and title columns from album, and name column from artist and alias it
-- as artist
SELECT
  album_id,
  title
  artist.name AS artist
  -- Enter the main source table name
FROM album
  -- Identify a common column between the album and artist tables and perform an inner join
INNER JOIN artist on artist.artist_id = album.artist_id;

-- Qualify the name column by specifying the correct table prefix in both cases
-- Complete both INNER JION clauses to join album with track, and artist with album
SELECT track_id,
-- Enter the correct table name prefix when retrieving the name column from the track table
  track.name AS track_name,
  title as album_title,
  -- Enter the correct table name prefix when retrieving the name column from the artist table
  artist.name AS artist_name
FROM track
  -- Complete the matching columns to join album with track, and artist with album
INNER JOIN album on album.album_id = track.album_id
INNER JOIN artist on artist.artist_id = album.artist_id;

-- LEFT and RIGHT JOIN
-- Complete the LEFT JOIN, returning all rows from the specified columns from 
-- invoiceline and any matches from invoice
SELECT 
  invoiceline_id,
  unit_price, 
  quantity,
  billing_state
  -- Specify the source table
FROM invoiceline
  -- Complete the join to the invoice table
LEFT JOIN invoice
ON invoiceline.invoice_id = invoice.invoice_id;

-- 
-- SELECT the fully qualified column names album_id from album and name from artist.
-- Then, join the tables so that only matching rows are returned (non-matches should be 
-- discarded)
SELECT 
  album_id,
  title,
  album.artist_id,
  -- SELECT the fully qualified name column from the artist table
  name as artist
FROM album
-- Perform a join to return only rows that match from both tables
INNER JOIN artist ON album.artist_id = artist.artist_id
WHERE album.album_id IN (213,214)

-- To complete the query, join the album table tp the track table using relevant fully
-- qualified album_id column. The album table is on the left-hand side of the join, and
-- the additional join should return all matches or NULLs.
SELECT 
  album.album_id,
  title,
  album.artist_id,
  artist.name as artist
FROM album
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Perform the correct join type to return matches or NULLS from the track table
RIGHT JOIN track ON album.album_id = track.album_id
WHERE album.album_id IN (213,214)

-- UNION & UNION ALL
-- Make the first selection from the album table. Then join the results by providing the 
-- relevant keyword and selecting from the artist table.
SELECT 
  album_id AS ID,
  title AS description,
  'Album' AS Source
  -- Complete the FROM statement
FROM album
 -- Combine the result set using the relevant keyword
UNION
SELECT 
  artist_id AS ID,
  name AS description,
  'Artist'  AS Source
  -- Complete the FROM statement
FROM artist;