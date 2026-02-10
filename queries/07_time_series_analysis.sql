-- 07_time_series_analysis.sql
-- Purpose: Analyze COVID trends over time (Jan 2020–late 2021)

--------------------------------------------------
-- 1. Global daily cases and deaths over time
--------------------------------------------------
SELECT
    date,
    SUM(COALESCE(new_cases, 0)) AS global_new_cases,
    SUM(COALESCE(new_deaths, 0)) AS global_new_deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

--------------------------------------------------
-- 2. Daily change in cases for a country (example: United States)
--------------------------------------------------
SELECT
    date,
    new_cases,
    LAG(new_cases) OVER (ORDER BY date) AS previous_day_cases,
    new_cases - LAG(new_cases) OVER (ORDER BY date) AS daily_change
FROM CovidDeaths
WHERE location = 'United States'
ORDER BY date;

--------------------------------------------------
-- 3. Identify peak daily cases by country
--------------------------------------------------
SELECT
    location,
    MAX(new_cases) AS peak_daily_cases
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY peak_daily_cases DESC;

--------------------------------------------------
-- 4. Monthly aggregation to smooth daily volatility
--------------------------------------------------
SELECT
    location,
    FORMAT(date, 'yyyy-MM') AS year_month,
    SUM(COALESCE(new_cases, 0)) AS monthly_cases,
    SUM(COALESCE(new_deaths, 0)) AS monthly_deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, FORMAT(date, 'yyyy-MM')
ORDER BY location, year_month;
