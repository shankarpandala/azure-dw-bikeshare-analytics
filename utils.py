import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Helper functions

def get_connection(credentials, isolation_level=None) :
    sslmode = "require"
    conn_string = f"host={credentials['host']} user={credentials['user']} dbname={credentials['dbname']} password={credentials['password']} sslmode={sslmode}"
    conn = psycopg2.connect(conn_string)
    conn.autocommit = True
    if isolation_level : conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT);
    print("Connection established")
    cursor = conn.cursor()
    return conn, cursor


def close_connection(conn, cursor) :
    conn.commit()
    cursor.close()
    conn.close()


def drop_recreate(c, tablename, create):
    c.execute(f"DROP TABLE IF EXISTS {tablename};")
    c.execute(create)
    print(f"Finished creating table {tablename}")


def populate_table(conn, cursor, filename, tablename):
    f = open(filename, 'r')
    try:
        cursor.copy_from(f, tablename, sep=",", null = "")
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        conn.rollback()
        cursor.close()
    print(f"Finished populating {tablename}")