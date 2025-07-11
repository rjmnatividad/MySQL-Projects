-- Case Statements

Select first_name, 
last_name, age,
CASE
	When age <= 30 Then 'Young' 
    When age BETWEEN 31 AND 50 THEN 'Old'
    When age >= 51 Then 'Near Retirement'
END as Age_Bracket
From employee_demographics
;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

Select
first_name, last_name, salary as current_salary,
Case
	When salary < 50000 Then salary * 1.05
    When salary > 50000 Then salary * 1.07
End as new_salary,
Case 
	When dept_id = 6 Then salary * 0.1
End as bonus_this_year
From employee_salary
;
