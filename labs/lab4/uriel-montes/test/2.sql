-- Find the number of suppliers from every country.

SELECT n_name, count(s_name)
FROM nation, supplier
WHERE n_nationkey = s_nationkey
GROUP BY n_name