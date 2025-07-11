-- Group By
Select *
From employee_demographics;


Select gender, AVG(age), MAX(age), MIN(age), Count(age), Max(birth_date)
From employee_demographics
group by gender
;


-- Order by
Select *
From employee_demographics
Order by gender, age
;

Select *
From employee_demographics
Order by 5, 4
;

