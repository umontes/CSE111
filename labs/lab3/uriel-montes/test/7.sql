-- What is the receipt date and the total number of ordered items per receipt date by Customer#000000106?

SELECT l_receiptdate, COUNT(l_quantity)
FROM lineitem, customer, orders
WHERE o_custkey = c_custkey
    AND o_orderkey = l_orderkey
    AND c_name = 'Customer#000000106'
GROUP BY l_receiptdate;