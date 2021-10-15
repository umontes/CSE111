
-- Create a trigger t2 that sets a warning Negative balance!!! 
-- in the comment attribute of the customer table  every  time 
-- c_acctbal is updated to a negative value from a positive one.
-- Write a SQL statement that sets the balance to -100 for all  
-- the customers in EUROPE. Write a query that returns the number 
-- of customers with negative balance from FRANCE. Put all the 
-- SQL statements infiletest/2.sql.  (3 points)



DROP TRIGGER IF EXISTS t2;

-- t2
CREATE TRIGGER t2 AFTER UPDATE ON customer
BEGIN
    UPDATE customer
    SET c_comment = 'Negative balance!!!'
    WHERE c_custkey = NEW.c_custkey
        AND new.c_acctbal < 0
        AND old.c_acctbal > 0;
END;

-- bal = -100 for cust in EUROPE
UPDATE customer
SET c_acctbal = -100
WHERE c_nationkey IN (
                    SELECT n_nationkey
                    FROM nation
                    WHERE n_name = 'EUROPE'
                    );

-- return # of cust w/neg bal from FRANCE
SELECT COUNT(c_custkey)
FROM customer, nation
WHERE c_nationkey = n_nationkey
    AND c_acctbal < 0
    AND n_name = 'FRANCE';
