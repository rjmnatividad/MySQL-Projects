-- Subqueries
-- A.) Used in where clause

Select *
From employee_demographics
Where employee_id IN
				(Select employee_id
                 From employee_salary
                 Where dept_id = 1)
;

Select *
from employee_salary;

-- B.) Used in Case Statements

Select first_name, salary,
(Select avg(salary)
from employee_salary) as avg_salary 
from employee_salary;


-- C.) From Statement
-- Reference Table
Select gender, avg(age), Max(age), min(age), count(age)
From employee_demographics
Group by gender
;

Select AVG(`avg(age)`), AVG(`Max(age)`), AVG(`min(age)`), AVG(`count(age)`)
From 
(Select gender, avg(age), Max(age), min(age), count(age)
From employee_demographics
Group by gender) as agg_table
;

-- OR

Select AVG(avg_age), AVG(max_age), AVG(min_age), AVG(count_age)
From 
(Select gender, avg(age) as avg_age, Max(age) as max_age, min(age) as min_age, count(age) as count_age
From employee_demographics
Group by gender) as agg_table
;