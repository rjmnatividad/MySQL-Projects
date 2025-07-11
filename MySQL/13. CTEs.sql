-- CTEs

With CTE_Example AS
(
Select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
From employee_demographics as dem
Join employee_salary as sal
	On dem.employee_id = sal.employee_id
Group by gender
)
Select avg(avg_sal)
From CTE_Example
;

-- Same output but using subquery

Select avg(avg_sal) as avg_avg_sal
From (
Select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
From employee_demographics as dem
Join employee_salary as sal
	On dem.employee_id = sal.employee_id
Group by gender
) as example_subquery
;

-- MULTIPLE CTEs

With CTE_Example AS
(
Select employee_id, gender, birth_date
From employee_demographics as dem
Where birth_date > '1985-01-01'
),
CTE_Example2 AS
(
Select employee_id, salary
From employee_salary
Where salary > 50000
)
Select *
From CTE_Example
Join CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;

-- (Declaration)

With CTE_Example (Gender, Avg_sal, Max_sal, Min_sal, Count_sal) AS
(
Select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
From employee_demographics as dem
Join employee_salary as sal
	On dem.employee_id = sal.employee_id
Group by gender
)
Select *
From CTE_Example
;

