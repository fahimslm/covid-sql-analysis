-- 06_continent_analysis.sql
-- Purpose: Analyze COVID impact at the continent level

--------------------------------------------------
-- 1. Total reported cases and deaths by continent
--------------------------------------------------
SELECT
    continent,
    SUM(COALESCE(new_cases, 0)) AS total_cases,
    SUM(COALESCE(new_deaths, 0)) AS total_deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths DESC;

--------------------------------------------------
-- 2. Death percentage by continent
--------------------------------------------------
SELECT
    continent,
    SUM(COALESCE(new_cases, 0)) AS total_cases,
    SUM(COALESCE(new_deaths, 0)) AS total_deaths,
    (SUM(COALESCE(new_deaths, 0)) * 100.0 /
     NULLIF(SUM(COALESCE(new_cases, 0)), 0)) AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY death_percentage DESC;

--------------------------------------------------
-- 3. Deaths per 100,000 people by continent
--------------------------------------------------
SELECT
    continent,
    SUM(COALESCE(new_deaths, 0)) * 100000.0 /
    NULLIF(SUM(population), 0) AS deaths_per_100k
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY deaths_per_100k DESC;
