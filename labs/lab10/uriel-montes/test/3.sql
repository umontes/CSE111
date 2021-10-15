
-- Create a trigger t3 that resets the comment to Positive balance 
-- if the balance goes back positive from negative. Write a 
-- SQL statement that sets the balance to 100 for all the customers
-- in ROMANIA. Write a query that returns the number of customers 
-- with negative balance from EUROPE. Put all theSQL statements 
-- in filetest/3.sql.  (3 points)



DROP TRIGGER IF EXISTS t3;

-- t3
CREATE TRIGGER t3 AFTER UPDATE ON customer
BEGIN
    UPDATE customer
    SET c_comment = 'Positive balance'
    WHERE c_custkey = NEW.c_custkey
        AND new.c_acctbal > 0
        AND old.c_acctbal < 0;
END;

-- bal = 100 for cust in ROMANIA
UPDATE customer
SET c_acctbal = 100
WHERE c_nationkey IN (
                    SELECT n_nationkey
                    FROM nation
                    WHERE n_name = 'ROMANIA'
                    );

-- return # of cust w/neg bal from EUROPE
SELECT COUNT(c_custkey)
FROM customer, nation, region
WHERE c_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND c_acctbal < 100
    AND r_name = 'EUROPE';
