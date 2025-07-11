Select *
From employee_salary
Where first_name = 'Leslie'
;

Select *
From employee_salary
Where salary < 50000
;

Select *
From employee_demographics
Where birth_date > '1985-01-01'
;

Select *
From employee_demographics
Where (first_name = 'leslie' and age = 44) or age > 55
;

-- LIKE Statement
Select *
From employee_demographics
Where birth_date LIKE '1989%'
;

