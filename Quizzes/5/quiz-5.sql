-- enable foreign keys
PRAGMA foreign_keys = on;

-- DROP TABLE Classes; 
-- DROP TABLE Ships;
-- DROP TABLE Battles;
-- DROP TABLE Outcomes;

-- Creating the tables
CREATE TABLE Classes (
    c_class VARCHAR(15) PRIMARY KEY,
    c_type CHAR(8) NOT NULL,
    c_country VARCHAR(28) NOT NULL,
    c_numGuns DECIMAL(2,0) NOT NULL,
    c_bore DECIMAL(2,0) NOT NULL,
    c_displacement DECIMAL(5,0) NOT NULL
    CHECK (c_type IN ('bb','bc'))
);

CREATE TABLE Ships (
    s_name VARCHAR(60) PRIMARY KEY,
    s_class VARCHAR(52) NOT NULL REFERENCES Classes(c_class) ON DELETE CASCADE,
    s_launched DECIMAL(4,0) NOT NULL
);

CREATE TABLE Battles(
    b_name VARCHAR(56) NOT NULL PRIMARY KEY,
    b_date char(10) NOT NULL
);

CREATE TABLE Outcomes(
    o_ship VARCHAR(10) REFERENCES Ships(s_name) ON DELETE SET NULL ON UPDATE CASCADE,
    o_battle VARCHAR(13) NOT NULL REFERENCES Battles(b_name) ON DELETE CASCADE ON UPDATE CASCADE,
    o_result VARCHAR(7) NOT NULL
    CHECK (o_result IN ('ok','sunk','damaged'))
);

-- 1. 
-- Populate every table with the corresponding sample data (2 points)
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Bismarck', 'bb', 'Germany', 8, 15, 42000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('North Carolina', 'bb', 'USA', 9, 16, 37000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Renown', 'bc', 'Britain', 6, 15, 32000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Revenge', 'bb', 'Britain', 8, 15, 29000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Tennessee', 'bb', 'USA', 12, 14, 32000);
INSERT INTO Classes (c_class, c_type, c_country, c_numGuns, c_bore, c_displacement) VALUES ('Yamato', 'bb', 'Japan', 9, 18, 65000);

INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('California', 'Tennessee', 1915);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Hiei', 'Kongo', 1915);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Iowa', 'Iowa', 1933);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Kirishima', 'Kongo', 1915);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Missouri', 'Iowa', 1935);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Musashi', 'Yamato', 1942);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('New Jersey', 'Iowa', 1936);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('North Carolina', 'North Carolina', 1941);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Renown', 'Renown', 1916);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Repulse', 'Renown', 1916);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Royal Oak', 'Revenge', 1916);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Tennessee', 'Tennessee', 1915);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Washington', 'North Carolina', 1941);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Wisconsin', 'Iowa', 1940);
INSERT INTO Ships (s_name, s_class, s_launched) VALUES ('Yamato', 'Yamato', 1941 );

INSERT INTO Battles (b_name, b_date) VALUES ('Denmark Strait', '05/24/41');
INSERT INTO Battles (b_name, b_date) VALUES ('Guadalcanal', '11/15/42');
INSERT INTO Battles (b_name, b_date) VALUES ('North Cape', '12/26/43');   
INSERT INTO Battles (b_name, b_date) VALUES ('Surigao Strait', '10/25/44');

INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('California', 'Surigao Strait', 'ok');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Kirishima', 'Guadalcanal', 'sunk');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Resolution', 'Denmark Strait', 'ok');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Wisconsin', 'Guadalcanal', 'damaged');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Tennessee', 'Surigao Strait', 'ok');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Washington', 'Guadalcanal', 'ok');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('New Jersey', 'Surigao Strait', 'ok');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Yamato', 'Surigao Strait', 'sunk');
INSERT INTO Outcomes (o_ship, o_battle, o_result) VALUES ('Wisconsin', 'Surigao Strait', 'damaged');

-- 2. 
-- Delete all the classes with a displacement larger than
-- 50,000 or with numGuns larger than 10 (4 points)
DELETE 
FROM Classes
WHERE c_displacement > 50000
    OR c_numGuns > 10;

-- 3. 
-- For every Ship from USA that has class different than 
-- the name of the Ship, create a Class tuple that has class
-- equal to the Ship name. The other attributes in Classes
-- keep the same value as in the current class of the Ship.
-- Update the class of every Ship for which a new Class
-- is created to the new Class. (5 points)
UPDATE Ships
SET s_class = s_name
WHERE s_class IN (
                SELECT s_class
                FROM Ships, Classes
                WHERE s_class = c_class
                    AND s_name != s_class
                    AND c_country = 'USA'
                );

-- 4. DONE
-- Delete "North Cape" from Battles. (4 points)
DELETE FROM Battles
WHERE b_name = 'North Cape';

-- 5.
-- Update the "Guadalcanal" battle to "North Cape" in Outcomes. (4 points)
UPDATE Battles
SET b_name = 'North Cape'
WHERE b_name = 'Guadalcanal';

-- 6.
-- Rename "Surigao Strait" to "Strait of Surigao" in Battles. (4 points)
UPDATE Battles
SET b_name = 'Strait of Surigao'
WHERE b_name = 'Surigao Strait';

-- 7.
-- Delete all the Ships that belong to Classes having more than 4 ships. (5 points)
DELETE 
FROM Ships
WHERE s_class IN (
                SELECT s_class
                FROM Ships
                GROUP BY s_class
                HAVING (COUNT(s_class)) > 4
                );

-- 8. 
-- Print all the tuples in Ships. (1 points)
SELECT * 
FROM Ships;

-- 9. 
-- Print all the tuples in Outcomes. (1 points)
SELECT *
FROM Outcomes;