# COVID-19 Data Analysis using SQL

## Overview
This project explores global COVID-19 data using SQL to analyze cases, deaths, and vaccination trends across countries and regions.

## Dataset
The analysis uses publicly available COVID-19 datasets containing daily reported cases, deaths, population data, and vaccination metrics.

## Objectives
- Analyze global and country-level COVID-19 trends
- Compare reported cases and deaths across regions
- Calculate cumulative and rolling metrics using SQL
- Explore vaccination progress over time
- Identify data limitations and reporting differences

## Tools Used
- SQL Server
- SQL (CTEs, JOINs, Window Functions)
- GitHub for version control and documentation

## Key Techniques
- JOINs between deaths and vaccination datasets
- Aggregations using GROUP BY and HAVING
- Window functions for rolling totals
- CTEs and Views for reusable logic
- Handling NULL values and cumulative metrics

## Key Insights
- COVID impact varied significantly when normalized by population rather than raw totals.
- Reported case fatality ratios and deaths differed across regions due to reporting definitions and timing.
- Vaccination progress accelerated unevenly across countries during the 2020–2021 period.
- Rolling and time-series metrics provided clearer trends than daily raw counts.

## Limitations
- Dataset covers January 2020 through late 2021.
- Figures represent reported data and may differ from later revisions or estimates.

## Notes
This project emphasizes data exploration and interpretation rather than definitive public health conclusions. Reported figures depend on data source definitions and update frequency.

