-- 09_ctes_and_views.sql
-- Purpose: Create reusable logic using CTEs and Views

--------------------------------------------------
-- 1. Use a CTE to calculate rolling vaccination totals
--------------------------------------------------
WITH vaccination_cte AS (
    SELECT
        d.location,
        d.continent,
        d.date,
        d.population,
        v.new_vaccinations,
        SUM(COALESCE(v.new_vaccinations, 0))
            OVER (PARTITION BY d.location ORDER BY d.date) AS rolling_people_vaccinated
    FROM CovidDeaths d
    JOIN CovidVaccinations$ v
      ON d.location = v.location
     AND d.date = v.date
    WHERE d.continent IS NOT NULL
)
SELECT
    location,
    date,
    population,
    rolling_people_vaccinated,
    (rolling_people_vaccinated * 100.0 / NULLIF(population, 0)) AS percent_population_vaccinated
FROM vaccination_cte
ORDER BY location, date;

--------------------------------------------------
-- 2. Create a View for repeated use (dashboards, reporting)
--------------------------------------------------
CREATE VIEW PercentPopulationVaccinated AS
SELECT
    d.location,
    d.continent,
    d.date,
    d.population,
    SUM(COALESCE(v.new_vaccinations, 0))
        OVER (PARTITION BY d.location ORDER BY d.date) AS rolling_people_vaccinated
FROM CovidDeaths d
JOIN CovidVaccinations$ v
  ON d.location = v.location
 AND d.date = v.date
WHERE d.continent IS NOT NULL;
