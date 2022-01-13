---- Create covidDeaths table
DROP TABLE IF EXISTS CovidDeaths;
CREATE TABLE CovidDeaths(
	iso_code VARCHAR(50),
	continent VARCHAR(50),
	location VARCHAR(50),
	date DATE, 
	population BIGINT, 
	total_cases INT,
	new_cases INT,
	new_cases_smoothed NUMERIC,
	total_deaths INT,
	new_deaths INT,
	new_deaths_smoothed NUMERIC,
	total_cases_per_million NUMERIC,
	new_cases_per_million NUMERIC,
	new_cases_smoothed_per_million NUMERIC,
	total_deaths_per_million NUMERIC,
	new_deaths_per_million NUMERIC,
	new_deaths_smoothed_per_million NUMERIC,
	reproduction_rate NUMERIC,
	icu_patients INT,
	icu_patients_per_million NUMERIC,
	hosp_patients INT,
	hosp_patients_per_million NUMERIC,
	weekly_icu_admissions INT,
	weekly_icu_admissions_per_million NUMERIC,
	weekly_hosp_admissions INT,
	weekly_hosp_admissions_per_million NUMERIC
	);

COPY CovidDeaths(iso_code,continent,location,date,population,total_cases,new_cases,new_cases_smoothed,total_deaths,new_deaths,new_deaths_smoothed,total_cases_per_million,new_cases_per_million,new_cases_smoothed_per_million,total_deaths_per_million,new_deaths_per_million,new_deaths_smoothed_per_million,reproduction_rate,icu_patients,icu_patients_per_million,hosp_patients,hosp_patients_per_million,weekly_icu_admissions,weekly_icu_admissions_per_million,weekly_hosp_admissions,weekly_hosp_admissions_per_million)	
FROM 'D:\TOPIC_RELATED VOCABULARY IELTS\Finland\aalto\ISM major\CAREER side projects+portfolio for DA+ dashboard\CovidDeaths28122021.csv'
DELIMITER ','
CSV HEADER;


SHOW datestyle;
SET datestyle TO "DMY";

---- Create covidVaccinations table
CREATE TABLE CovidVaccinations(
iso_code VARCHAR(50),	
continent VARCHAR(50),	
location VARCHAR(50),
date DATE,
new_tests INT,
total_tests INT,
total_tests_per_thousand NUMERIC,	
new_tests_per_thousand NUMERIC,	
new_tests_smoothed NUMERIC,	
new_tests_smoothed_per_thousand NUMERIC,
positive_rate NUMERIC,	
tests_per_case NUMERIC,	
tests_units VARCHAR(50),	
total_vaccinations BIGINT,	
people_vaccinated BIGINT,	
people_fully_vaccinated BIGINT,
total_boosters BIGINT,	
new_vaccinations INT,	
new_vaccinations_smoothed NUMERIC, 	
total_vaccinations_per_hundred NUMERIC,
people_vaccinated_per_hundred NUMERIC,	
people_fully_vaccinated_per_hundred NUMERIC,	
total_boosters_per_hundred NUMERIC,	
new_vaccinations_smoothed_per_million NUMERIC,	
new_people_vaccinated_smoothed NUMERIC,	
new_people_vaccinated_smoothed_per_hundred NUMERIC,	
stringency_index NUMERIC,		
population_density NUMERIC,	
median_age NUMERIC,	
aged_65_older NUMERIC,	
aged_70_older NUMERIC,	
gdp_per_capita NUMERIC,	
extreme_poverty NUMERIC ,	
cardiovasc_death_rate NUMERIC,	
diabetes_prevalence NUMERIC,	
female_smokers NUMERIC,	
male_smokers NUMERIC,	
handwashing_facilities NUMERIC,	
hospital_beds_per_thousand NUMERIC,	
life_expectancy NUMERIC,	
human_development_index NUMERIC,	
excess_mortality_cumulative_absolute NUMERIC,	
excess_mortality_cumulative NUMERIC,	
excess_mortality NUMERIC,	
excess_mortality_cumulative_per_million NUMERIC
);
DROP TABLE CovidVaccinations;
COPY CovidVaccinations(iso_code,continent,location,date,new_tests,total_tests,total_tests_per_thousand,new_tests_per_thousand,new_tests_smoothed,new_tests_smoothed_per_thousand,positive_rate,tests_per_case,tests_units,total_vaccinations,people_vaccinated,people_fully_vaccinated,total_boosters,new_vaccinations,new_vaccinations_smoothed,total_vaccinations_per_hundred,people_vaccinated_per_hundred,people_fully_vaccinated_per_hundred,total_boosters_per_hundred,new_vaccinations_smoothed_per_million,new_people_vaccinated_smoothed,new_people_vaccinated_smoothed_per_hundred,stringency_index,population_density,median_age,aged_65_older,aged_70_older,gdp_per_capita,extreme_poverty,cardiovasc_death_rate,diabetes_prevalence,female_smokers,male_smokers,handwashing_facilities,hospital_beds_per_thousand,life_expectancy,human_development_index,excess_mortality_cumulative_absolute,excess_mortality_cumulative,excess_mortality,excess_mortality_cumulative_per_million)	
FROM 'D:\TOPIC_RELATED VOCABULARY IELTS\Finland\aalto\ISM major\CAREER side projects+portfolio for DA+ dashboard\CovidVaccinations28122021.csv'
DELIMITER ','
CSV HEADER;

