-- Introduction to SQL Server - SELECTion Box
-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

-- Simple Selections

-- SELECT the country column FROM the eurovision table
SELECT 
country
FROM 
eurovision;

-- Select the points column
SELECT
points
FROM
eurovision;

-- Limit the number of rows returned
SELECT
TOP (50) points
FROM
eurovision;

-- Return unique countries and use an alias
SELECT
DISTINCT country AS unique_country
FROM eurovision;

-- More selections
-- Select coutry and event_year from eurovision
SELECT 
country,
event_year
FROM
eurovision;

-- Return all rows and columns
SELECT *
FROM
eurovision;

-- Return all columns, restricting the percent of rows returned
SELECT
TOP (50) PERCENT *
FROM
eurovision;

-- Ordering and filtering
-- Select the first 5 rows of the columns description and event_data from the grid dataset
SELECT 
TOP (5) description,
event_date
FROM
grid
-- Order results by the event_date column
ORDER BY
event_date;

-- Select the top 20 rows from descriptio, nerc_region and event_date
SELECT
TOP (20) description,
nerc_region,
event_date
FROM 
grid
-- Order by nerc_region, affected_customers and event_date
-- event_date should be in descending order
ORDER BY
nerc_region, 
affected_customers,
event_date DESC;

-- Select the description and event_year columns
SELECT 
description,
event_year
FROM
grid
-- Filter the results to return rows where description is vandalism
WHERE description = 'Vandalism'

-- Select nerc_region and demand_loss_mw
SELECT
nerc_region,
demand_loss_mw
FROM
grid
-- Retrive rows where affected_customers is >= 500000
WHERE affected_customers >= 500000;

-- Select description and affected_customers
SELECT
description,
affected_customers
FROM
grid
-- Retrieve rows where the event_date was 22nd December, 2013
WHERE
event_date = '2013-12-22';

-- Select description, affected_customers and event_date
SELECT
description,
affected_customers,
event_date
FROM
grid
-- The affected_customers column should be >=50000 and <= 150000
WHERE
affected_customers BETWEEN 50000 AND 150000
-- Order event_date in descending order 
ORDER BY 
event_date DESC;

-- Retrieve all columns
SELECT
*
FROM
grid
-- Return only rows where demand_loss_mw is missing or unknown
WHERE
demand_loss_mw IS NULL;

-- Retrieve all columns
SELECT 
  * 
FROM 
  grid 
  -- Return rows where demand_loss_mw is not missing or unknown   
WHERE 
  demand_loss_mw IS NOT NULL;
  
-- WHERE, OR and AND
-- Exploring classic rock songs
-- Retrieve the song, artist, and release_year coumns from the songlist table
SELECT
song,
artist,
release_year
FROM
songlist;
-- Ensure there are no missing or unknown values in the release_year column
WHERE 
release_year IS NOT NULL;
-- Arrange the results by the artist and release_year columns
ORDER BY
  artist,
  release_year;

-- Exploring classic rock songs - AND/OR
-- Extend the WHERE claus so that the results are those with a release_year greater
-- than or equal to 1980 and less than or equal to 1990
SELECT
song,
artist, 
release_year
FROM 
songlist
WHERE
-- Retrieve records greater than and including 1980
release_year >= 1980
-- Also retrieve records up to and including 1990
OR release_year <= 1990
ORDER BY
artist,
release_year;

-- Select all artists beginning with B who released tracks in 1986, but alse retrieve any
-- records where the release_year is greater than 1990
SELECT
artist,
release_year,
songFROM
songlist
-- Choose the correct artist and specify the release year
WHERE
(artist LIKE 'B%'
AND release_year = 1986)
OR release_year > 1990
-- Order the results
ORDER BY 
release_year,
artist,
song;
