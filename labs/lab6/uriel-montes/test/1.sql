-- Find the total quantity (l_quantity) of line items shipped per 
-- month (l_shipdate) in 1997. Hint: check function strftime to 
-- extract the month/year from a date.

SELECT strftime('%m', l_shipdate), SUM(l_quantity)
FROM lineitem
WHERE l_shipdate LIKE '1997%'
GROUP BY strftime('%m', l_shipdate);