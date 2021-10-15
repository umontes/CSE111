-- Find all the items with the return flag set to R on the receipt date of May 30, 1992

SELECT *
FROM lineitem
WHERE l_returnflag LIKE 'R'
    AND 
    l_receiptdate LIKE '1992-05-30'