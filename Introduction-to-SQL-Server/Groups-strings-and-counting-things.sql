-- Introduction to SQL Server - Groups, strings, and counting things
-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

-- Aggregating Data
-- Summing
-- Sum the demand_loss_mw_column
SELECT
SUM(demand_loss_mw) MRO_demand_loss
FROM
grid
WHERE
-- demand_loss_mw should not contain NULL values
demand_loss_mw IS NOT NULL
-- and nerc_region should be 'MRO';
AND nerc_region = 'MRO'

-- Counting
-- Obtain a count of 'grid_id'
SELECT
COUNT(grid_id) AS RFC_count
FROM
grid
-- Restrict to rows where the nerc_region is 'RFC'
WHERE
NERC_REGION = 'RFC'

-- MIN, MAX, and AVG
-- Find the minimum number of affected customers
SELECT
MIN(affected_customers) AS min_affected_customers
FROM
grid
-- Only retrieve rows where demand_loss_mw has a values
WHERE
demand_loss_mw IS NOT NULL;

-- Find the maximum number of affected customers
SELECT 
  MAX(affected_customers) AS max_affected_customers 
FROM 
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE 
  demand_loss_mw IS NOT NULL;
  
-- Find the average number of affected customers
SELECT 
  AVG(affected_customers) AS avg_affected_customers 
FROM 
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE 
  demand_loss_mw IS NOT NULL;
  
-- Strings
--LEN'gth of a string
-- Retrieve the length of the desciption column, returning the reults as description_lenght
SELECT
LEN(descritption) AS description_length
FROM
grid;

-- Select the first 25 characters from the left of the description column
SELECT
LEFT(description, 25) AS first_25_left
FROM
grid;

-- Amend the query to selet 25 characters from the right of the description column
SELECT
RIGHT(description, 25) AS last_25_right
FROM
grid;

-- Find the word Weather within the description column using CHARINDEX
SELECT
description,
CHARINDEX('Weather', description)
FROM
grid
WHERE
description LIKE '%Weather%';

-- Find the length of Weather
SELECT
description,
CHARINDEX('Weather', description) As start_of_string,
LEN('Weather') AS length_of_string
FROM
grid
WHERE 
description LIKE '%Weather%';

-- Complete the substring function to begin extracting from the correct character in the 
-- description column
SELECT TOP (10)
  description, 
  CHARINDEX('Weather', description) AS start_of_string, 
  LEN ('Weather') AS length_of_string, 
  SUBSTRING(
    description, 
    15, 
    LEN(description)
  ) AS additional_description 
FROM 
  grid
WHERE description LIKE '%Weather%';

-- Grouping and Having
-- GROUP BY
-- Select nerc_region and the sum of demand_loss_mw for each region
-- Select the region column
SELECT 
  nerc_region,
  -- Sum the demand_loss_mw column
  SUM(demand_loss_mw) AS demand_loss
FROM 
  grid
  -- Exclude NULL values of demand_loss
WHERE 
  demand_loss_mw IS NOT NULL
  -- Group the results by nerc_region
GROUP BY
  nerc_region
  -- Order the results in descending order of demand_loss
ORDER BY 
  demand_loss DESC;
  
-- Having
-- Modify the provided query to remove the WHERE clause. Replace it with a HAVING clause so 
-- that only results with a total demand_loss_mw of greater than 10000 are returned
SELECT 
  nerc_region, 
  SUM (demand_loss_mw) AS demand_loss 
FROM 
  grid 
GROUP BY 
  nerc_region 
  -- Enter a new HAVING clause so that the sum of demand_loss_mw is greater than 10000
HAVING 
  SUM(demand_loss_mw) > 10000 
ORDER BY 
  demand_loss DESC;
  
-- Grouping together
-- Use MIN and MAX to retrieve the minimum and maximum values for the place and points
-- columns respectively
-- Add a GROUP BY and group by country;
-- Return the count of entries per country and the country column. Complete the aggregate
-- session by finding the average place for each country;

-- Obtain a count for each country
SELECT 
  COUNT(country) AS country_count,
  -- Retrieve the country column
  country,
  -- Return the average of the Place column
  AVG(place) AS average_place,
  -- Retrieve the minimum and maximum place values  
  MIN(place) AS min_place, 
  MAx(place) AS max_place, 
  -- Retrieve the minimum and maximum points values
  MIN(points) AS min_points, 
  MAX(points) AS max_points 
FROM 
  eurovision;
  -- Group by country
GROUP BY
  country;
  
 -- Apply a filter so we only return rows where the country_count is greater than 5
 -- Tehn arrange by avg_place is ascending order, and avg_points in descending order
 SELECT 
  country, 
  COUNT (country) AS country_count, 
  AVG (place) AS avg_place, 
  AVG (points) AS avg_points, 
  MIN (points) AS min_points, 
  MAX (points) AS max_points 
FROM 
  eurovision 
GROUP BY 
  country 
  -- The country column should only contain those with a count greater than 5
HAVING 
  COUNT(country) > 5 
  -- Arrange columns in the correct order
ORDER BY 
  avg_place, 
  avg_points DESC;