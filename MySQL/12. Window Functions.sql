-- Windows Function

-- this is group by not windows function yet
Select gender, avg(salary) as avg_salary
From employee_demographics as dem
Join employee_salary as sal
	On dem.employee_id = sal.employee_id
Group by gender
    ;
    
-- window function syntax

Select dem.first_name, dem.last_name, gender, salary, avg(salary) over (partition by gender) as avg_genderbased_salary
From employee_demographics as dem
Join employee_salary as sal
	On dem.employee_id = sal.employee_id
;

-- ROLLING TOTAL / CUMULATIVE SUM
SELECT dem.employee_id, dem.first_name, dem.last_name, salary, gender,
SUM(salary) OVER (PARTITION BY gender ORDER BY dem.employee_id) as running_sum_per_gender
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

-- MORE EXAMPLES

SELECT dem.employee_id, dem.first_name, dem.last_name, salary, gender,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) as number_rows,  -- Row Number
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as rank_rows,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as dense_rank_rows
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;
    


