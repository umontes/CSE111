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


def create_tables(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("CREATE TABLES")

    try:
        foreignkey =    """
                        PRAGMA foreign_keys = ON;
                        """
        deleteProduct = """
                        DROP TABLE IF EXISTS Product;
                        """
        deleteDistributor = """
                            DROP TABLE IF EXISTS Distributor;
                            """

        deletePriceCube =   """
                            DROP TABLE IF EXISTS Price_Cube;
                            """

        CreateProduct = """
                        CREATE TABLE Product(
                            p_model INT Primary Key,
                            type TEXT 
                                CHECK(
                                    type = 'pc'
                                    OR type = 'laptop'
                                    OR type = 'printer'),
                            maker TEXT NOT NULL
                        );
                        """

        CreateDistributor = """
                            CREATE TABLE Distributor(
                                d_model INT NOT NULL REFERENCES Product(p_model) ON DELETE CASCADE,
                                name TEXT NOT NULL,
                                price INT NULL
                            );
                            """

        CreatePriceCube =   """
                            CREATE TABLE Price_Cube(
                                distributor_type TEXT
                                    CHECK(distributor_type LIKE 'P%'
                                        OR distributor_type LIKE 'D%'),
                                product_type TEXT
                                    CHECK(product_type = 'pc'
                                            OR product_type = 'laptop'
                                            OR product_type = 'printer'),
                                num_prod INT,
                                tot_price INT
                            );
                            """

        _conn.execute(foreignkey)
        _conn.commit()
        _conn.execute(deleteProduct)
        _conn.execute(deleteDistributor)
        _conn.execute(deletePriceCube)

        _conn.execute(CreateProduct)
        _conn.execute(CreateDistributor)
        _conn.execute(CreatePriceCube)

        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def populate_tables(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("POPULATE TABLES")

    try:
        cur = _conn.cursor()

        pop_product =   """
                        INSERT INTO Product
                        VALUES(?, ?, ?);
                        """

        pop_distributor =   """
                            INSERT INTO Distributor
                            VALUES(?, ?, ?);
                            """

        pop_dis_update =    """
                            UPDATE Distributor
                            SET price = ?
                            WHERE d_model IN (
                                            SELECT d_model
                                            FROM Product, Distributor
                                            WHERE p_model = d_model
                                                AND name = maker
                                                AND name = ?
                                                AND d_model = ?
                                            );
                            """

        with open('product.txt', 'r') as p:
            for line in p:
                line = line.rstrip('\n')
                x = line.split('|', 2)
                nullargs = [x[0], x[2], 'NULL']
                cur.execute(pop_product, x)
                cur.execute(pop_distributor, nullargs)
        p.close()

        with open('distributor.txt', 'r') as p:
            for line in p:
                line = line.rstrip('\n')
                x = line.split('|', 2)
                args = [x[2], x[1], x[0]]
                cur.execute(pop_dis_update, args)
                cur.execute(pop_distributor, x)
        p.close()

        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def build_data_cube(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("BUILD DATA CUBE")

    try:
        sql =   """
                INSERT INTO Price_Cube
                SELECT maker, type, COUNT(type), SUM(price)
                FROM Distributor, Product
                WHERE p_model = d_model
                GROUP BY maker, type;
                """
        _conn.execute(sql)

        print("success")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def print_Product(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("PRINT PRODUCT")

    try:
        cur = _conn.cursor()

        sql =   """
                SELECT *
                FROM Product;
                """
        cur.execute(sql)

        l = '{:<20} {:<20} {:<20}'.format("model", "type", "maker")
        print(l)

        rows = cur.fetchall()
        for row in rows:
            data = '{:<20} {:<20} {:<20}'.format(row[0], row[1], row[2])
            print(data)

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def print_Distributor(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("PRINT DISTRIBUTOR")

    try:
        cur = _conn.cursor()

        sql =   """
                SELECT * 
                FROM Distributor;
                """
        cur.execute(sql)

        l = '{:<20} {:<20} {:>20}'.format("model", "name", "price")
        print(l)

        rows = cur.fetchall()
        for row in rows:
            data = '{:<20} {:<20} {:>20}'.format(row[0], row[1], row[2])
            print(data)

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def print_Cube(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("PRINT DATA CUBE")

    try:
        cur = _conn.cursor()

        sql =   """
                SELECT *
                FROM Price_Cube;
                """
        cur.execute(sql)

        l = '{:<20} {:<20} {:>10} {:>10}'.format("dist", "prod", "cnt", "total")
        print(l)

        rows = cur.fetchall()
        for row in rows:
            data = '{:<20} {:<20} {:>10} {:>10}'.format(row[0], row[1], row[2], row[3])
            print(data)

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def modifications(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("MODIFICATIONS")

    try:
        with open('modifications.txt', 'r') as file:
            for line in file:
                line = line.rstrip('\n')
                col = line.split(' ')
                if col[0] == 'Distributor':
                    if col[1] == 'I':
                        sql =   """
                                INSERT INTO Distributor
                                VALUES(?, ?, ?);
                                """
                        args = [col[2], col[3], col[4]]
                        _conn.execute(sql, args)

                    elif col[1] == 'D':
                        sql =   """
                                DELETE 
                                FROM Distributor
                                WHERE d_model = ?
                                    AND name = ?;
                                """
                        args = [col[2], col[3]]
                        _conn.execute(sql, args)

                elif col[0] == 'Product':
                    if col[1] == 'I':
                        sql =   """
                                INSERT INTO Product
                                VALUES(?, ?, ?);
                                """
                        args = [col[2], col[3], col[4]]
                        _conn.execute(sql, args)
                        sql2 =   """
                                INSERT INTO Distributor
                                VALUES(?, ?, ?);
                                """
                        args2 = [col[2], col[4], 'NULL']
                        _conn.execute(sql2 ,args2)

                    elif col[1] == 'D':
                        sql =   """
                                DELETE
                                FROM Product
                                WHERE p_model = ?;
                                """
                        args =[col[2]]
                        _conn.execute(sql, args)
        file.close()

        print("success")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")



def main():
    database = r"data.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_tables(conn)

        populate_tables(conn)

        print_Product(conn)
        print_Distributor(conn)

        build_data_cube(conn)
        print_Cube(conn)

        modifications(conn)

        print_Product(conn)
        print_Distributor(conn)

        build_data_cube(conn)
        print_Cube(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
