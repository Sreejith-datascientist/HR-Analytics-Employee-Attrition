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
![Executive Overview](<img width="869" height="487" alt="Overview" src="https://github.com/user-attachments/assets/46d0d967-47e6-4a8c-b4cd-089805759233" />)

### Page 2: Retention & Risk Drivers
Features an Environment Satisfaction matrix heatmap by job role alongside tenure and monthly income scatter plots.
![Retention Drivers](<img width="840" height="483" alt="Retention   Risk Drivers" src="https://github.com/user-attachments/assets/072bcd3f-6e61-4858-998e-bfac1580067c" />)

### Page 3: Actionable Risk Tracker
Lists active high-risk employees ranked by their calculated Flight Risk Score for HR retention interventions.
![Risk Tracker](<img width="862" height="479" alt="Risk Tracker" src="https://github.com/user-attachments/assets/d42a4e29-312f-4581-a1e4-e8860fa92254" />)

---

## End-to-End Analytics Architecture

1. **Data Preprocessing & Risk Scoring (`[python/hr_data_cleaning.py](http://localhost:8888/files/HR_Attrition_Prediction_Model.ipynb?_xsrf=2%7Cc26da514%7C3137c7f7ec393120662ecc4acf1e7985%7C1790949372)`):**
   - Cleaned missing values.
   - Built a weighted rule-based `RiskScore` algorithm combining overtime, satisfaction, promotion lag, and early tenure.
   - Predicted Top 10 drivers of Attrition based on Risk Score. (<img width="1000" height="500" alt="feature_importance" src="https://github.com/user-attachments/assets/338a7276-ca3c-4b8b-a552-c4569a12a0ae" />) 
2. **Exploratory Data Mining (`F:\Sreejith\Project\HR_Attrition_sql.sql`):**
   - Utilized Conditional Aggregations and Exploratory SQL Queries.
3. **Interactive BI Modeling (`F:\Sreejith\Project\HR_attrition_PBI.pbix`):**
   - Generated custom `Tenure` Column to plot attrition across Years.
   - Implemented dynamic DAX measures, percentage matrix formatting, dynamic drop-down slicers, and clear visual state management.

---
## How to Run This Project

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Sreejith-datascientist/HR-Analytics-Employee-Attrition.git
   cd HR-Analytics-Employee-Attrition
