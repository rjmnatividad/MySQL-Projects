-- Temporary Tables

-- 1st Option

CREATE TEMPORARY TABLE temp_table
(first_name varchar (50),
last_name varchar (50),
favorite_movie varchar (100)
);

Select *
From temp_table
;

INSERT INTO temp_table
Values('Reuben','Natividad','Da Vinci Code');

Select *
From temp_table
;

-- 2nd Option

Select *
FROM employee_salary;

CREATE Temporary Table  salary_over_50k
Select *
From employee_salary
Where salary >= 50000;

Select *,
ROW_NUMBER () OVER () as count
From salary_over_50k
;