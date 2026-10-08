# HR-Analytics-Employee-Attrition

An end-to-end data analytics project combining **Python (ETL)**, **SQL (Data Mining)**, and **Power BI (Executive Dashboards)** to diagnose employee turnover, measure financial exposure, and identify high-risk active employees.

---

## Business Problem & Key Insights

- **Overall Turnover:** The organization exhibits a **16.12% historical attrition rate** across 1,470 employees.
- **High Turnover Window:** Employees with **<1 year of tenure** experience the highest attrition at **36.36%**, tapering down significantly past year 3.
- **Overtime Driver:** Employees working overtime experience a **53.59% rate of overall turnover**.
- **Department Exposure:** Sales leads turnover at **20.63%**, closely followed by Human Resources (**19.05%**).
- **Financial Risk:** Identified **18 active high-risk employees**, representing an estimated **$718.87K in replacement financial exposure**.

---

## Interactive Dashboard Overview

### Page 1: Executive Overview
Provides strategic high-level KPIs, department attrition rankings, overtime impact, and tenure-banded attrition curves.
![Executive Overview](https://raw.githubusercontent.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition/main/ScreenShot/Overview.png)

### Page 2: Retention & Risk Drivers
Features an Environment Satisfaction matrix heatmap by job role alongside tenure and monthly income scatter plots.
![Retention Drivers](https://raw.githubusercontent.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition/main/ScreenShot/Retention_&_Risk_Drivers.png)

### Page 3: Actionable Risk Tracker
Lists active high-risk employees ranked by their calculated Flight Risk Score for HR retention interventions.
![Risk Tracker](https://raw.githubusercontent.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition/main/ScreenShot/Risk_Tracker.png)

---

## End-to-End Analytics Architecture

1. **Data Preprocessing & Risk Scoring (https://github.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition/blob/main/python/HR_Attrition_Prediction_Model.py):**
   - Cleaned missing values.
   - Built a weighted rule-based `RiskScore` algorithm combining overtime, satisfaction, promotion lag, and early tenure.
   - Predicted Top 10 drivers of Attrition based on Risk Score. <img width="1000" height="500" alt="feature_importance" src="https://github.com/user-attachments/assets/338a7276-ca3c-4b8b-a552-c4569a12a0ae" />
2. **Exploratory Data Mining (https://github.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition/blob/main/SQL/HR_Attrition_sql.sql):**
   - Utilized Conditional Aggregations and Exploratory SQL Queries.
3. **Interactive BI Modeling ((https://github.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition/blob/main/Power_Bi/HR_attrition_PBI.pbix):**
   - Generated custom `Tenure` Column to plot attrition across Years.
   - Implemented dynamic DAX measures, percentage matrix formatting, dynamic drop-down slicers, and clear visual state management.

---
## How to Run This Project

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition.git
   cd HR-Analytics-Employee-Attrition