------

-- Which countries are incorporated in the report?
SELECT
	DISTINCT(de.location)
FROM
	CovidDeaths de
WHERE de.continent IS NOT NULL
ORDER BY 1 DESC;

-- Total cases vs Total deaths(What is the deaths percentage in countries of interest?)
SELECT
	de.location,
	de.date,
	de.total_cases,
	de.total_deaths,
	(CAST(de.total_deaths as NUMERIC)/de.total_cases)*100 as deathsPercentage
FROM
	CovidDeaths de
WHERE de.location='Finland' and de.continent IS NOT NULL
ORDER BY 1,2


-- Total cases vs Total population (What is the percentage of population infected by COVID in  specific countries of interest?)
SELECT
	de.location,
	de.date,
	de.total_cases,
	de.population,
	(CAST(de.total_cases as NUMERIC)/de.population)*100 as popInfectedPercentage
FROM
	CovidDeaths de
	E de.location='Vietnam' and de.continent IS NOT NULL
ORDER BY 1,2;

--Which country has the highest percentage of population infected by COVID?
	---- Approach 1
SELECT
	de.location,
	de.population,
	MAX((CAST(de.total_cases as NUMERIC)/de.population)*100) as popInfectedPercentage
FROM
	CovidDeaths de
WHERE de.continent IS NOT NULL
GROUP BY de.location, de.population
ORDER BY 1,2 DESC;
	---- Approach 2
SELECT
	de.location,
	MAX(de.population) as population,
	MAX(de.total_cases) as infectionCount,
	MAX((CAST(de.total_cases as NUMERIC)/de.population)*100) as popInfectedPercentage
FROM
	CovidDeaths de
WHERE de.continent IS NOT NULL	
GROUP BY de.location
ORDER BY 4 DESC;

--- Which country has the highest deaths percentage and number?
SELECT
	de.location,
	de.population,
	MAX(de.total_deaths) as deathsCount,
	MAX((CAST(de.total_deaths as NUMERIC)/de.population)*100) as popDeathsPercentage
FROM
	CovidDeaths de
WHERE de.continent IS NOT NULL	
GROUP BY de.location, de.population
ORDER BY 3 DESC;


-- Which continent has the highest deaths counts?
WITH cte_maxDeaths as(
	SELECT
		de.location,
		de.continent,
		MAX (de.total_deaths) as deathsCountPerCountry
	FROM 
		CovidDeaths de
	WHERE de.continent IS NOT NULL
	GROUP BY de.location, de.continent
	ORDER BY 2 DESC
)
SELECT 
	cm.continent,
	SUM(cm.deathsCountPerCountry) as deathsCountPerContinent
FROM 
	cte_maxDeaths cm
