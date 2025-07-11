-- Data Cleaning

SELECT *
FROM layoffs
;

-- GOALS:
-- 1.) Remove Duplicates
-- 2.) Standardize the data (issues with spelling etc.)
-- 3.) Consider null / blank values (populate  if possible)
-- 4.) Remove unnecessary rows and columns

-- STAGE 1: DUPLICATING TABLES TO RETAIN RAW DATA 

CREATE TABLE layoffs_staging -- TO SEPARATE FROM RAW DATA 
LIKE layoffs;

Select *  -- BLANK TABLE
FROM layoffs_staging;

INSERT layoffs_staging -- INSERT ALL THE DATA FROM LAYOFFS TO LAYOFFS_STAGING
Select *
From layoffs;

-- STAGE 2: REMOVING DUBLICATES

-- using row number to partition on everything to determine duplicates
Select * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging; 

-- to check which has duplicates
WITH CTE_rownum as 
(
Select * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
Select *
FROM CTE_rownum
Where row_num > 1
;

-- to check the exact dupicates
Select *
From layoffs_staging
Where company = 'Yahoo';

-- THIS SYNTAX TO DELETE IS NOT APPLICABLE SO WE NEED TO CREATE A NEW TABLE
WITH CTE_rownum as 
(
Select * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
DELETE
FROM CTE_rownum
Where row_num > 1
;

-- CREATE TABLE
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select * 
From layoffs_staging2;

-- Insert data with row_num 
Insert INTO layoffs_staging2
Select * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
;

Select * 
From layoffs_staging2
Where row_num > 1;

-- DELETE COMPANIES WITH DUPLICATES
DELETE
From layoffs_staging2
Where row_num > 1;

-- CODE TO ENABLE SAFE UPDATES
SET SQL_SAFE_UPDATES = 0;

-- STAGE 3: STANDARDIZING DATA

-- a.) company column
SELECT company, TRIM(company)
From layoffs_staging2;

-- Update format for company
UPDATE layoffs_staging2
SET company = TRIM(company);

-- b.) industry column
SELECT *
From layoffs_staging2
WHERE industry like 'Crypto%';

-- UPDATE industry
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry like 'Crypto%';

SELECT DISTINCT industry
From layoffs_staging2;

-- c.) location

Select ddateistinct country
from layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
Where country = 'United States.';

-- d.) date

Select `date`, -- CINVERT STRINGS TO DATE
str_to_date(`date`, '%m/%d/%Y') as new_date
From layoffs_staging2;

Select length('new_date') -- to check incorrect date formats
From (
Select `date`,
str_to_date(`date`, '%m/%d/%Y') as new_date
From layoffs_staging2
) as Length_date
Where length('new_date') != 8;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y')
;

Select *
From layoffs_staging2;

-- to change the definition of the date from text to date

ALTER TABLE  layoffs_staging2
MODIFY COLUMN `date` DATE;

-- STAGE 4: NULL OR BLANK VALUES

-- to look for null values for both total and percentage laid off:
Select *
FROM layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off is NULL;

-- look for null values for industry
Select *
FROM layoffs_staging2
Where industry is null
or industry = ''
;

Select *
FROM layoffs_staging2
WHERe company = 'Airbnb';


Select *
FROM layoffs_staging2 as t1
Join layoffs_staging2 as t2  -- the two data tables were combined
	On t1.company = t2.company  -- to ensure same data to get
    And t1.location = t2.location -- to ensure same data to get
Where (t1. industry is NULL or t1.industry ='') -- for the lhs to be filtered to only get the blank values
And (t2.industry is not NULL AND t2.industry !='') -- for the rhs to be filtered to only get the value
;

-- to update everything
UPDATE layoffs_staging2 t1
Join layoffs_staging2 as t2
	On t1.company = t2.company
    And t1.location = t2.location
SET t1.industry = t2.industry
Where (t1. industry is NULL or t1.industry ='')
And (t2.industry is not NULL AND t2.industry !='')
;

Select *
FROM layoffs_staging2
WHERe company ='Bally%';

-- STAGE 5: REMOVE UNNECESSARY ROWS

Select *
FROM layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off is NULL;

-- to delete rows
DELETE
FROM layoffs_staging2
Where total_laid_off IS NULL
AND percentage_laid_off is NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;



