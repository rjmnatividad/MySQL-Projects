-- Exploratory Data Analysis

Select *
From layoffs_staging2;

Select MAX(total_laid_off), MAX(percentage_laid_off)
From layoffs_staging2;

Select *
From layoffs_staging2
Where percentage_laid_off =1
Order by funds_raised_millions DESC;

-- sum of layoffs per company
Select company, sum(total_laid_off)
From layoffs_staging2
Group by company
Order by sum(total_laid_off) DESC;

-- sum of total layoffs

Select sum(total_laid_off)
From layoffs_staging2;

-- date range

Select min(`date`), max(`date`)
From layoffs_staging2;

-- sum of layoffs per industry
Select industry, sum(total_laid_off)
From layoffs_staging2
Group by industry
Order by sum(total_laid_off) DESC;

-- sum of layoffs per country
Select country, sum(total_laid_off)
From layoffs_staging2
Group by country
Order by sum(total_laid_off) DESC;

-- sum of layoffs per year
Select YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by YEAR(`date`)
Order by YEAR(`date`) DESC;

-- sum of layoffs per stage
Select stage, sum(total_laid_off)
From layoffs_staging2
Group by stage
Order by sum(total_laid_off) DESC;

-- sum of layoffs per month
Select Substring(`date`, 1, 7) as `Month`, sum(total_laid_off) 
From layoffs_staging2
Where Substring(`date`, 1, 7) IS NOT NULL
Group by `Month`
Order by `Month`;

-- progression of layoffs per month

WITH Rolling_Total As
(
Select Substring(`date`, 1, 7) as `Month`, sum(total_laid_off)  as total_layoffs_monthly
From layoffs_staging2
Where Substring(`date`, 1, 7) IS NOT NULL
Group by `Month`
Order by `Month`
) 
Select `Month`, total_layoffs_monthly, sum(total_layoffs_monthly) over(order by `Month`) as Cumulative_Layoffs
From Rolling_Total;

-- sum of layoffs per company (this code aims to group the data per company and per year and ranked base on the sum of their lay offs
Select company, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by company, YEAR(`date`)
Order by 3 DESC
;

-- this code aims to rank the companies per year to determine which are the highest contributor to layoffs (limited to the first 5 companies per year)
WITH company_year (company, years, total_laid_offs) As
(
Select company, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by company, YEAR(`date`)
), Company_Year_Rank As
(
Select *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_offs DESC) as ranking
From company_year
WHERE total_laid_offs and years is not null
ORDER BY years ASC
)
Select *
From Company_Year_Rank
Where ranking <= 5;

-- this code aims to rank the industry per year to determine which are the highest contributor to layoffs (limited to the first 5 companies per year)
WITH industry_year (industry, years, total_laid_offs) As
(
Select industry, YEAR(`date`), sum(total_laid_off)
From layoffs_staging2
Group by industry, YEAR(`date`)
), Industry_Year_Rank As
(
Select *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_offs DESC) as ranking
From industry_year
WHERE total_laid_offs and years is not null
ORDER BY years ASC
)
Select *
From Industry_Year_Rank
Where ranking <= 5;





