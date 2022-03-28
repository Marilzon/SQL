/* BASIC */

/*
    Query the list of CITY names ENDING with vowels (a, e, i, o, u) 
*/
SELECT DISTINCT CITY 
FROM STATION 
WHERE lower(substr(CITY,-1,1)) IN ('a','e','i','o','u');

/*
    Query the list of CITY names from STATION that either
    do not start with vowels or do not end with vowels.
*/
SELECT DISTINCT CITY 
FROM STATION 
WHERE 
    lower(substr(CITY,-1,1)) NOT IN ('a','e','i','o','u')
    OR
    upper(substr(CITY,1,1)) NOT IN ('a','e','i','o','u');

/*
    ORDER MARKS > 75 AND ORDER FIRST THREE LETTER OF STRING OR PER ID
*/
SELECT Name
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(Name, 3), ID;

/*
    A query to identifying the type of each record in the TRIANGLES
*/
SELECT
    CASE
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR A = C OR B = C THEN 'Isosceles'
        WHEN A <> B AND B <> C THEN 'Scalene'
    END tuple
FROM TRIANGLES;

/*
    Generate SELECT Query with CONCAT CUSTOM String, EX: Name(C) 
    Query the numbers of professional roles and GROUP, returning a custom string
    EX: There are total of %INT %OCCUPATION 
*/
SELECT CONCAT(Name,'(',upper(substr(Occupation,1,1)),')')
FROM OCCUPATIONS
ORDER BY Name ASC;

SELECT CONCAT('There are a total of ',COUNT(*),' ',lower(Occupation), 's.')
FROM OCCUPATIONS
GROUP BY OCCUPATION 
ORDER BY COUNT(*), OCCUPATION;

/*


*/
SELECT [Doctor], [Professor], [Singer], [Actor]
FROM 
(
    SELECT ROW_NUMBER()
    OVER 
    (
        PARTITION BY Occupation 
        ORDER BY Name
    ) rn, name, Occupation
    FROM Occupations
    GROUP BY Occupation, name
) AS tab2 pivot
(
    MAX(Name) 
    FOR Occupation IN ([Doctor], [Professor], [Singer], [Actor])) AS tab1
    ORDER BY rn
)

/*
    EXAMPLING A SIMPLE CASE
*/

SELECT first_name, last_name, age, 
CASE 
	WHEN age >= 50 THEN 'old'
	WHEN age isnull THEN 'null age'
	ELSE 'young'
END pilots_old
FROM pilots
ORDER BY age