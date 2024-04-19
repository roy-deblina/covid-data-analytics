# covid-data-analytics

This repository contains SQL queries for analyzing COVID-19 statistics sourced from the World Health Organization (WHO) website. The dataset includes information about cases, deaths, vaccinations, and population demographics across various locations and dates.

##Queries Overview
The repository includes the following SQL queries:

Total Cases vs Total Deaths: Compares total cases to total deaths, calculating the percentage of deaths relative to total cases.
Total Cases vs Population: Compares total cases to population, calculating the percentage of the population infected with COVID-19 over time.
Total Death Count by Location: Aggregates the total death count for each location, providing insight into the impact of COVID-19 on different regions.
Countries with Highest Infection Rate Compared to Population: Identifies countries with the highest infection rates relative to their populations.
Countries with Highest Death Count per Population: Finds the continents with the highest death counts per population, offering insights into the severity of the pandemic across different regions.
Global Numbers: Calculates global COVID-19 statistics, including total cases, total deaths, and the percentage of deaths relative to total cases.
Total Population vs Vaccination: Calculates the percentage of the population that has been vaccinated against COVID-19, considering total population and vaccination data.
Creating View for Visualization Data: Creates a view named percentpopnvaccinated, which combines COVID-19 cases and vaccination data for later visualization.
Temporary Table Creation: Creates a temporary table named percentpopulationvaccinated to store combined COVID-19 cases and vaccination data for further analysis.

# Visualizations in Tableau

## Visual 1
- Add `total_deaths`, `total_cases`, and `death_percent` to the Columns shelf using aggregate functions.
- Select the chart type as `Cart`.
- Adjust color and size as desired.
- Set `death_percent` column to display 2 decimal points by selecting from the number format options.

## Visual 2
- From the `Location` column, select `Countries/Region` for geographical role as the visualization will be a map.
- Add `longitude` to the Columns shelf and `latitude` to the Rows shelf.
- Add `location` and `percent_population_infected` to Marks.
- Select `percent_population_infected` for color to differentiate locations by color.

## Visual 3
- Add `date` to the Columns shelf and `percent_population_infected` to the Rows shelf.
- Adjust `percent_population_infected` to display as an average and `date` to display month-wise.
- Customize the visualization by adding `location` for color and label.
- Use the Analysis menu to select Forecast to generate a forecasting visual.
- Add labels for population infected.

## Visual 4
- Place `Location` in Columns and `totalDeathcount` in Rows.
- Choose a column chart as the visual.
- Customize color and size as desired.

## Dashboard
- Create a new dashboard to combine all four sheet visuals onto a single page.

