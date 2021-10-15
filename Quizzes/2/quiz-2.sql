
-- 1. Find the class name and the country of the classes that carry guns of at least 15-inch bore.
SELECT c_class, c_country
FROM classes
WHERE c_bore >= 15;

-- 2. Find the ships launched prior to 1918.
SELECT s_name
FROM ships
WHERE s_launched < 1918;

-- 3. Find the ships sunk in the battle of Surigao Strait.
SELECT o_ship
FROM outcomes
WHERE o_battle = 'Surigao Strait' 
    AND o_result = 'sunk';

-- 4. List the ships with a displacement larger than 40,000 tons built after 1921.
SELECT s_name
FROM ships, classes
WHERE c_class = s_class 
    AND c_displacement > 40000 
    AND s_launched > 1921;

-- 5. List the name, displacement, and number of guns of the ships engaged in the battle of Surigao Strait.
SELECT o_ship, c_displacement, c_numGuns
FROM classes, outcomes, ships
WHERE c_class = s_class
    AND s_name = o_ship
    AND o_battle = 'Surigao Strait'
    GROUP BY o_ship;

-- 6. List  the  name  of  all  the  ships  from  the  database.   Ships  appear  in Ships, Classes,  and Outcomes tables.  All of them have to be printed. 
SELECT c_class
FROM classes
UNION
SELECT s_name
FROM ships
UNION
SELECT o_ship
FROM outcomes;

-- 7. Find the classes that have exactly two ships in the class.
SELECT s_class
FROM ships
GROUP BY s_class
    HAVING count(s_class) = 2;

-- 8. Find the countries that have both bb and bc ships.
SELECT c_country
FROM classes
WHERE c_type = 'bb'
INTERSECT
SELECT c_country
FROM classes
WHERE c_type = 'bc';

-- 9. Find the ships that survived a battle in which they were damaged and then fought in another battle.
SELECT DISTINCT o_ship
FROM outcomes
WHERE o_result = 'damaged';

-- 10. For every class with at least three ships, find the number of ships of that class sunk in battle. 
--     If a class has zero sunk ships, this number has to be included in the result together with the class. 

SELECT M.s_class, COUNT(o_result)
FROM
    (SELECT s_class, s_name
    FROM ships
    WHERE s_class IN
        (SELECT s_class
        FROM ships
        GROUP BY s_class
        HAVING COUNT(s_class) >= 3) ) M
    LEFT JOIN
    (SELECT o_ship, o_result
    FROM outcomes
    WHERE o_result = 'sunk') S ON M.s_name = S.o_ship
    GROUP BY M.s_class

-- Draw/write answers in a doc file. Convert to pdf and upload the pdf to CatCourses