CREATE TABLE lung_cancer_data (
    ID INT PRIMARY KEY,
    Country VARCHAR(255),
    Population_Size INT,
    Age INT,
    Gender VARCHAR(10),
    Smoker VARCHAR(3),
    Years_of_Smoking INT,
    Cigarettes_per_Day INT,
    Passive_Smoker VARCHAR(3),
    Family_History VARCHAR(3),
    Lung_Cancer_Diagnosis VARCHAR(3),
    Cancer_Stage VARCHAR(50),
    Survival_Years INT,
    Adenocarcinoma_Type VARCHAR(50),
    Air_Pollution_Exposure VARCHAR(10),
    Occupational_Exposure VARCHAR(3),
    Indoor_Pollution VARCHAR(3),
    Healthcare_Access VARCHAR(50),
    Early_Detection VARCHAR(3),
    Treatment_Type VARCHAR(50),
    Developed_or_Developing VARCHAR(50),
    Annual_Lung_Cancer_Deaths INT,
    Lung_Cancer_Prevalence_Rate FLOAT,
    Mortality_Rate FLOAT
);

Select * from lung_cancer_data;

-- Basic Level
-- 1. Retrieve all records for individuals diagnosed with lung cancer.
Select * from lung_cancer_data where lung_cancer_diagnosis = 'Yes';

-- 2. Count the number of smokers and non-smokers.
Select smoker,Count(*) from lung_cancer_data
Group by smoker;

-- 3. List all unique cancer stages present in the dataset.
Select DISTINCT cancer_stage from lung_cancer_data;

-- 4. Retrieve the average number of cigarettes smoked per day by smokers.
Select AVG(cigarettes_per_day) from lung_cancer_data;

-- 5. Count the number of people exposed to high air pollution.
Select COUNT(air_pollution_exposure) from lung_cancer_data 
where air_pollution_exposure = 'High';

-- 6. Find the top 5 countries with the highest lung cancer deaths.
Select Distinct(Country),annual_lung_cancer_deaths from lung_cancer_data 
ORDER BY annual_lung_cancer_deaths desc
LIMIT 5;

-- 7. Count the number of people diagnosed with lung cancer by gender.
Select gender,COUNT(lung_cancer_diagnosis) from lung_cancer_data
where lung_cancer_diagnosis = 'Yes'
GROUP BY gender;

-- 8. Retrieve records of individuals older than 60 who are diagnosed with lung cancer.
Select * from lung_cancer_data
where lung_cancer_diagnosis = 'Yes' and age > 60;


-- Intermediate Level
-- 1. Find the percentage of smokers who developed lung cancer.
SELECT 
	((Select COUNT(*) from lung_cancer_data where smoker = 'Yes' AND lung_cancer_diagnosis = 'Yes' )*100.0/
	 (Select COUNT(*) from lung_cancer_data where smoker = 'Yes'));

-- 2. Calculate the average survival years based on cancer stages.
Select cancer_stage,AVG(survival_years) from lung_cancer_data
GROUP BY cancer_stage;

-- 3. Count the number of lung cancer patients based on passive smoking.
Select passive_smoker,COUNT(lung_cancer_diagnosis)
from lung_cancer_data
where lung_cancer_diagnosis = 'Yes'
GROUP BY passive_smoker;

-- 4. Find the country with the highest lung cancer prevalence rate.
Select country,lung_cancer_prevalence_rate 
from lung_cancer_data 
ORDER BY lung_cancer_prevalence_rate desc
LIMIT 1;

-- 5. Identify the smoking years' impact on lung cancer.
Select AVG(Years_of_smoking) as avg_smoking_years ,lung_cancer_diagnosis
from lung_cancer_data
GROUP BY lung_cancer_diagnosis;

-- 6. Determine the mortality rate for patients with and without early detection.
Select early_detection,AVG(mortality_rate) as avg_mortality_rate
from lung_cancer_data
GROUP BY early_detection;

-- 7. Group the lung cancer prevalence rate by developed vs. developing countries.
Select developed_or_developing,AVG(lung_cancer_prevalence_rate) 
from lung_cancer_data
GROUP BY developed_or_developing;


-- Advanced Level
-- 1. Identify the correlation between lung cancer prevalence and air pollution levels.
SELECT air_pollution_exposure,AVG(lung_cancer_prevalence_rate) as lung_cancer_prevalence_rate
from lung_cancer_data 
GROUP BY air_pollution_exposure;
	
-- 2. Find the average age of lung cancer patients for each country.
Select country,AVG(age) as avg_age_patients
from lung_cancer_data
where lung_cancer_diagnosis = 'Yes'
GROUP BY country;

-- 3. Calculate the risk factor of lung cancer by smoker status, passive smoking, and family history.
Select smoker,passive_smoker,family_history,
	COUNT(CASE when lung_cancer_diagnosis = 'Yes' then 1 end) * 100.0/ COUNT(*) as lung_cancer_risk_percentage
from lung_cancer_data 
GROUP BY Smoker,Passive_Smoker, Family_History
ORDER BY lung_cancer_risk_percentage DESC;

-- 4. Rank countries based on their mortality rate.
Select country,mortality_rate,
	RANK() OVER(Order by mortality_rate desc) as mortality_rank
from lung_cancer_data
GROUP BY country,mortality_rate
ORDER BY mortality_rank;

-- 5. Determine if treatment type has a significant impact on survival years.
Select treatment_type,COUNT(*), AVG(survival_years) as avg_survival_years
from lung_cancer_data
GROUP BY treatment_type
ORDER BY avg_survival_years DESC;

-- 6. Compare lung cancer prevalence in men vs. women across countries.
Select country,gender,AVG(lung_cancer_prevalence_rate) as Avg_lung_cancer_prevalence_rate
from lung_cancer_data 
GROUP BY country,gender;

-- 7. Find how occupational exposure, smoking, and air pollution collectively impact lung cancer rates.
Select occupational_exposure,smoker,air_pollution_exposure,
	COUNT(CASE WHEN lung_cancer_diagnosis = 'Yes' THEN 1 end) as lung_cancer_rates
from lung_cancer_data 
GROUP BY occupational_exposure,smoker,air_pollution_exposure
ORDER BY lung_cancer_rates DESC;

-- 8. Analyze the impact of early detection on survival years.
Select early_detection,AVG(survival_years) AS avg_survival_years
from lung_cancer_data
GROUP BY early_detection
ORDER BY avg_survival_years DESC ;

















	



