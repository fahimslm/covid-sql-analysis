-- 05_country_rankings.sql
-- Purpose: Rank countries using population-adjusted COVID metrics

--------------------------------------------------
-- 1. Top countries by total reported deaths (raw counts)
--------------------------------------------------
SELECT
    location,
    MAX(total_deaths) AS total_deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths DESC;

--------------------------------------------------
-- 2. Top countries by deaths per 100,000 people
--------------------------------------------------
SELECT
    location,
    population,
    MAX(total_deaths * 100000.0 / NULLIF(population, 0)) AS deaths_per_100k
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY deaths_per_100k DESC;

--------------------------------------------------
-- 3. Top countries by peak daily deaths
--------------------------------------------------
SELECT
    location,
    MAX(new_deaths) AS max_daily_deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY max_daily_deaths DESC;

--------------------------------------------------
-- 4. Compare rankings: raw deaths vs normalized deaths
--------------------------------------------------
SELECT
    location,
    MAX(total_deaths) AS total_deaths,
    MAX(total_deaths * 100000.0 / NULLIF(population, 0)) AS deaths_per_100k
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY deaths_per_100k DESC;
