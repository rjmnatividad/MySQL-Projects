-- STORED PROCEDURE

Select *
From employee_salary
Where salary >= 50000
;

-- SYNTAX

CREATE PROCEDURE large_salaries()
Select *
From employee_salary
Where salary >= 50000;

 -- MORE COMPLEX SAMPLES
 
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	Select *
	From employee_salary
	Where salary >= 50000;
	Select *
	From employee_salary
	Where salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries2();
-- Parameter

DELIMITER $$
CREATE PROCEDURE large_salaries4(maretis INT)
BEGIN
	Select first_name, last_name, salary
	From employee_salary
    Where employee_id = maretis
    ;
END $$
DELIMITER ;

Call large_salaries4(1)
