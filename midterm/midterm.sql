-- 1.
-- What makers produce Printers?
SELECT DISTINCT maker
FROM Product, Printer 
WHERE Product.model = Printer.model;

-- 2.
-- What makers produce color Printers cheaper than $200?
SELECT maker
FROM Product, Printer
WHERE Product.model = Printer.model
    AND Printer.color = 1
    AND Printer.price < 200;

-- 3.
-- What makers produce PCs, Laptops, and Printers?
SELECT maker
FROM Product
WHERE type = 'pc'
    AND maker IN (
                SELECT maker
                FROM Product
                WHERE type = 'printer'
                )
    AND maker IN (
                SELECT maker
                FROM Product
                WHERE type = 'laptop'
                )
GROUP BY maker;

-- 4.
-- What makers produce PCs and Printers but do not produce Laptops?
SELECT maker
FROM Product
WHERE type = 'pc'  
    AND maker IN (
                SELECT maker
                FROM Product
                WHERE type = 'printer'
                )
    AND maker NOT IN (
                SELECT maker
                FROM Product
                WHERE type = 'laptop'
                )
GROUP BY maker;

-- 5.
-- For every maker that sells both PCs and Laptops, 
-- find the combination of PC and Laptop that has minimum 
-- price. Print the maker, the PC model, Laptop model, and the 
-- combination price (PC price + Laptop price).
SELECT maker, PC.model, Laptop.model, MIN(PC.price + Laptop.price)
FROM Product, PC, Laptop
WHERE type = 'pc'
    AND maker IN (
                SELECT maker
                FROM Product
                WHERE type = 'laptop'
                    AND Product.model = Laptop.model
                )
    AND Product.model = PC.model
GROUP BY maker;

-- 6.
-- What is the average price of a Printer?
SELECT AVG(Printer.price)
FROM Printer;

-- 7.
-- How many models of each different type of Printers are offered?
SELECT DISTINCT COUNT(Printer.model)
FROM Printer
GROUP BY Printer.type;

-- 8.
-- How many models of laser color Printers are available?
SELECT COUNT(Printer.model)
FROM Printer
WHERE type = 'laser'
    AND color = 1;

-- 9.
-- How many makers produce at least 2 different types 
-- (not models) of Printers?
SELECT COUNT(counted)
FROM (
    SELECT COUNT(DISTINCT maker) AS counted
    FROM Product, Printer
    WHERE Product.model = Printer.model
    GROUP BY maker
    HAVING COUNT(DISTINCT Printer.type) >= 2
    ) AS counted_makers;

-- 10.
-- For every Laptop screen size, find the minimum price 
-- of Laptops having that screen size.
SELECT DISTINCT screen, MIN(price) 
FROM Laptop
GROUP BY screen;

-- 11.
-- What Laptop screen sizes are offered in at least 3 
-- different models?
SELECT screen 
FROM Laptop 
GROUP BY screen 
HAVING COUNT(DISTINCT model) >= 3;

-- 12.
-- What Laptop screen sizes are offered 
-- with at least 2 different speeds?
SELECT screen
FROM Laptop
GROUP BY screen
HAVING COUNT(DISTINCT speed) >= 2;

-- 13.
-- What Laptops are more expensive than 
-- any PC? Print the model and the price.
SELECT Laptop.model, Laptop.price
FROM Laptop
WHERE Laptop.price > (
                    SELECT MAX(PC.price)
                    FROM PC
                    )
GROUP BY Laptop.model;

-- 14.
-- What Printers produced by the maker of the most expensive 
-- PC that also produces Printers are the cheapest?  
-- Print the model and the price
SELECT Printer.model, MIN(Printer.price) 
FROM (
    SELECT maker AS Max_Maker, MAX(PC.price)
    FROM Product, PC
    WHERE Product.model = PC.model
        AND type = 'pc'
        AND maker IN (
                    SELECT maker
                    FROM Product
                    WHERE type = 'printer'
                    )
    ) AS Max_Maker_pc,
    Printer

-- 15.
-- Find the average price for each product category 
-- (PC, Laptop, Printer) for every maker having products in 
-- all the categories.
SELECT AVG(PC.price), AVG(Laptop.price), AVG(Printer.price)
FROM PC, Laptop, Printer, Product
WHERE Product.model = PC.model
    AND Product.type = 'pc'  
    AND Product.maker IN (
                SELECT Product.maker
                FROM Product
                WHERE Product.model = Printer.model
                    AND Product.type = 'printer'
                )
    AND Product.maker IN (
                SELECT Product.maker
                FROM Product
                WHERE Product.model = Laptop.model
                    AND Product.type = 'laptop'
                );

-- 16.
-- What makers produce exactly a single Laptop model?
SELECT maker
FROM Product
WHERE type = 'laptop'
GROUP BY maker
HAVING COUNT(DISTINCT model) = 1;

-- 17.
-- What makers do not produce any Laptop model?
SELECT maker
FROM Product
WHERE maker NOT IN (
            SELECT maker
            FROM Product
            WHERE type = 'laptop'
            GROUP BY maker
            )
GROUP BY maker;

-- 18.
-- What makers produce a single Laptop model 
-- and exactly 3 PC models?
SELECT Product.maker
FROM Product
WHERE Product.maker IN (
                SELECT maker
                FROM Product
                WHERE type = 'laptop'
                GROUP BY maker
                HAVING COUNT(DISTINCT model) = 1
                )
    AND Product.type = 'pc'
GROUP BY Product.maker
HAVING COUNT(DISTINCT Product.model) = 3;

-- 19.
-- What makers produce at least a PC or Laptop 
-- model and at most 3 Printer models?
SELECT Product.maker
FROM Product
WHERE Product.maker IN (
                        SELECT Product.maker
                        FROM Product, PC
                        WHERE Product.model  = PC.model
                        GROUP BY Product.maker
                        HAVING COUNT(DISTINCT Product.maker) >= 1
                        )
    AND Product.maker IN(
                        SELECT Product.maker
                        FROM Product, Laptop
                        WHERE Product.model = Laptop.model
                        GROUP BY Product.maker
                        HAVING COUNT(DISTINCT Product.maker) >= 1
                        )
    AND Product.maker IN (
                        SELECT Product.maker 
                        FROM Product, Printer
                        WHERE Product.model = Printer.model
                        GROUP BY Product.maker
                        HAVING COUNT(DISTINCT Product.maker) <= 3
                        )
GROUP BY Product.maker;

-- 20.
-- List the Laptops with screen size 15 or larger 
-- and speed less than 2 made by a maker that also 
-- makes printers. Print the laptop model, the 
-- screen, the speed, and the maker.
SELECT DISTINCT Laptop.model, Laptop.screen, Laptop.speed, Product.maker
FROM Laptop, Product
WHERE Product.model = Laptop.model
    AND Laptop.screen >= 15
    AND Laptop.speed < 2
    AND maker IN (
                SELECT maker 
                FROM Product 
                WHERE type = 'printer'
                );