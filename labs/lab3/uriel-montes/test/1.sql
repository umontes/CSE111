-- What is the address, phone number, and account balance ofCustomer#000000127?
SELECT c_address, c_phone, c_acctbal
FROM customer
WHERE c_name LIKE 'Customer#000000127'