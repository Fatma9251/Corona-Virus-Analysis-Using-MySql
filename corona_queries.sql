USE corona_virus;
CREATE TABLE covid_data (
    Province VARCHAR(255),
    Country_Region VARCHAR(255),
    Latitude FLOAT,
    Longitude FLOAT,
    Date DATE,
    Confirmed INT,
    Deaths INT,
    Recovered INT
);
--------------------------------------------------------------------------------
-- Q1. Write a code to check NULL values
SELECT * 
FROM covid_data
WHERE Province IS NULL
OR Country_Region IS NULL 
OR Latitude IS NULL
OR Longitude IS NULL
OR Date IS NULL
OR Confirmed IS NULL
OR Deaths IS NULL
OR Recovered IS NULL;
---------------------------------------------------
-- Q2. If NULL values are present, update them with zeros for all columns. 
-- answer: From my analysis I didn't find any nulls to handle
------------------------------------------------------
-- Q3. check total number of rows
SELECT COUNT(*)
FROM covid_data;
---------------------------------------
-- Q4. Check what is start_date and end_date
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM covid_data;
----------------------------------------
-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT DATE_FORMAT(Date, '%Y-%m')) AS Number_Of_Months_Data_Recorded
FROM covid_data;
-- another approach of solution:
SELECT ROUND(DATEDIFF(MAX(Date), MIN(DATE)) / 29) AS Number_Of_Months_Data_Recorded
FROM covid_data;
---------------------------------------
-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
	AVG(Confirmed) AS avg_confirmed_cases, 
    AVG(Deaths) AS avg_deaths_cases,
    AVG(Recovered) AS avg_recovered_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m'); 
------------------------------------------------------
-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
WITH confirmed_frequency AS(
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
	Confirmed AS confirmed_records, 
    COUNT(Confirmed) AS Frequency
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m'),
Confirmed
ORDER BY COUNT(Confirmed) desc
LIMIT 18)
SELECT Month,  confirmed_records, Frequency
FROM confirmed_frequency
order by Month;
------------------------------------
-- Q7. Find most frequent value for deaths each month
WITH deaths_frequency AS(
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
	Deaths AS deaths_records, 
    COUNT(Deaths) AS Frequency
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m'),
Deaths
ORDER BY COUNT(Deaths) desc
LIMIT 18)
SELECT Month,  deaths_records, Frequency
FROM deaths_frequency
order by Month;
 
-- Q7. Find most frequent value for recovered each month 
WITH recovered_frequency AS(
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
	Recovered AS recovered_records, 
    COUNT(Recovered) AS Frequency
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m'),
Recovered
ORDER BY COUNT(Recovered) desc
LIMIT 18)
SELECT Month, recovered_records, Frequency
FROM recovered_frequency
order by Month;
-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT DATE_FORMAT(Date, '%Y') AS Year, 
	MIN(Confirmed) AS min_confirmed_cases, 
    MIN(Deaths) AS min_deaths_cases,
    MIN(Recovered) AS min_recovered_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y'); 

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT DATE_FORMAT(Date, '%Y') AS Year, 
	MAX(Confirmed) AS max_confirmed_cases, 
    MAX(Deaths) AS max_deaths_cases,
    MAX(Recovered) AS max_recovered_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y'); 

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, 
	SUM(Confirmed) AS total_confirmed_cases, 
    SUM(Deaths) AS total_deaths_cases,
    SUM(Recovered) AS total_recovered_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m'); 

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(Confirmed) AS total_confirmed_cases,
	AVG(Confirmed) AS average_confirmed_cases,
    VARIANCE(Confirmed) AS variance_confirmed_cases,
    STDDEV(Confirmed) AS stdev_confirmed_cases
FROM covid_data;
-------------- Extra Analysis -----------
SELECT SUM(Recovered) AS total_recovered_cases,
	AVG(Recovered) AS average_recovered_cases,
    VARIANCE(Recovered) AS variance_recovered_cases,
    STDDEV(Recovered) AS stdev_recovered_cases
FROM covid_data;
---------------------
SELECT SUM(Deaths) AS total_deaths_cases,
	AVG(Deaths) AS average_deaths_cases,
    VARIANCE(Deaths) AS variance_deaths_cases,
    STDDEV(Deaths) AS stdev_deaths_cases, 
    MAX(Deaths) AS max_deaths_cases
FROM covid_data;
-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
	SUM(Deaths) AS total_deaths_cases,
	AVG(Deaths) AS average_deaths_cases,
    VARIANCE(Deaths) AS variance_deaths_cases,
    STDDEV(Deaths) AS stdev_deaths_cases
FROM covid_data
GROUP BY DATE_FORMAT(Date, '%Y-%m');

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total recovered cases, their average, variance & STDEV )
SELECT SUM(Recovered) AS total_recovered_cases,
	AVG(Recovered) AS average_recovered_cases,
    VARIANCE(Recovered) AS variance_recovered_cases,
    STDDEV(Recovered) AS stdev_recovered_cases
FROM covid_data;

-- Q14. Find Country having highest number of the Confirmed case
SELECT Country_Region AS Highest_Country_with_Confirmed_Cases,
	SUM(Confirmed) AS number_of_confirmed_cases
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Confirmed) DESC
LIMIT 1;
-- Q15. Find Country having lowest number of the death case
SELECT Country_Region AS Lowest_Country_with_Death_Cases,
	SUM(Deaths) AS number_of_death_cases
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Deaths)
LIMIT 5;

-- Q16. Find top 5 countries having highest recovered case
SELECT Country_Region AS Top_5_Countries_with_recovered_Cases,
	SUM(Recovered) AS number_of_recovered_cases
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Recovered) DESC
LIMIT 5;