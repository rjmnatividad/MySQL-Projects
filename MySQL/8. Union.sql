-- Union

Select first_name, last_name
From employee_demographics
Union Distinct
Select first_name, last_name
From employee_salary;

Select first_name, last_name
From employee_demographics
Union All
Select first_name, last_name
From employee_salary;


Select first_name, last_name, 'Old Lady' as Label
From employee_demographics
Where age > 40 and gender = 'Female'
Union
Select first_name, last_name, 'Old Man' as Label
From employee_demographics
Where age > 40 and gender = 'Male'
Union
Select first_name, Last_name, 'Expensive' as Label
From employee_salary
Where salary > 70000
order by first_name, last_name
;

