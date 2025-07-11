-- Trigger and Events

-- Triggers

Select *
From employee_demographics;

Select *
From employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, Last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.Last_name);
END $$

DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

-- Events

Select *
From employee_demographics
Where age > 60
;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	From employee_demographics
	Where age >= 60;
END $$
DELIMITER ;

-- TO FIX IF NOT DELETING

SHOW VARIABLES LIKE 'event%';

