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


def populatePriceRange(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate PriceRange")
    # populatePriceRange populates the PriceRange materialized view with 
    # the tuples derived from the original provided data. (10 points)

    try:
        remove_old = "DELETE FROM PriceRange"
        _conn.execute(remove_old)

        sql = """INSERT INTO PriceRange
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, Laptop
                WHERE Product.model = Laptop.model
                GROUP BY Product.maker, Product.type
                UNION
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, PC
                WHERE Product.model = PC.model
                GROUP BY Product.maker, Product.type
                UNION
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, Printer
                WHERE Product.model = Printer.model
                GROUP BY Product.maker, Product.type
                """
        _conn.execute(sql)

        _conn.commit()
        print("success")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def printPriceRange(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Print PriceRange")
    # printPriceRange retrieves all the tuples from PriceRange and prints
    # them sorted in ascending order by maker and type, respectively. (5 points)

    try:
        sql = """SELECT *
                FROM PriceRange  
            """
        cur = _conn.cursor()
        cur.execute(sql)

        l = '{:<10} {:<20} {:>20} {:>20}'.format("maker", "product", "minPrice", "maxPrice")
        print(l)

        rows = cur.fetchall()
        for row in rows:
            t = '{:<10} {:<20} {:>20} {:>20}'.format(row[0],row[1],row[2],row[3])
            print(t)
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def insertPC(_conn, _maker, _model, _speed, _ram, _hd, _price):
    print("++++++++++++++++++++++++++++++++++")
    # insertPC inserts data for a new PC passed as function arguments in Product
    # and PC. Moreover, it updates PriceRange when necessary. (5 points)

    try:
        cur = _conn.cursor()

        insert_product = "INSERT INTO Product VALUES( ?, ?, 'pc')"
        args_product = [_maker, _model]
        cur.execute(insert_product, args_product)

        insert_pc = "INSERT INTO PC VALUES(?,?,?,?,?)"
        args_pc = [_model, _speed, _ram, _hd, _price]
        cur.execute(insert_pc, args_pc)

        insert_new = """ 
                    INSERT INTO PriceRange Values(?, 'pc', ?, ?)
                    SELECT maker, type, minPrice, maxPrice
                    WHERE NOT EXISTS (
                                    SELECT 
                                    FROM PriceRange
                                    WHERE maker = ?
                                        AND type = 'pc'
                                    )
                    """
        args_new = [_maker, _price, _price, _maker]
        cur.execute(insert_new, args_new)

        update_min = """
                    UPDATE PriceRange
                    SET minPrice = ?
                    WHERE maker = ?
                        AND type = 'pc'
                        AND minPrice > ?
                    """
        args_min = [_price, _maker, _price]
        cur.execute(update_min, args_min)

        update_max = """
                    UPDATE PriceRange
                    SET maxPrice = ?
                    WHERE maker = ?
                        AND type = 'pc'
                        AND maxPrice < ?
                    """
        args_max = [_price, _maker, _price]
        cur.execute(update_max, args_max)

        l = 'Insert PC ({}, {}, {}, {}, {}, {})'.format(_maker, _model, _speed, _ram, _hd, _price)
        print(l)

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def updatePrinter(_conn, _model, _price):
    print("++++++++++++++++++++++++++++++++++")
    # updatePrinter updates the price of a printer specified by its model number
    # with the new price passed as a function argument. Moreover, it updates
    # PriceRange when necessary. (5 points)

    try:
        cur = _conn.cursor()

        update_printer = """ 
                        UPDATE Printer
                        SET price = ?
                        WHERE model = ?
                        """
        args_printer = [_price, _model]
        cur.execute(update_printer, args_printer)

        # populatePriceRange(_conn)
        remove_old = "DELETE FROM PriceRange"
        _conn.execute(remove_old)

        sql = """INSERT INTO PriceRange
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, Laptop
                WHERE Product.model = Laptop.model
                GROUP BY Product.maker, Product.type
                UNION
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, PC
                WHERE Product.model = PC.model
                GROUP BY Product.maker, Product.type
                UNION
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, Printer
                WHERE Product.model = Printer.model
                GROUP BY Product.maker, Product.type
                """
        _conn.execute(sql)

        l = 'Update Printer ({}, {})'.format(_model, _price)
        print(l)

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def deleteLaptop(_conn, _model):
    print("++++++++++++++++++++++++++++++++++")
    # deleteLaptop deletes the laptop with the given model number from the database.
    # Moreover, it updates PriceRange when necessary. (5 points)

    try:
        cur = _conn.cursor()

        deleteLaptop = """
                        DELETE
                        FROM Laptop
                        WHERE model = ?
                        """
        args_Laptop = [_model]
        cur.execute(deleteLaptop, args_Laptop)

        deleteLaptop2 = """
                        DELETE
                        FROM Product
                        WHERE model = ?
                        """
        args_Laptop2 = [_model]
        cur.execute(deleteLaptop2, args_Laptop2)

        # populatePriceRange(_conn)
        remove_old = "DELETE FROM PriceRange"
        _conn.execute(remove_old)

        sql = """INSERT INTO PriceRange
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, Laptop
                WHERE Product.model = Laptop.model
                GROUP BY Product.maker, Product.type
                UNION
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, PC
                WHERE Product.model = PC.model
                GROUP BY Product.maker, Product.type
                UNION
                SELECT Product.maker, Product.type, MIN(price), MAX(price)
                FROM Product, Printer
                WHERE Product.model = Printer.model
                GROUP BY Product.maker, Product.type
                """
        _conn.execute(sql)
        
        l = 'Delete Laptop ({})'.format(_model)
        print(l)

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"data.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        populatePriceRange(conn)
        printPriceRange(conn)

        file = open('input.in', 'r')
        lines = file.readlines()
        for line in lines:
            print(line.strip())

            tok = line.strip().split(' ')
            if tok[0] == 'I':
                insertPC(conn, tok[2], tok[3], tok[4], tok[5], tok[6], tok[7])
            elif tok[0] == 'U':
                updatePrinter(conn, tok[2], tok[3])
            elif tok[0] == 'D':
                deleteLaptop(conn, tok[2])

            printPriceRange(conn)

        file.close()

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
