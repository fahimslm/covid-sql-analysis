-- 02_data_quality.sql
-- Purpose: Validate data completeness, date coverage, and metric consistency

--------------------------------------------------
-- 1. Check overall date range of the dataset
--------------------------------------------------
SELECT
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date
FROM CovidDeaths;

--------------------------------------------------
-- 2. Check date coverage by country (example: China vs United States)
--------------------------------------------------
SELECT
    location,
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date
FROM CovidDeaths
WHERE location IN ('China', 'United States')
GROUP BY location;

--------------------------------------------------
-- 3. Identify rows with missing critical metrics
--------------------------------------------------
SELECT
    COUNT(*) AS rows_with_missing_data
FROM CovidDeaths
WHERE total_cases IS NULL
   OR total_deaths IS NULL
   OR population IS NULL;

--------------------------------------------------
-- 4. Countries with missing death data
--------------------------------------------------
SELECT
    location,
    COUNT(*) AS missing_death_rows
FROM CovidDeaths
WHERE total_deaths IS NULL
GROUP BY location
ORDER BY missing_death_rows DESC;

--------------------------------------------------
-- 5. Validate cumulative logic (new deaths vs total deaths)
--------------------------------------------------
SELECT
    location,
    date,
    new_deaths,
    total_deaths
FROM CovidDeaths
WHERE new_deaths > total_deaths
  AND continent IS NOT NULL;
