-- 1. Create the tables in the schema.
CREATE TABLE classes(
    c_class varchar(15) not null,
    c_type char(8) not null,
    c_country varchar(28) not null,
    c_numGuns decimal(2,0) not null,
    c_bore decimal(2,0) not null,
    c_displacement decimal(5,0) not null
);

CREATE TABLE ships(
    s_name varchar(60) not null,
    s_class varchar(52) not null,
    s_launched decimal(4,0) not null
);

CREATE TABLE battles(
    b_name varchar(56) not null,
    b_date char(10) not null
);

CREATE TABLE outcomes(
    o_ship varchar(10) not null,
    o_battle varchar(13) not null,
    o_result varchar(7) not null
);

-- 2. Populate every table with the corresponding sample data. 
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Bismarck', 'bb', 'Germany', 8, 15, 42000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('North Carolina', 'bb', 'USA', 9, 16, 37000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Renown', 'bc', 'Britain', 6, 15, 32000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Revenge', 'bb', 'Britain', 8, 15, 29000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Tennessee', 'bb', 'USA', 12, 14, 32000);
INSERT INTO classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Yamato', 'bb', 'Japan', 9, 18, 65000);

INSERT INTO ships (s_name, s_class, s_launched) VALUES ('California', 'Tennessee', 1915);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Hiei', 'Kongo', 1915);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Iowa', 'Iowa', 1933);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Kirishima', 'Kongo', 1915);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Missouri', 'Iowa', 1935);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Musashi', 'Yamato', 1942);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('New Jersey', 'Iowa', 1936);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('North Carolina', 'North Carolina', 1941);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Renown', 'Renown', 1916);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Repulse', 'Renown', 1916);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Royal Oak', 'Revenge', 1916);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Tennessee', 'Tennessee', 1915);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Washington', 'North Carolina', 1941);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Wisconsin', 'Iowa', 1940);
INSERT INTO ships (s_name, s_class, s_launched) VALUES ('Yamato', 'Yamato', 1941 );

INSERT INTO battles (b_name, b_date) VALUES ('Denmark Strait', '05/24/41');
INSERT INTO battles (b_name, b_date) VALUES ('Guadalcanal', '11/15/42');
INSERT INTO battles (b_name, b_date) VALUES ('North Cape', '12/26/43');   
INSERT INTO battles (b_name, b_date) VALUES ('Surigao Strait', '10/25/44');

INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('California', 'Surigao Strait', 'ok');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Kirishima', 'Guadalcanal', 'sunk');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Resolution', 'Denmark Strait', 'ok');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Wisconsin', 'Guadalcanal', 'damaged');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Tennessee', 'Surigao Strait', 'ok');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Washington', 'Guadalcanal', 'ok');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('New Jersey', 'Surigao Strait', 'ok');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Yamato', 'Surigao Strait', 'sunk');
INSERT INTO outcomes (o_ship, o_battle, o_result) VALUES ('Wisconsin', 'Surigao Strait', 'damaged');

-- 3. Find the class name and the country of the classes that carry guns of at least 15-inch bore.
SELECT c_class, c_country, c_bore
FROM classes
WHERE c_bore >= 15;

-- 4. Find the ships launched prior to 1918.
SELECT s_name, s_launched
FROM ships
WHERE s_launched < 1918;

-- 5. Find the ships sunk in the battle of Surigao Strait.
SELECT o_ship, o_battle, o_result
FROM outcomes
WHERE o_battle LIKE 'Surigao Strait' AND o_result LIKE 'sunk';

-- 6. List the ships with a displacement larger than 40,000 tons built after 1921. 
SELECT s_name, s_launched, c_displacement
FROM ships, classes
WHERE c_class = s_class AND c_displacement > 40000 AND s_launched > 1921;

-- 7. List the name, displacement, and number of guns of the ships engaged in the battle of Surigao Strait.
SELECT o_ship, c_displacement, c_numGuns
FROM classes, outcomes, ships
WHERE c_class = s_class
    AND s_name = o_ship
    AND o_battle = 'Surigao Strait'
    GROUP BY o_ship;

-- 8. List the name of all the ships from the database. Ships appear in Ships, Classes, and Outcomes tables. All of them have to be printed.
SELECT c_class
FROM classes
UNION
SELECT s_name
FROM ships
UNION
SELECT o_ship
FROM outcomes;

-- 9. Find the classes that have exactly two ships in the class.
SELECT s_class
FROM ships
GROUP BY s_class
    HAVING count(s_class) = 2

-- 10. Find the countries that have both bb and bc ships.
SELECT c_country
FROM classes
WHERE c_type = 'bb'
INTERSECT
SELECT c_country
FROM classes
WHERE c_type = 'bc';

-- 11. Find the ships that survived a battle in which they were damaged and then fought in another battle.
SELECT DISTINCT o_ship
FROM outcomes
WHERE o_result = 'damaged';