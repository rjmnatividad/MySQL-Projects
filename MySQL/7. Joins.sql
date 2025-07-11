-- Joins

Select *
from employee_demographics
;
 
Select *
from employee_salary
; 

Select *
from employee_demographics As demo
INNER JOIN employee_salary As salary
	ON demo.employee_id = salary.employee_id
;
    
Select demo.employee_id, age, demo.first_name, demo.last_name, occupation
from employee_demographics As demo
INNER JOIN employee_salary As salary
	ON demo.employee_id = salary.employee_id
;

-- Outer Joins

Select *
from employee_demographics As demo
Right JOIN employee_salary As salary
	ON demo.employee_id = salary.employee_id
;

-- Self Join

Select emp1.employee_id as emp_santa, 
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa, 
emp2.employee_id as emp_receiver, 
emp2.first_name as first_name_receiver,
emp2.last_name as last_name_receiver
From employee_salary as emp1
Join employee_salary as emp2
    ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together

Select *
from employee_demographics As demo
INNER JOIN employee_salary As salary
	ON demo.employee_id = salary.employee_id
INNER JOIN parks_departments as pd
	ON salary.dept_id = pd.department_id
;

Select *
from parks_departments