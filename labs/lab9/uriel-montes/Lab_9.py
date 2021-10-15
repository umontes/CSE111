import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    # Create a view V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region)
    # that appends the country and region name to every customer. 

    try:
        sql_V1 =   """
                CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region)
                AS
                SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
                FROM nation, region, customer
                WHERE c_nationkey = n_nationkey
                    AND n_regionkey = r_regionkey
                GROUP BY c_custkey;
                """
        c = _conn.cursor()
        c.execute(sql_V1)
        print("created V1")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")
    # Create a view V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region)
    # that appends the country and region name to every supplier.

    try:
        sql_V2 =    """
                CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region)
                AS
                SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
                FROM supplier, nation, region
                WHERE s_nationkey = n_nationkey
                    AND n_regionkey = r_regionkey
                GROUP BY s_suppkey;
                """
        c = _conn.cursor()
        c.execute(sql_V2)
        print("created V2")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V5")
    # Create a view V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk,
    # o_shippriority, o_comment) that replaces o_orderdate with the year o_orderyear and contains all the other
    # attributes in orders.

    try:
        sql_V5 =    """
                CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment)
                AS
                SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, strftime('%Y', o_orderdate), o_orderpriority, o_clerk, o_shippriority, o_comment
                FROM orders;
                """
        c = _conn.cursor()
        c.execute(sql_V5)
        print("created V5")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")
    # Create a view V10(p_type, avg_discount) that computes the average discount for every type of part.

    try:
        sql_V10 =   """
                CREATE VIEW V10(p_type, avg_discount)
                AS
                SELECT p_type, ROUND(AVG(l_discount), 16)
                FROM part, lineitem
                WHERE p_partkey = l_partkey
                GROUP BY p_type;
                """
        c = _conn.cursor()
        c.execute(sql_V10)
        print("created V10")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View151(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V151")
    # Create a view V151(c_custkey, c_name, c_nationkey, c_acctbal) that contains the customers
    # with negative balance.

    try:
        sql_V151 =  """
                CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal)
                AS
                SELECT c_custkey, c_name, c_nationkey, c_acctbal
                FROM customer
                WHERE c_acctbal < 0
                GROUP BY c_custkey;
                """
        c = _conn.cursor()
        c.execute(sql_V151)
        print("created V151")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View152(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V152")
    # Create a view V152(s_suppkey, s_name, s_nationkey, s_acctbal) that contains the 
    # suppliers with negative balance.

    try:
        sql_V152 =  """
                    CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal)
                    AS
                    SELECT s_suppkey, s_name, s_nationkey, s_acctbal
                    FROM supplier
                    WHERE s_acctbal < 0
                    GROUP BY s_suppkey;
                    """
        c = _conn.cursor()
        c.execute(sql_V152)
        print("created V152")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    # Rewrite Q1 from Lab4 with view V1

    try:
        sql_Q1 =   """
                SELECT c_name, ROUND(SUM(o_totalprice), 2)
                FROM orders, V1
                WHERE o_custkey = c_custkey
                    AND c_nation = 'RUSSIA'
                    AND o_orderdate LIKE '1996-__-__'
                GROUP BY c_name;
                """
        c = _conn.cursor()
        c.execute(sql_Q1)
        print("Q1 success")

        rows = c.fetchall()
        with open('output/1.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    # Rewrite Q2 from Lab4 with view V2.

    try:
        sql_Q2 =   """
                SELECT s_nation, COUNT(*)
                FROM V2
                GROUP BY s_nation;
                """
        c = _conn.cursor()
        c.execute(sql_Q2)
        print("Q2 success")

        rows = c.fetchall()
        with open('output/2.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    # Rewrite Q3 from Lab4 with view V1.

    try:
        sql_Q3 =   """
                SELECT c_nation, COUNT(*)
                FROM V1, orders
                WHERE o_custkey = c_custkey
                    AND c_region = 'ASIA'
                GROUP BY c_nation;
                """
        c = _conn.cursor()
        c.execute(sql_Q3)
        print("Q3 success")

        rows = c.fetchall()
        with open('output/3.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    # Rewrite Q4 from Lab4 with view V2.

    try:
        sql_Q4 =   """
                    SELECT s_name, COUNT(*)
                    FROM partsupp, part, V2
                    WHERE p_partkey = ps_partkey
                        AND p_size < 30 
                        AND ps_suppkey = s_suppkey 
                        AND s_nation = 'CHINA'
                    GROUP BY s_name;
                    """
        c = _conn.cursor()
        c.execute(sql_Q4)
        print("Q4 success")

        rows = c.fetchall()
        with open('output/4.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    # Rewrite Q5 from Lab4 with views V1 and V5

    try:
        sql_Q5 =    """
                    SELECT COUNT(*)
                    FROM V1, V5
                    WHERE o_custkey = c_custkey 
                        AND c_nation = 'PERU' 
                        AND o_orderyear LIKE '1996';
                    """
        c = _conn.cursor()
        c.execute(sql_Q5)
        print("Q5 success")

        rows = c.fetchall()
        with open('output/5.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}\n'.format(row[0])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")
    # Rewrite Q6 from Lab4 with view V5.

    try:
        sql_Q6 =    """
                    SELECT s_name, o_orderpriority, COUNT(*)
                    FROM partsupp, V5, lineitem, supplier, region, nation
                    WHERE ps_partkey = l_partkey 
                        AND ps_suppkey = l_suppkey
                        AND l_orderkey = o_orderkey
                        AND ps_suppkey = s_suppkey
                        AND s_nationkey = n_nationkey
                        AND n_regionkey = r_regionkey
                        AND r_name = 'AMERICA'
                    GROUP BY s_name, o_orderpriority;
                    """
        c = _conn.cursor()
        c.execute(sql_Q6)
        print("Q6 success")

        rows = c.fetchall()
        with open('output/6.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}|{:<1}\n'.format(row[0],row[1],row[2])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")
    # Rewrite Q7 from Lab4 with views V1 and V5.

    try:
        sql_Q7 =    """
                    SELECT c_nation, o_orderstatus, COUNT(*)
                    FROM V1, V5
                    WHERE o_custkey = c_custkey 
                        AND c_region = 'EUROPE'
                    GROUP BY c_nation, o_orderstatus;
                    """
        c = _conn.cursor()
        c.execute(sql_Q7)
        print("Q7 success")

        rows = c.fetchall()
        with open('output/7.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}|{:<1}\n'.format(row[0],row[1],row[2])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")
    # Rewrite Q8 from Lab4 with views V2 and V5.

    try:
        sql_Q8 =    """
                    SELECT s_nation, COUNT(DISTINCT o_orderkey) as tot_orders
                    FROM V2, V5, lineitem
                    WHERE o_orderyear LIKE 1994
                        AND o_orderstatus = 'F'
                        AND o_orderkey = l_orderkey 
                        AND l_suppkey = s_suppkey
                    GROUP BY s_nation
                    HAVING tot_orders > 300;
                    """
        c = _conn.cursor()
        c.execute(sql_Q8)
        print("Q8 success")

        rows = c.fetchall()
        with open('output/8.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")
    # Rewrite Q9 from Lab4 with views V2 and V5.

    try:
        sql_Q9 =    """
                    SELECT COUNT(DISTINCT o_clerk)
                    FROM V2, V5, lineitem
                    WHERE o_orderkey = l_orderkey 
                        AND l_suppkey = s_suppkey 
                        AND s_nation = 'CANADA';
                    """
        c = _conn.cursor()
        c.execute(sql_Q9)
        print("Q9 success")

        rows = c.fetchall()
        with open('output/9.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}\n'.format(row[0])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")
    # Rewrite Q10 from Lab4 with view V10.

    try:
        sql_Q10 =   """
                    SELECT p_type, avg_discount
                    FROM V10
                    WHERE p_type LIKE '%PROMO%'
                    GROUP BY p_type;
                    """
        c = _conn.cursor()
        c.execute(sql_Q10)
        print("Q10 success")

        rows = c.fetchall()
        with open('output/10.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")
    # Rewrite Q11 from Lab4 with view V2.

    try:
        sql_Q11 =   """
                    SELECT s_nation, s_name, s_acctbal
                    FROM V2 s
                    WHERE s_acctbal = 
                            (SELECT MAX(s_acctbal)
                            FROM V2 s1
                            WHERE s.s_nation = s1.s_nation
                            )
                    GROUP BY s_nation;
                    """
        c = _conn.cursor()
        c.execute(sql_Q11)
        print("Q11 success")

        rows = c.fetchall()
        with open('output/11.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}|{:<1}\n'.format(row[0],row[1],row[2])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")
    # Rewrite Q12 from Lab4 with view V2.

    try:
        sql_Q12 =   """
                    SELECT s_nation, ROUND(AVG(s_acctbal), 11)
                    FROM V2
                    GROUP BY s_nation;
                    """
        c = _conn.cursor()
        c.execute(sql_Q12)
        print("Q12 success")

        rows = c.fetchall()
        with open('output/12.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}\n'.format(row[0],row[1])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")
    # Rewrite Q13 from Lab4 with views V1 and V2.

    try:
        sql_Q13 =   """
                    SELECT COUNT(*) 
                    FROM 
                        (SELECT *
                        FROM orders, V1
                        WHERE c_custkey = o_custkey
                            AND c_nation = 'ARGENTINA'),
                        (SELECT *
                        FROM lineitem, V2
                        WHERE l_suppkey = s_suppkey
                            AND s_region = 'ASIA')
                    WHERE l_orderkey = o_orderkey;
                    """
        c = _conn.cursor()
        c.execute(sql_Q13)
        print("Q13 success")

        rows = c.fetchall()
        with open('output/13.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}'.format(row[0])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")
    # Rewrite Q14 from Lab4 with views V1 and V2.

    try:
        sql_Q14 =   """
                    SELECT custRegion, suppRegion, COUNT(*) as no
                    FROM orders
                        JOIN
                            (SELECT o_orderkey as custOrder, c_region as custRegion
                            FROM orders, V1
                            WHERE o_custkey = c_custkey
                            ) on o_orderkey = custOrder
                        JOIN
                            (SELECT l_orderkey as suppOrder, s_region as suppRegion
                            FROM lineitem, V2
                            WHERE l_suppkey = s_suppkey
                            ) on o_orderkey = suppOrder
                    GROUP BY custRegion, suppRegion;
                    """
        c = _conn.cursor()
        c.execute(sql_Q14)
        print("Q14 success")

        rows = c.fetchall()
        with open('output/14.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}|{:<1}|{:<1}\n'.format(row[0],row[1],row[2])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")
    # Rewrite Q15 from Lab4 with views V151 and V152.

    try:
        sql_Q15 =   """
                    SELECT COUNT(DISTINCT o_orderkey)
                    FROM orders, lineitem
                    WHERE o_orderkey = l_orderkey
                        AND o_custkey IN
                                        (
                                        SELECT c_custkey
                                        FROM V151
                                        )
                        AND l_suppkey IN
                                        (
                                        SELECT s_suppkey
                                        FROM V152
                                        );
                    """
        c = _conn.cursor()
        c.execute(sql_Q15)
        print("Q15 success")

        rows = c.fetchall()
        with open('output/15.out', 'w') as f:
            for row in rows:
                data_out = '{:<1}\n'.format(row[0])
                f.write(str(data_out))
            f.close()

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"data/tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)
        Q4(conn)

        create_View5(conn)
        Q5(conn)

        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)

        create_View151(conn)
        create_View152(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
