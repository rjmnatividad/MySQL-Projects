-- String Functions

Select length('skyfall')
;

Select first_name, length(first_name) as length_first_name, upper(last_name) as upper_last_name, lower(gender) as lower_gender
From employee_demographics
Order by length_first_name
;

Select UPPER('sky');
Select LOWER('SKY');

Select Trim('          sky         ') as Trim;
Select LTrim('          sky         ') as LTrim;
Select RTrim('          sky         ') as RTrim;

Select first_name, 
Lower(Left(first_name,4)) as 4_Left_Lower, 
Upper(Right(first_name,4)) as 4_Right_Upper,
Substring(first_name, 3, 2) as 2_Substring,
Substring(birth_date, 6,2) as Birth_Month
From employee_demographics
;

Select first_name, Replace(first_name, 'a', 'z') as replace_first_name
From employee_demographics
;

Select first_name, Locate('an', first_name) as locate_first_name
From employee_demographics
;

Select first_name, last_name,
CONCAT(first_name, ' ', last_name) as full_name
From employee_demographics
;

