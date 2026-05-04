# SQL Data Cleaning & Exploratory Data Analysis Project – Global Layoffs Dataset

## Project Overview
This project focuses on transforming a raw global layoffs dataset into a clean, structured, and analysis-ready database using SQL, followed by exploratory data analysis (EDA) to uncover meaningful business insights.

The project was divided into two major phases:

## Phase 1: Data Cleaning
The raw dataset was cleaned and standardized by handling:
- Duplicate records
- Null / blank values
- Inconsistent formatting
- Text standardization issues
- Date formatting issues
- Unnecessary columns

## Phase 2: Exploratory Data Analysis (EDA)
After cleaning, SQL was used to analyze:
- Largest layoffs by company
- Most affected industries
- Countries with highest layoffs
- Year-over-year layoff trends
- Monthly layoff progression
- Startup stage risk
- Full company shutdowns
- Top layoff leaders by year

This project demonstrates practical SQL capabilities used in:
- Data Analytics
- Business Intelligence
- Data Cleaning
- Trend Analysis
- KPI Discovery
- Dashboard Preparation

---

# Dataset
The dataset contains global company layoff information, including:

- Company Name  
- Location  
- Industry  
- Total Employees Laid Off  
- Percentage of Workforce Laid Off  
- Date of Layoff  
- Company Stage (Seed, Series A, Post-IPO, etc.)  
- Country  
- Funds Raised (Millions USD)  

---

# Project Objectives

## Data Cleaning Goals:
- Create staging tables to preserve raw data integrity
- Identify and remove duplicate rows using `ROW_NUMBER()`
- Standardize inconsistent company, industry, and country values
- Convert raw text dates into SQL `DATE` format
- Handle null and blank values strategically
- Populate missing industry values where possible
- Remove unusable rows
- Drop unnecessary helper columns

---

## Exploratory Data Analysis Goals:
- Determine which company laid off the most employees
- Identify the industries most affected by layoffs
- Analyze which countries were hit hardest
- Discover peak layoff years
- Evaluate startup stages with highest layoff risk
- Identify companies with 100% workforce layoffs
- Track layoffs month-over-month
- Calculate rolling layoff totals
- Rank top 5 layoff-heavy companies each year

---

# SQL Skills & Concepts Used

## Core SQL:
- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `UPDATE`
- `DELETE`
- `ALTER TABLE`
- `CASE`

## Intermediate SQL:
- `CTEs (Common Table Expressions)`
- `ROW_NUMBER()`
- `DENSE_RANK()`
- `WINDOW FUNCTIONS`
- `PARTITION BY`
- `JOIN`
- `AGGREGATE FUNCTIONS`

## Data Cleaning Functions:
- `TRIM()`
- `STR_TO_DATE()`
- `SUBSTRING()`
- `NULL Handling`

---

# Project Workflow

## Step 1: Raw Data Inspection
Initial review of raw layoffs dataset.

## Step 2: Staging Table Creation
Protected source data by duplicating into staging tables.

## Step 3: Duplicate Detection & Removal
Used window functions to identify and safely remove duplicate records.

## Step 4: Standardization
Normalized:
- Company names
- Industry labels
- Country names
- Dates

## Step 5: Null Handling
Filled missing values where possible and removed unusable rows.

## Step 6: Exploratory Analysis
Generated business insights across:
- Companies
- Industries
- Countries
- Time
- Funding
- Business stage

---

# Key Business Questions Answered

- Which company laid off the most employees?
- Which industries experienced the largest layoffs?
- Which countries were most impacted?
- Which year had the highest layoffs?
- Which startup stages were riskiest?
- Which companies fully collapsed?
- How did layoffs trend over time?
- Who were the biggest layoff contributors each year?

---

# Business Value
This project reflects how analysts clean and analyze operational datasets before dashboarding or decision-making.

## Why this matters:
Poor data quality can lead to:
- Misleading reports
- Incorrect trend analysis
- Duplicate insights
- Faulty dashboards
- Poor business decisions

By cleaning and analyzing the dataset, this project simulates real-world analyst responsibilities.

---

# Potential Next Steps
This cleaned dataset can now be used for:

## Visualization:
- Tableau Dashboard
- Power BI Dashboard

## Advanced Analysis:
- Funding vs Layoffs correlation
- Industry recession patterns
- Geographic heatmaps
- Monthly trend forecasting
- Economic downturn storytelling

---

# Tools Used
- MySQL
- SQL Window Functions
- Data Cleaning Techniques
- Exploratory Data Analysis

---

# Portfolio Skills Demonstrated

## Technical:
- SQL Data Cleaning
- SQL Analytics
- Window Functions
- Data Transformation
- Trend Analysis

## Analytical:
- Business Question Framing
- KPI Analysis
- Pattern Recognition
- Insight Generation

## Professional:
- Data Quality Assurance
- Structured Problem Solving
- Recruiter-Ready Project Documentation

---

# Final Outcome
A fully cleaned and analysis-ready layoffs dataset capable of supporting:

### Raw Data → Clean Data → SQL Analysis → Business Insights

---

# Author Note
This project was completed as part of SQL skill-building and portfolio development to strengthen practical data analytics capabilities and simulate real-world analyst workflows.

---
