SELECT * FROM uptraxtech_ltd.student_demographics;

# THIS IS A SELECT STATEMENT THAT RETURNS EVERYTHING ON A TABLE

-- GROUP BY STATEMENT
-- GROUP BY STATMENT WORKS WITH THE AGGREGATE FUNCTIONS(SUM, MAX, AVERAGE, MIN, COUNT)
SELECT gender, COUNT(gender), max(age), min(age), avg(age)
FROM student_demographics
GROUP BY gender;

-- DISTINCT FUNCTION/STATEMENT
-- THIS WILL SHOW THE UNIQUE ITEM IN A COLUMN
SELECT DISTINCT (gender)
FROM student_demographics;

SELECT DISTINCT (course)
FROM student_fee;

-- ALIAS(AS STATEMENT)
SELECT first_name, last_name AS Other_name
FROM student_demographics;

SELECT gender, COUNT(gender) AS gender_count
FROM student_demographics
GROUP BY gender;

-- ORDER BY STATEMENT
-- THIS IS USED FOR SORTING EITHER ALPHABETICALLY OR NUMERICALLY
SELECT * 
FROM student_demographics
ORDER BY age DESC;

SELECT *
FROM student_fee;

-- WHERE STATEMENT
SELECT first_name, last_name, age
FROM student_demographics
WHERE age < 30;

-- WHERE STATEMENT
-- HAVING AND LIKE STATEMENT
-- JOIN

SELECT *
FROM student_fee;

-- WHERE STATEMENT
SELECT first_name, last_name, fee
FROM student_fee
WHERE fee >=70000;

SELECT *
FROM student_demographics;

-- QUERY USING THE LOGICAL OPERATORS
-- QUERY TO DISPLAY GENDER = FEMALE AND THEIR AGE TO BE LESS THAN 30 USING A LOGICAL OPERATOR, AND
SELECT first_name, last_name, gender, age
FROM student_demographics
WHERE gender = "female" AND age<30;

-- QUERY USING THE OR LOGICAL OPERATOR WHICH WILL NOT ONLY RETURN THE FEMALES BUT AS WEL AS THE MALES UNDER 30
SELECT first_name, last_name, gender, age
FROM student_demographics
WHERE gender = "female" OR age<30;

-- USING OR NOT LOGICAL OPERATOR
SELECT first_name, last_name, gender, age
FROM student_demographics
WHERE gender = "female" OR NOT age<30;

-- USING AND NOT LOGICAL OPERATOR
SELECT first_name, last_name, gender, age
FROM student_demographics
WHERE gender = "female" AND NOT age<30;

-- HAVING STATEMENT
SELECT first_name, last_name, gender, age
FROM student_demographics
HAVING age <30;

-- HAVING, LIKE STATEMENT
SELECT *
FROM course_applied, student_demographics, student_fee 
HAVING course LIKE "%da%";

SELECT first_name, last_name, course
FROM student_fee
HAVING course LIKE "%%";

-- JOINS STATEMENT (RESEMBLES MERGE FUNCTION)
-- IS CONNECTING TABLES TOGETHER
-- EXAMPLE: WE WANT TO JOIN THE STUDENT_FEE TABLE WITH THE STUDENT_DEMOGRAPHICS TABLE
SELECT *
FROM student_demographics
JOIN student_fee
	ON student_demographics.first_name = student_fee.first_name;
    
SELECT *
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
    
SELECT dem.student_id, fee.first_name, dem.last_name, age, gender, birth_date, course, fee, department_id
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
    
    -- OUTER JOIN
    -- THERE IS THE LEFT AND RIGHT OUTER JOIN
SELECT *
FROM student_demographics AS dem
LEFT JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
    
SELECT *
FROM student_demographics AS dem
RIGHT JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
    
SELECT *
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name;
   
-- ASSIGNMENT NO.1
-- JOIN THE THREE TABLES ON UPTRAXTECH_LTD DATABASE
-- SOLUTION:
SELECT * 
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON  dem.first_name = fee.first_name
JOIN course_applied AS c_a
	ON fee.department_id = c_a.dept_id;

