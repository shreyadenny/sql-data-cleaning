/* ============================================================
   SQL DATA CLEANING PROJECT – LAYOFFS DATASET
   ============================================================
   OBJECTIVE:
   Clean raw layoffs data for analysis by:
   1. Removing duplicates
   2. Standardizing inconsistent values
   3. Handling null / blank values
   4. Removing unnecessary columns

   BEST PRACTICE:
   Keep original raw data untouched by working in staging tables.
   ============================================================ */


/* ============================================================
   SECTION 0: INITIAL DATA INSPECTION
   ============================================================ */

-- Preview original raw dataset
SELECT *
FROM layoffs;


/* ============================================================
   SECTION 1: CREATE STAGING TABLE
   ============================================================
   Purpose:
   Duplicate raw data so original dataset remains unchanged.
   ============================================================ */

-- Create first staging table with same structure as raw table
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Verify table creation
SELECT *
FROM layoffs_staging;

-- Copy all raw data into staging table
INSERT INTO layoffs_staging
SELECT *
FROM layoffs;


/* ============================================================
   SECTION 2: IDENTIFY DUPLICATES
   ============================================================
   Logic:
   ROW_NUMBER assigns:
   1 = first occurrence
   >1 = duplicate rows
   ============================================================ */

WITH duplicate_cte AS
(
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY company,
                            location,
                            industry,
                            total_laid_off,
                            percentage_laid_off,
                            `date`,
                            stage,
                            country,
                            funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)

-- View duplicate records only
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Example company check
SELECT *
FROM layoffs_staging
WHERE company = 'Casper';


/* ============================================================
   SECTION 3: REMOVE DUPLICATES
   ============================================================
   Purpose:
   Create second staging table including row_num helper column
   so duplicates can be deleted safely.
   ============================================================ */

CREATE TABLE layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT DEFAULT NULL,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT DEFAULT NULL,
    row_num INT
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

-- Verify structure
SELECT *
FROM layoffs_staging2;

-- Insert data with duplicate tracking number
INSERT INTO layoffs_staging2
SELECT *,
       ROW_NUMBER() OVER(
           PARTITION BY company,
                        location,
                        industry,
                        total_laid_off,
                        percentage_laid_off,
                        `date`,
                        stage,
                        country,
                        funds_raised_millions
       ) AS row_num
FROM layoffs_staging;

-- Review duplicate rows before deletion
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Disable safe update mode temporarily
SET SQL_SAFE_UPDATES = 0;

-- Delete duplicate rows
DELETE
FROM layoffs_staging2
WHERE row_num > 1;


/* ============================================================
   SECTION 4: STANDARDIZE DATA
   ============================================================
   Goal:
   Fix inconsistent formatting for analysis accuracy.
   ============================================================ */


/* ------------------------------
   4A. Standardize company names
   ------------------------------ */

-- Check for extra spaces
SELECT company,
       TRIM(company)
FROM layoffs_staging2;

-- Remove leading/trailing spaces
UPDATE layoffs_staging2
SET company = TRIM(company);


/* ------------------------------
   4B. Standardize industry names
   ------------------------------ */

-- Review unique industry values
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;

-- Check crypto-related variations
SELECT *
FROM layoffs_staging2
WHERE industry LIKE '%crypto%';

-- Convert all crypto variations to "Crypto"
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


/* ------------------------------
   4C. Standardize country names
   ------------------------------ */

-- Review country inconsistencies
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY country;

-- Check US formatting variations
SELECT country
FROM layoffs_staging2
WHERE country LIKE 'United States%';

-- Preview corrected values
SELECT DISTINCT country,
       TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY country;

-- Remove trailing periods
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


/* ------------------------------
   4D. Standardize date format
   ------------------------------
   Convert text date to SQL DATE type
   ------------------------------ */

-- Preview conversion
SELECT `date`,
       STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

-- Update date values
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Convert column data type
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


/* ============================================================
   SECTION 5: HANDLE NULL / BLANK VALUES
   ============================================================ */


/* ------------------------------
   5A. Identify rows missing layoff info
   ------------------------------ */

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;


/* ------------------------------
   5B. Identify missing industry values
   ------------------------------ */

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
   OR industry = '';

-- Example company check
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';


/* ------------------------------
   5C. Populate missing industry values
   ------------------------------
   Use matching company/location rows
   ------------------------------ */

-- Preview potential matches
SELECT t1.company,
       t1.location,
       t1.industry,
       t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
   AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;

-- Fill missing industries
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
   AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;

-- Validation example
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';


/* ------------------------------
   5D. Remove unusable rows
   ------------------------------
   Delete rows with no layoff metrics
   ------------------------------ */

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;


/* ============================================================
   SECTION 6: FINAL CLEANUP
   ============================================================
   Remove helper columns no longer needed
   ============================================================ */

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


/* ============================================================
   FINAL OUTPUT:
   layoffs_staging2 = Cleaned dataset ready for:
   - Exploratory Data Analysis (EDA)
   - Trend Analysis
   - Dashboarding
   - Business Insights
   ============================================================ */

-- Final cleaned data preview
SELECT *
FROM layoffs_staging2;
