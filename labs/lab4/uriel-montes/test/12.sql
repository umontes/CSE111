-- What is the average account balance for the suppliers in every country?

SELECT n_name, AVG(s_acctbal)
FROM nation, supplier
WHERE n_nationkey = s_nationkey
GROUP BY n_name