-- ASSIGNMENT NO.2
-- JOIN STUDENT_FEE TABLE AND STUDENT_DEMOGRAPHICS TABLE, WHERE AGE IS LESS THAN 30, COLUMNS SHOULDNT APPEAR TWICE
-- SOLUTION:
SELECT dem.student_id, fee.first_name, dem.last_name, age, gender, birth_date, course, fee, department_id
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name
WHERE age < 30;
    
-- UNION 
-- STRING FUNCTIONS
-- CASE FUNCTIONS

-- UNION (RESEMBLES APPEND FUNCTION)
SELECT first_name, last_name
FROM student_demographics
UNION 
SELECT gender, age
FROM student_demographics;

SELECT first_name, last_name
FROM student_demographics
UNION 
SELECT fee, course
FROM student_fee;

-- STRING FUNCTIONS
-- STRING FUNCTIONS ARE TEXT FUNCTIONS
-- UPPER AND LOWER
SELECT UPPER("jason");
SELECT LOWER("JASON");

SELECT first_name, UPPER(first_name)
FROM student_demographics;

SELECT first_name, LOWER(first_name)
FROM student_demographics;

-- CONCATENATE
-- TO JOIN TWO OR MORE COLUMNS TOGETHER
SELECT first_name, last_name, CONCAT(first_name," ",last_name) AS full_name
FROM student_demographics;

-- TRIM
-- THIS IS USED FOR REMOVING EMPTY SPACES BETWEEN TEXTS
SELECT ('         UPTRAX        ');

-- LEFT TRIM
-- THIS TYPE OF TRIM REMOVES SPACES FROM THE LEFT SIDE OF THE TEXT
SELECT LTRIM('         UPTRAX        ');

-- LEFT AND RIGHT
SELECT birth_date, 
LEFT(birth_date, 4), 
RIGHT(birth_date, 2)
FROM student_demographics;

-- SUBSTRING
-- THIS ENABLES ONE TO PICK A CHARACTER FROM A TEXT RANGE 
SELECT birth_date, 
LEFT(birth_date, 4) birth_year,
RIGHT(birth_date, 2) birth_day,
substring(birth_date, 6,2) birth_month
FROM student_demographics;

-- CASE FUNCTIONS
-- COMMON TABLE EXPRESSION(CTE)

-- CASE FUNCTIONS
-- THIS USES LOGIC TO QUERY A DATABASE. THIS IS ALSO FOR GROUPING.
SELECT first_name, age,
CASE
WHEN age<30 THEN "Young"
WHEN age>=30 THEN "Adult"
END AS age_group
FROM student_demographics;

SELECT first_name, age,
CASE
WHEN age BETWEEN 20 AND 25 THEN "Young"
WHEN age BETWEEN 26 AND 30 THEN "Adult"
WHEN age BETWEEN 31 AND 35 THEN "Old"
WHEN age>35 THEN "Senior" 
END AS age_bracket
FROM student_demographics;

SELECT first_name, last_name, age, birth_date,
CASE
WHEN birth_date BETWEEN "1980-01-01" AND "1990-12-31" THEN "BABY BOOMERS"
WHEN birth_date BETWEEN "1991-01-01" AND "1999-12-31" THEN "MILLENIALS"
WHEN birth_date BETWEEN "2000-01-01" AND "2010-12-31" THEN "GEN Z"
END AS age_category
FROM student_demographics
ORDER BY age_category;


-- COMMON TABLE EXPRESSION(CTE)
-- A CTE IN SQL IS A TEMPORARY RESULT SET THAT ONE CAN REFERENCE WITHIN A SELECT, INSERT, UPDATE, OR DELETE STATMENT
-- IT IS DEFINED USING THE WITH KEYWORD AND HELPS MAKE COMPLEX QUERIES MORE READABLE AND MAINTAINABLE

SELECT gender, avg(age), min(age), max(age), sum(fee), avg(fee), min(fee), max(fee)
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name
GROUP BY gender;

