-- Having vs Where

Select gender, AVG(age)
From employee_demographics
Where AVG(age) > 40 -- wrong syntax
group by gender
;

Select gender, AVG(age)
From employee_demographics
group by gender
Having AVG(age) > 40 -- correct syntax
;

-- use of both 
Select occupation, AVG(salary)
From employee_salary
Where occupation Like '%manager'
Group by occupation
Having AVG(salary) >= 55000
;