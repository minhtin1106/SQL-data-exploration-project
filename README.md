# COVID 19 data- Data exploration with PostgreSQL

The project is to brush up on my SQL proficiency. The data used is concerned with COVID-19 tracking from 15th February 2020 to 28th December 2021 across the globe. The data is drawn from: https://ourworldindata.org/covid-deaths

In this minor project, I practiced and showcased my skills in using PostgreSQL to draw data from database for exploration purpose. Aggregate functions, windows functions, CTE, VIEW, etc are displayed in the codes

Tables description:
There are two tables: both contain some common information such as the location(countries, continent)

+The first table is called CovidDeaths incorporating all information relevant to the population and records of number of cases and deaths over time:  new cases, total cases, proportion of case in the population, new deaths, total deaths, etc 

![Examples rows of covidDeaths table](images/coviddeaths%20data%20tables%20examples.png)


+One is called CovidVaccinations including all about the test and vaccinations information: new_tests, total_tests, total_tests_per_thousand, new_vaccinations total_vaccinations, etc

![Examples rows of covidVaccinations table](images/covidvaccinations%20tables%20examples.png)


After having an overview of the dataset, let's dig deeper into the coding section