GROUP BY cm.continent
ORDER BY 2;

	-- GLOBAL NUMBERS 
-- What is the deaths rate per day across the world?
SELECT
	de.date,
	SUM(de.new_cases) as globalNumNewCases,
	SUM(de.new_deaths) as globalNumNewDeaths,
	(CAST(SUM(de.new_deaths) as NUMERIC)/ SUM(de.new_cases))*100 as deathsPercentage
FROM 
	CovidDeaths de
WHERE de.continent IS NOT NULL
GROUP BY de.date
ORDER BY 1 DESC;

-- What is the total amount of vaccinations across countries?
	-- approach 1 making use of OVER (PARTITION BY)
SELECT 
	de.continent,
	de.location,
	de.date,
	de.population,
	va.new_vaccinations,
	SUM(va.new_vaccinations) OVER (PARTITION BY de.location)
	
FROM 
	CovidDeaths de  JOIN CovidVaccinations va 
	ON de.location=va.location AND de.date=va.date
WHERE de.continent IS NOT NULL
ORDER BY 2,3;	


	--approach 2 making use of GROUP BY
SELECT 
	de.continent,
	de.location,
--	de.date,
	de.population,
	SUM(va.new_vaccinations) 
	
FROM 
	CovidDeaths de  JOIN CovidVaccinations va 
	ON de.location=va.location AND de.date=va.date
WHERE de.continent IS NOT NULL
GROUP BY de.location, de.continent, de.population
ORDER BY 2,3;

--- What is the rolling count of vaccination across countries? and How many percentage of people being vaccinated are there across countries?
	--approach 1
SELECT 
	de.continent,
	de.location,
	de.date,
	de.population,
	va.new_vaccinations,
	SUM(va.new_vaccinations) OVER (PARTITION BY de.location ORDER BY de.location, de.date) as rollingPeopleVaccinated, 
	(SUM(va.new_vaccinations) OVER (PARTITION BY de.location ORDER BY de.location, de.date)/ CAST(de.population as NUMERIC)) * 100 as VaccinatedPeoplePercentage
FROM 
	CovidDeaths de  JOIN CovidVaccinations va 
	ON de.location=va.location AND de.date=va.date
WHERE de.continent IS NOT NULL 
ORDER BY 2,3;	

	--approach 2 Call on CTE
WITH popVac  AS(
	SELECT 
	de.continent,
	de.location,
	de.date,
	de.population,
	va.new_vaccinations,
	SUM(va.new_vaccinations) OVER (PARTITION BY de.location ORDER BY de.location, de.date) as rollingPeopleVaccinated	
FROM 
	CovidDeaths de  JOIN CovidVaccinations va 
	ON de.location=va.location AND de.date=va.date
WHERE de.continent IS NOT NULL
ORDER BY 2,3
)
SELECT  
	*,
	(popVAc.rollingPeopleVaccinated/CAST (popVAc.population as NUMERIC))*100
FROM popVac

	--approach 3 Call on TEMP TABLE
DROP TABLE IF EXISTS popVac;
CREATE TEMP TABLE popVac
	(
	continent VARCHAR(50),	
	location VARCHAR(50),
	date DATE,
	population BIGINT,
	new_vaccinations BIGINT,
	rollingCountPeopleVaccinated BIGINT
	);
INSERT INTO popVac
SELECT
	de.continent,
	de.location,
	de.date,
	de.population,
	va.new_vaccinations,
	SUM(va.new_vaccinations) OVER (PARTITION BY de.location ORDER BY de.location, de.date) as rollingCountPeopleVaccinated
FROM 
	CovidDeaths de JOIN CovidVaccinations va
	ON de.location= va.location AND de.date=va.date
WHERE de.continent IS NOT NULL

SELECT 
	popVac.continent,
	popvac.location,
	popVac.new_vaccinations,
	rollingCountPeopleVaccinated,
	(popVac.rollingCountPeopleVaccinated/ CAST (popVac.population as NUMERIC))*100 as rollingPercentPeopleVaccinated
FROM 
	popVac;

