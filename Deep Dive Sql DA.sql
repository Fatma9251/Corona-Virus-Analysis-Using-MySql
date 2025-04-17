USE corona_virus;

-- Overviewing the Data
SELECT * 
FROM covid_data
LIMIT 15 OFFSET 1000;
--------- 
-- Check what is start_date and end_date
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM covid_data;
-- The data is about corona report records collected from 2020-01-22 to 2021-06-13 
------------
-- Count the number of regions under study
SELECT COUNT(DISTINCT Country_Region) AS countries_count
FROM covid_data;
-- 121 countries are of interest in this study case 
--------------
-- Count the number of provinces under study
SELECT COUNT(DISTINCT Province) AS provinces_count
FROM covid_data;
-- with 154 provinces entailed
---------
-- How many provinces each country have in this study case:
SELECT Country_Region, COUNT(DISTINCT Province) AS provinces_count_per_country
FROM covid_data
GROUP BY Country_Region
ORDER BY COUNT(DISTINCT Province) DESC;
-- China has 14 provinces - max number of provinces, Australia has 8, Canada and UK each one has 6 provinces, 
-- Denmark, France, and Netherlands each one has 2 provinces
-- All other countries participates only with 1 province
---------------------------
-- How many times we collect data from each province?
SELECT Province, COUNT(Province) AS Times_Data_Collected
FROM covid_data
GROUP BY Province;
-- We have 509 corona report records for each province
----------------------
-- which countries had the most number of corona cases
SELECT Country_Region, 
	SUM(Confirmed) AS total_confirmed_cases,
    SUM(Recovered) AS total_recovered_cases,
    SUM(Deaths) AS total_deaths_cases, 
    (SUM(Recovered)/SUM(Confirmed))*100 AS recovered_pct,
    (SUM(Deaths)/SUM(Confirmed))*100 AS deaths_pct
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Confirmed) DESC;
-- US, India, Brazil, France, Turkey, Russia, and UK were the highest countries with corona cases
-- Indicating that big countries had suffered the most with corona
-- Canada recorded about 695869 corona cases but had ZERO records for in the Recovered report file!! what happened to those who weren't recorded either as dead or recovered?
-- The same with Sweden, Zero records for collected for recovered cases
-- Not all cases confirmed as corona virus were recorded in the futurre as either recovered or dead -- There's a missing piece for the complete puzzle
-- what happened to those who had corona virus but their future status as either recovered or dead was never recorded
------------
-- The Lowest countries to have corona cases:
SELECT Country_Region, 
	SUM(Confirmed) AS total_confirmed_cases,
    SUM(Recovered) AS total_recovered_cases,
    SUM(Deaths) AS total_deaths_cases, 
    (SUM(Recovered)/SUM(Confirmed))*100 AS recovered_pct,
    (SUM(Deaths)/SUM(Confirmed))*100 AS deaths_pct
FROM covid_data
GROUP BY Country_Region
ORDER BY  SUM(Recovered) DESC
LIMIT 10;
-- Samoa had only 3 cases and all the cases got recovered- WOW
-- see countries on the map and try to figure out geographically why these regions had the minimum corona cases!
------------
-- see countries on the map and try to figure out geographically why these regions had the minimum corona cases!
-- For this I will obsereve the relations between latitudes and longitudes
SELECT DISTINCT Province, Country_Region, Latitude, Longitude
FROM covid_data
WHERE Country_Region IN ( 'Kiribati',
'Samoa',
'Marshall Islands',
'Dominica',
'Tanzania',
'Mauritius',
'Bhutan',
'New Zealand',
'Barbados',
'San Marino'
); 
---------------------------
SELECT DISTINCT Province, Country_Region, Latitude, Longitude
FROM covid_data
WHERE Country_Region IN ( 'US',
'India',
'Brazil',
'France',
'Turkey',
'Russia',
'United Kingdom',
'Italy',
'Argentina',
'Spain',
'Colombia',
'Germany',
'Iran',
'Poland');
-- Which Countries/Regions had the highest recovered cases with respect to confirmed cases per country?
-- The Lowest countries to have corona cases:
SELECT Country_Region, 
	SUM(Confirmed) AS total_confirmed_cases,
    SUM(Recovered) AS total_recovered_cases,
    SUM(Deaths) AS total_deaths_cases, 
    (SUM(Recovered)/SUM(Confirmed))*100 AS recovered_pct,
    (SUM(Deaths)/SUM(Confirmed))*100 AS deaths_pct
FROM covid_data
GROUP BY Country_Region
ORDER BY  SUM(Confirmed) 
LIMIT 10;
-- logic data errors: some countries like lituania and Luxembourg had recorded number of recovered cases that is larger than number of confirmed cases
-- Data needs alittle bit of cleaning, for now we will just consider that 100% of the confirmed cases were recovered
-- This data error for me has an explanation:
	-- some people had corona virus and got recovered from it, that may mean that some confirmed corona cases records have been lost
--------------------------
SELECT DISTINCT Country_Region, Latitude, Longitude
FROM covid_data;
-----------------------------
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
	SUM(Confirmed) AS total_confirmed_cases,
	AVG(Confirmed) AS average_confirmed_cases,
    VARIANCE(Confirmed) AS variance_confirmed_cases,
    STDDEV(Confirmed) AS stdev_confirmed_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m');
-----------------------------------
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
	SUM(Recovered) AS total_recoverd_cases,
	AVG(Recovered) AS average_recoverd_cases,
    VARIANCE(Recovered) AS variance_recoverd_cases,
    STDDEV(Recovered) AS stdev_recoverd_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m');
----------------------------
SELECT DISTINCT Country_Region, Latitude, Longitude
FROM covid_data
where Country_Region IN ('US');