-- CTE EXAMPLE
WITH CTE AS 
(SELECT gender, avg(age) AS avg_age, min(age) AS min_age, max(age) AS max_age, sum(fee) AS sum_fee, avg(fee) AS avg_fee, min(fee) AS min_fee, max(fee) AS max_fee
FROM student_demographics AS dem
JOIN student_fee AS fee
	ON dem.first_name = fee.first_name
GROUP BY gender)
SELECT *
FROM CTE;


-- DATA CLEANING IN SQL
-- DATA QUALITY 
-- THIS IS THE PROCESS OF ENSURING THAT DATA IS THOROUGHLY PRE-PROCESSED

-- CHECKING FOR MISSING VALUES (NULLS)
SELECT*
FROM student_demographics
WHERE first_name IS NULL;

-- IDENTIFYING ROWS WITH MISSING VALUES IN SPECIFIC VALUES IN SPECIFIC COLUMNS
SELECT*
FROM student_demographics
WHERE first_name IS NULL OR last_name IS NULL OR gender IS NULL;

-- COUNT MISSING VALUES
SELECT count(*) AS missing_count
FROM student_demographics
WHERE first_name IS NULL;

#REMOVING OR REPLACING MISSING VALUES
DELETE FROM student_demographics
WHERE first_name IS NULL;

-- REPLACING MISSING VALUES USING COALESCE()
SELECT first_name,
coalesce(first_name, 'Unknown') AS cleaned_column
FROM student_demographics;

-- REPLACING MISSING VALUES WITH THE COLUMN MEAN (NUMERICAL DATA)
UPDATE student_fee
SET fee = (
	SELECT avg_fee
    FROM 
	(SELECT AVG(fee) AS avg_fee
    FROM student_fee
    WHERE fee IS NOT NULL) AS temp_avg
    )
    WHERE fee IS NULL;

-- USING CHATGPT: SINCE MYSQL DOESN'T ALLOW DIRECTLY REFERENCING THE TARGET TABLE(student_fee) IN A SUBQUERY WHEN UPDATING IT.
-- TO FIX THIS, YOU CAN USE A TEMPORARY TABLE OR A COMMON TABLE EXPRESSION TO FIRST CALCULATE THE AVERAGE AND THEN PERFORM THE UPDATE.
UPDATE student_fee
SET fee = (SELECT avg_fee FROM (SELECT AVG(fee) AS avg_fee FROM student_fee WHERE fee IS NOT NULL) AS temp_avg)
WHERE fee IS NULL;

WITH AvgFee AS (
	SELECT AVG(fee) AS avg_fee
    FROM student_fee
    WHERE fee IS NOT NULL
    )
    UPDATE student_fee
    SET fee = (SELECT avg_fee FROM Avg_Fee)
    WHERE fee IS NULL;
    
-- HOW TO HANDLE DUPLICATES
-- TO IDENTIFY DUPLICATES, YOU CAN USE THE GROUP BY AND HAVINH CLAUSES TO FIND ROWS WITH THE SAME VALUES.
SELECT first_name, last_name, count(*)
FROM student_demographics
GROUP BY first_name, last_name
HAVING count(*) > 1;

-- REMOVING DUPLICATES

-- METHOD 1: USING DELETE WITH ROW_NUMBER() (RETAIN THE FIRST OCCURENCE)

CREATE TEMPORARY TABLE temp_table AS
SELECT *
FROM student_demographics
WHERE first_name IN (
	SELECT MIN(first_name)
    FROM student_demographics
    GROUP BY first_name
    );
    
SELECT *
FROM temp_table;
    
DELETE FROM student_demographics;
INSERT INTO student_demographics SELECT * FROM temp_table;
DROP TEMPORARY TABLE temp_table;

-- VERFYING REMOVAL
-- AFTER DELETION, RUN THE DUPLICATE-CHECK QUERY AGAIN TO ENSURE ALL DUPLICATES HAVE BEEN REMOVED

SELECT first_name, last_name, count(*)
FROM student_demographics
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;