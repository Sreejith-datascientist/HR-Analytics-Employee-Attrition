-- =============================================================================
-- HR ATTRITION RISK ANALYTICS 
-- =============================================================================

-- CSV File imported through Import Flat file feature

SELECT * FROM HR_employee_attrition;

ALTER TABLE HR_employee_attrition
ADD CONSTRAINT PK_HR_employee_attrition PRIMARY KEY (EmployeeNumber);

ALTER TABLE HR_employee_attrition
DROP COLUMN EmployeeCount, Over18, StandardHours; -- Droped due to same input for all rows (EmployeeCount - 1, Over18 - Y, StandardHours - 80) 

-- 1. Overall Attrition rate & Baseline Summary 

SELECT 
	COUNT(*) AS Total_Employees,
	SUM(CASE WHEN Attrition = 'Yes'THEN 1 ELSE 0 END) AS Total_Leaving,
	SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Total_Active,
	ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes'THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT),2) AS Attrition_Rate_pct,
	ROUND(AVG(Age),1) as Average_Age,
	ROUND(AVG(MonthlyIncome),2) AS Avg_Monthly_Income,
	ROUND(AVG(CAST(YearsAtCompany AS FLOAT)),1) AS Avg_Tenure_Yrs
FROM HR_employee_attrition;
	
-- 2. Attrition Rate by Department & Job Role

SELECT 
    Department,
    JobRole AS Job_Role,
    COUNT(*) AS Employee_Count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY Department, JobRole
ORDER BY Attrition_Rate_Pct DESC;

-- 3. Impact of Overtime Across Departments

SELECT 
    Department,
    OverTime as Over_Time,
    COUNT(*) AS Employee_Count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY Department, OverTime
ORDER BY Department, OverTime;

-- 4. Income Comparison: Leavers vs. Stayers by Job Level

SELECT 
    JobLevel AS Job_Level,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END), 2) AS Avg_Income_Leavers,
    ROUND(AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END), 2) AS Avg_Income_Stayers,
    ROUND(AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END) - 
          AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END), 2) AS Income_Gap,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY JobLevel
ORDER BY JobLevel;

-- 5. Stock Option Level vs. Attrition Rate

SELECT 
    StockOptionLevel AS Stock_Option,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY StockOptionLevel
ORDER BY StockOptionLevel;

-- 6. Attrition by Tenure Bands (1-3 Year Risk Window)

SELECT 
    CASE 
        WHEN YearsAtCompany < 1 THEN 'Less than 1 Year'
        WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1 - 3 Years'
        WHEN YearsAtCompany BETWEEN 4 AND 7 THEN '4 - 7 Years'
        WHEN YearsAtCompany BETWEEN 8 AND 10 THEN '8 - 10 Years'
        ELSE '10+ Years'
    END AS Tenure_Bucket,
    COUNT(*) AS Employee_Count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY 
    CASE 
        WHEN YearsAtCompany < 1 THEN 'Less than 1 Year'
        WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1 - 3 Years'
        WHEN YearsAtCompany BETWEEN 4 AND 7 THEN '4 - 7 Years'
        WHEN YearsAtCompany BETWEEN 8 AND 10 THEN '8 - 10 Years'
        ELSE '10+ Years'
    END
ORDER BY Attrition_Rate_Pct DESC;

-- 7. Years Since Last Promotion Impact

SELECT 
    YearsSinceLastPromotion AS Years_Since_Last_Promotion,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;

-- 8. Low Work-Life Balance and Job Satisfaction Cross-Analysis

SELECT 
    WorkLifeBalance AS Work_Life_Balance,
    JobSatisfaction AS Job_Satisfaction,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
    ROUND(CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT), 2) AS Attrition_Rate_Pct
FROM hr_employee_attrition
GROUP BY WorkLifeBalance, JobSatisfaction
ORDER BY Attrition_Rate_Pct DESC;


-- 9. Environment Satisfaction based on Job Role

SELECT 
    JobRole AS Job_Role,
    ROUND(AVG(CASE WHEN EnvironmentSatisfaction = 1 AND Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS Rating_1_Attrition_pct,
    ROUND(AVG(CASE WHEN EnvironmentSatisfaction = 2 AND Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS Rating_2_Attrition_pct,
    ROUND(AVG(CASE WHEN EnvironmentSatisfaction = 3 AND Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS Rating_3_Attrition_pct,
    ROUND(AVG(CASE WHEN EnvironmentSatisfaction = 4 AND Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS Rating_4_Attrition_pct,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS Total_Jobrole_Attrition_pct
FROM hr_employee_attrition
GROUP BY JobRole
ORDER BY Total_Jobrole_Attrition_pct DESC;



