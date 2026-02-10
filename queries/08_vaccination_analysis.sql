-- 08_vaccination_analysis.sql
-- Purpose: Analyze vaccination progress using rolling totals (2020–2021)

--------------------------------------------------
-- 1. Join deaths and vaccinations datasets
--------------------------------------------------
WITH vaccination_data AS (
    SELECT
        d.location,
        d.continent,
        d.date,
        d.population,
        v.new_vaccinations
    FROM CovidDeaths d
    JOIN CovidVaccinations$ v
      ON d.location = v.location
     AND d.date = v.date
    WHERE d.continent IS NOT NULL
)
--------------------------------------------------
-- 2. Calculate rolling vaccination totals by country
--------------------------------------------------
SELECT
    location,
    date,
    population,
    new_vaccinations,
    SUM(COALESCE(new_vaccinations, 0))
        OVER (PARTITION BY location ORDER BY date) AS rolling_people_vaccinated
FROM vaccination_data
ORDER BY location, date;
