select *
from covid_deaths;

select *
from covid_vaccination;

select location, date, total_cases, total_deaths, new_cases, population
from covid_deaths
order by 1,2;

-- Total cases vs Total deaths
--What is the actual numbers of death occured?
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercent
from covid_deaths
where location like '%tates%'
order by 1,2;

--Total cases vs population
--What percent of population has got covid
select location, date, population, total_cases, total_deaths, (total_cases/population)*100 as populaton_percent_infected
from covid_deaths
--where location like '%tates%'
order by 1,2;

--what are the countries with the highest infection rate compared to population
select Location, population, max(total_cases) as highest_infection_count, max((total_cases/population)*100) as  populaton_percent_infected
from covid_deaths
group by location, population
order by populaton_percent_infected desc

--what are the countries with the highest death count per population
select continent, max(total_deaths) as Total_death
from covid_deaths
where continent IS NOT NULL AND total_deaths IS NOT NULL
group by continent
order by Total_death desc;

-- Global numbers

SELECT  
    SUM(new_cases) as total_cases, 
    SUM(cast(new_deaths as int)) as totaldeath, 
    SUM(cast(new_deaths as int))/SUM(new_cases)*100 as death_percent
FROM 
    covid_deaths
WHERE 
    continent IS NOT NULL 
order by 1,2;

--Calculate total population vs vaccination
-- how many people got vaccinated?
with popvsvac  (continent, location, date, population, new_vaccination, rollingpeoplevaccinated)
as
(
	SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, 
	SUM(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as rollingpeoplevaccinated
	from covid_deaths d
	join covid_vaccination v
	  ON d.location = v.location
	  AND d.date = v.date
	where d.continent != 'NULL'
)
select *, (rollingpeoplevaccinated/population)*100 as rollingpeoplevaccinated_per_population
from popvsvac
where new_vaccination is not null and rollingpeoplevaccinated is not null;
	
--temp table
DROP table if exists percentpopulationvaccinated;
create table percentpopulationvaccinated
(
	continent text,
	location text,
	date date,
	population bigint,
	new_vaccinations bigint,
	rollingproplevaccinated bigint
);
Insert into percentpopulationvaccinated
(
	SELECT  d.continent, d.location, d.date, d.population, v.new_vaccinations, 
			SUM(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as rollingpeoplevaccinated
	from covid_deaths d
	join covid_vaccination v
	  ON d.location = v.location
	  AND d.date = v.date
	  where d.continent != 'NULL'
);

select * from percentpopulationvaccinated where new_vaccinations is not null and rollingproplevaccinated > 1000 limit 5;

--creating view to store data for later visualisation

CREATE VIEW percentpopnvaccinated as
SELECT d.continent, d.location, d.date, d.population, d.new_cases, v.new_vaccinations,
SUM(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as rollingpeoplevaccinated
	from covid_deaths d
	join covid_vaccination v
	  ON d.location = v.location
	  AND d.date = v.date
	  where d.continent != 'NULL'