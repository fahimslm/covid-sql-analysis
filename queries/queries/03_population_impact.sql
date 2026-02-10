-- 04_population_impact.sql
-- Purpose: Analyze infection levels relative to population size

--------------------------------------------------
-- 1. Daily percentage of population infected (cumulative)
--------------------------------------------------
SELECT
    location,
    date,
    population,
    total_cases,
    (total_cases * 100.0 / NULLIF(population, 0)) AS percent_population_infected
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

--------------------------------------------------
-- 2. Highest reported infection percentage by country
--------------------------------------------------
SELECT
    location,
    population,
    MAX(total_cases * 100.0 / NULLIF(population, 0)) AS max_percent_population_infected
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY max_percent_population_infected DESC;

--------------------------------------------------
-- 3. Top 10 countries by infection penetration
--------------------------------------------------
SELECT TOP 10
    location,
    population,
    MAX(total_cases * 100.0 / NULLIF(population, 0)) AS max_percent_population_infected
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY max_percent_population_infected DESC;
