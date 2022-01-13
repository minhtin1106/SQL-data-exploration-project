The project is to review my SQL proficiency. The data used is concerned with COVID-19 tracking from 15th February 2020 to 28th December 2021 across the globe. The data is drawn from: https://ourworldindata.org/covid-deaths

In this minor project, I practiced and showcased my skills in using SQL to draw data from database for exploration purpose. Aggregate functions, windows functions, CTE, VIEW, etc are displayed in the codes

Tables description:
There are two tables: both contain some common information such as the location(countries, continent), population 

+The first table is called CovidDeaths incorporating all information relevant to tracking of number of cases and deaths over time:  new cases, total cases, proportion of case in the population, new deaths, total deaths, etc

+One is called CovidVaccinations including all about the test and vaccinations information: new_tests, total_tests, total_tests_per_thousand, new_vaccinations total_vaccinations, etc



CREATE TABLE CovidDeaths(
	iso_code VARCHAR(50),
	continent VARCHAR(50),
	location VARCHAR(50),
	date DATE, 
	population BIGINT, 
	total_cases INT,
-- QUESTION how to deal with the Error out of range of integer https://stackoverflow.com/questions/24308239/postgresql-integer-out-of-range
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

-- QUESTION how to change datestyle in postgresql? https://stackoverflow.com/questions/13244460/how-to-change-datestyle-in-postgresql
SHOW datestyle;
SET datestyle TO "DMY";

**
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
