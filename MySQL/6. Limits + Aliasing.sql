-- Limit

Select *
From employee_demographics
Order by  age Desc
Limit 3
;

-- Limit with additional parameter

Select *
From employee_demographics
Order by  age Desc
Limit 0, 3
;

-- Aliasing

Select gender, AvG(age) as avg_age
From employee_demographics
Group by gender
Having avg_age > 40
;