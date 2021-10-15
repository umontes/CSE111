-- What is the minimum,  maximum,  average,  and total account balance among the customers in each market segment?  Sort the results in decreasing order of the total account balance.

SELECT DISTINCT c_mktsegment, 
    MIN(c_acctbal),
    MAX(c_acctbal),
    AVG(c_acctbal),
    SUM(c_acctbal)
FROM customer
WHERE c_mktsegment = 'AUTOMOBILE';

SELECT DISTINCT c_mktsegment, 
    MIN(c_acctbal),
    MAX(c_acctbal),
    AVG(c_acctbal),
    SUM(c_acctbal)
FROM customer
WHERE c_mktsegment = 'BUILDING';

SELECT DISTINCT c_mktsegment, 
    MIN(c_acctbal),
    MAX(c_acctbal),
    AVG(c_acctbal),
    SUM(c_acctbal)
FROM customer
WHERE c_mktsegment = 'FURNITURE';

SELECT DISTINCT c_mktsegment, 
    MIN(c_acctbal),
    MAX(c_acctbal),
    AVG(c_acctbal),
    SUM(c_acctbal)
FROM customer
WHERE c_mktsegment = 'HOUSEHOLD';

SELECT DISTINCT c_mktsegment, 
    MIN(c_acctbal),
    MAX(c_acctbal),
    AVG(c_acctbal),
    SUM(c_acctbal)
FROM customer
WHERE c_mktsegment = 'MACHINERY';
