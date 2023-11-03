/*Are there any null values in any columns in either table?*/

SELECT *
FROM scooters
WHERE chargelevel IS NULL;
--Answer - 770 rows with a null in the scooters.chargelevel, 40 distinct sumdid, 369 distinct latitude, 361 distinct longitude, 
      --all same sumdtype, 3 distinct costpermin, 2 distinct companyname */

/* - What date range is represented in each of the date columns? Investigate any values that seem odd. */

SELECT MIN(pubdatetime), MAX(pubdatetime)
FROM scooters;
--May - July 2019

SELECT MIN(pubtimestamp), MAX(pubtimestamp)
FROM trips;
--May - August 1st, 2019

SELECT MIN(startdate), MAX(startdate)
FROM trips;
--May - July 2019

SELECT MIN(enddate), MAX(enddate)
FROM trips;
--May - August 1st, 2019

/* Is time represented with am/pm or using 24 hour values in each of the columns that include time? */

SELECT *
FROM scooters
ORDER BY pubdatetime DESC
LIMIT 5;
--looks like 24

SELECT *
FROM trips
ORDER BY enddate DESC
LIMIT 5;
--looks like 24

/* What values are there in the sumdgroup column? Are there any that are not of interest for this project? */

SELECT COUNT(*), sumdgroup
FROM scooters
GROUP BY sumdgroup;
--Can ignore sumdgroup 'bicycle'

SELECT *
FROM scooters
WHERE sumdgroup <> 'bicycle'
LIMIT 100;

/* What are the minimum and maximum values for all the latitude and longitude columns? 
Do these ranges make sense, or is there anything surprising? */

SELECT MIN(latitude), MAX(latitude)
FROM scooters;
--0.0, 3609874.11

SELECT MIN(longitude), MAX(longitude)
FROM scooters;
--97.44, 0.0

SELECT MIN(startlatitude), MAX(startlatitude)
FROM trips;
--35.85, 36.30

SELECT MIN(endlatitude), MAX(endlatitude)
FROM trips;
-- -36.85, 51.045

SELECT *
FROM trips
WHERE endlatitude > 50;
--this trip ends in Russia!

SELECT MIN(startlongitude), MAX(startlongitude)
FROM trips;
-- -86.91, -86.36

SELECT MIN(endlongitude), MAX(endlongitude)
FROM trips;
-- -122.67, 174.76

/* -What is the range of values for trip duration and trip distance? Do these values make sense? 
Explore values that might seem questionable. */

SELECT MIN(tripduration), MAX(tripduration)
FROM trips;
-- -19.35, 512619

SELECT *
FROM trips 
WHERE tripduration = 512619.0;
-- this trip was a year?

SELECT MIN(tripdistance), MAX(tripdistance)
FROM trips;
-- -20324803.8, 31884482.6476 - over 6,000 miles?

/*- Check out how the values for the company name column in the scooters table 
compare to those of the trips table. What do you notice? */

SELECT COUNT(*), companyname
FROM scooters
GROUP BY companyname
ORDER BY COUNT(*) DESC;

SELECT COUNT(*), companyname
FROM trips
GROUP BY companyname
ORDER BY COUNT(*) DESC;
--there is an inverse relationship

/* Narrow down what I want to work with in Python */

--This is data from the scooters table from just one date
SELECT DATE(pubdatetime), latitude, longitude, sumdid, companyname
FROM scooters
WHERE sumdgroup <> 'bicycle' AND DATE(pubdatetime) = '2019-05-01';


SELECT DATE(pubtimestamp), companyname, sumdid, triprecordnum, tripduration, tripdistance
FROM trips
WHERE DATE(pubtimestamp) = '2019-05-01';

SELECT EXTRACT(MONTH from DATE(pubtimestamp)) AS month, pubtimestamp, companyname, sumdid, triprecordnum, tripduration, tripdistance
FROM trips
WHERE EXTRACT(MONTH from DATE(pubtimestamp)) = 5;

--scooters in may from pyft
SELECT EXTRACT(MONTH from DATE(pubdatetime)) AS month, pubdatetime, companyname, sumdid, latitude, longitude, chargelevel, costpermin
FROM scooters
WHERE EXTRACT(MONTH from DATE(pubdatetime)) = 5 AND sumdgroup <> 'bicycle' AND companyname = 'Lyft';


