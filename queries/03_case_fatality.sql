-- 03_case_fatality.sql
-- Purpose: Analyze reported case fatality ratios over time and by country

--------------------------------------------------
-- 1. Case fatality ratio over time (all countries)
--------------------------------------------------
SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths * 100.0 / NULLIF(total_cases, 0)) AS case_fatality_pct
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

--------------------------------------------------
-- 2. Case fatality ratio for a specific country (example: United States)
--------------------------------------------------
SELECT
    date,
    total_cases,
    total_deaths,
    (total_deaths * 100.0 / NULLIF(total_cases, 0)) AS case_fatality_pct
FROM CovidDeaths
WHERE location = 'United States'
ORDER BY date;

--------------------------------------------------
-- 3. Maximum reported case fatality ratio by country
--------------------------------------------------
SELECT
    location,
    MAX(total_deaths * 100.0 / NULLIF(total_cases, 0)) AS max_case_fatality_pct
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY max_case_fatality_pct DESC;

--------------------------------------------------
-- 4. Countries with highest deaths per population (normalization check)
--------------------------------------------------
SELECT
    location,
    MAX(total_deaths * 100000.0 / population) AS deaths_per_100k
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY deaths_per_100k DESC;
