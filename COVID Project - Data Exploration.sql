SELECT * 
FROM [PortfolioProject]..CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 3,4

SELECT * 
FROM [PortfolioProject ]..CovidVaccinations
WHERE continent IS NOT NULL 
ORDER BY 3,4

SELECT * 
FROM [PortfolioProject]..CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 3,4

--SELECT DATE 

SELECT location, date, total_cases, new_cases,total_deaths, population
FROM [PortfolioProject ]..CovidDeaths
ORDER BY 1,2 

--TOTAL CASES VS TOTAL DEATHS 
-- Shows likelihood of dying if you contract covid (WORLD)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [PortfolioProject ]..CovidDeaths
ORDER BY 1,2 

--Total Cases VS Total Deaths India 
--Shows the likelihood of dying if you contract COVID in the India 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [PortfolioProject ]..CovidDeaths
WHERE location like 'India'
ORDER BY 1,2 

--Total Cases VS Total Deaths United States 
--Shows the likelihood of dying if you contract COVID in the United States 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM [PortfolioProject ]..CovidDeaths
WHere location like '%states%'
ORDER BY 1,2 

--Total Cases VS Population in US 
--Shows what percentage of population got COVID in UNITED STATES 
SELECT location, date, Population, total_cases, (total_cases/population)*100 as PresentPopulationInfected
FROM [PortfolioProject ]..CovidDeaths
WHere location like '%states%'
ORDER BY 1,2

--Total Cases VS Population in INDIA
--Shows what percentage of population got COVID in INDIA 
SELECT location, date, Population, total_cases, (total_cases/population)*100 as PresentPopulationInfected
FROM [PortfolioProject ]..CovidDeaths
WHere location like 'India'
ORDER BY 1,2

--Looking at Total Cases VS Population in WORLD
--Shows what percentage of population got COVID in WORLD
SELECT location, date, Population, total_cases, (total_cases/population)*100 as PresentPopulationInfected 
FROM [PortfolioProject ]..CovidDeaths
ORDER BY 1,2

--Countries with Highest Infection rate compared to Population 
SELECT location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PresentPopulationInfected
FROM [PortfolioProject ]..CovidDeaths
GROUP BY location, population
ORDER BY PresentPopulationInfected DESC 


--Countries with Highest Death Count per Population 
--CAST it into int so that it could be read as numeric 
SELECT location, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [PortfolioProject ]..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY TotalDeathCount DESC 

--Breaking Things down by Continent 
--Showing continents with the highest death count per population
SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [PortfolioProject ]..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC 

--WORLD NUMBERS 
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [PortfolioProject ]..CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1,2 

--WORLD NUMBERS with World Population //
SELECT SUM(population) as Total_population, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [PortfolioProject ]..CovidDeaths
WHERE continent IS NOT NULL 

--Total Population VS Vaccinations 
--Shows Percentage of population that has received at least one Covid Vaccine 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated 
FROM [PortfolioProject ]..CovidDeaths dea 
JOIN [PortfolioProject ]..CovidVaccinations vac 
		On dea.location = vac.location 
		and dea.date = vac.date 
WHERE dea.continent IS NOT NULL 
ORDER BY 2,3 

