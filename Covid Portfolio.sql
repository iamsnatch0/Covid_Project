-- Here is my Covid report to understand how many people have died or vaccinated in the United Kingdom
 
use covid_report;
-- Report case_by_date is from  28/02/20 till 27/11/21
Select * From cases_by_date;

-- Select Data that we are going to be using
Select areatype, areaname, areacode, dateyear, newcasesbypublishdate 
From cases_by_date
Order by newcasesbypublishdate ASC;


-- Select SUMData of new cases  from  28/02/20 till 27/11/21 divided into nations
Select  areaname, SUM(newcasesbypublishdate) AS Total_Cases 
From cases_by_date
Group by areaname
Order by newcasesbypublishdate ASC;

-- Distinct statement of the areaname and areacode
SELECT DISTINCT
    Areaname, areacode
FROM
    cases_by_date;

-- Distinct Concat statement of the areaname and areacode
Select distinct concat(Areaname, '     ' , areacode) as AreanameCode
From cases_by_date;

Commit;
-- Checking the cases per a specify date
Select  Areaname, Dateyear, newcasesbypublishdate as Cases_per_country
From cases_by_date
Where dateyear = '27/11/2021';

-- DailyHighest Case 
Select Areatype, Areaname, Areacode, MAX(newcasesbypublishdate) as Daily_Highest_Case
From cases_by_date
Group by Areaname;


select * from deaths_within_28_days_of_positive_test_by_date_reported;

-- Highest Death by Country from 20/03/2020 till 27/11/2021

Select areaname, SUM(newdeaths) as HighestDeath
From deaths_within_28_days_of_positive_test_by_date_reported
Group by areaname;

-- less than 20 people dead 
Select areaname, dateyear,  newdeaths 
From deaths_within_28_days_of_positive_test_by_date_reported
where newdeaths <= 20;


-- View Vaccination report

select * from vaccinations_report;

-- Looking at Daily Total Vaccination vs New Vaccinated first Dose
Select AreaName, Dailytotalvaccinationgiven as Daily_Total_Vaccination, (NewPeopleVaccinatedFirstDose/Dailytotalvaccinationgiven)*100  as FirstDose_Percentage
From vaccinations_report
Order by 1,2;

-- Looking at Daily Total Vaccination vs New Vaccinated first Dose WITH A LIKE STATEMENT FOR WALES
Select AreaName,Dateyear,  Dailytotalvaccinationgiven as Daily_Total_Vaccination, (NewPeopleVaccinatedFirstDose/Dailytotalvaccinationgiven)*100  as FirstDose_Percentage
From vaccinations_report
Where AreaName like '%Wales%'
Order by 1,2;


-- Join table Death and vaccination 
Select dea.areaname, dea.dateyear, dea.newdeaths, vac.dailytotalvaccinationgiven
From deaths_within_28_days_of_positive_test_by_date_reported dea
Join  vaccinations_report vac
On dea.areaname = vac.areaname
and dea.dateyear = vac.dateyear
order by 1,2,3;



