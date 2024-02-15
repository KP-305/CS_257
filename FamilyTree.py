import os
import psycopg2


DB_NAME = "db_system_principles"
DB_USER = "postgres"
DB_PASSWORD = "homework"
DB_PORT = "5432"
DB_HOST = "127.0.0.1"

#execute the query
def read_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        print("Results fetched!!")
        return result
    except psycopg2.OperationalError as err:
        print("error ",err)

#connect to the database
def connect_to_db(db_name, db_user, db_password, db_host, db_port):
    connection = None
    try:
        connection = psycopg2.connect(database=db_name, host=db_host, port=db_port, user=db_user, password=db_password)
        print("Success!!")
    except psycopg2.OperationalError as err:
        print("error ",err)
    return connection

#execute query
def execute_query(connection, query):
    connection.autocommit = True
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        print("Query has been executed!!")
    except psycopg2.OperationalError as err:
        print("error ",err)


connection = connect_to_db(DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT)

#create the table
create_table = """CREATE TABLE IF NOT EXISTS FamilyTree (
        ID SERIAL PRIMARY KEY,
        FILE_NAME char(50),
        FILE_CONTENT XML)"""

execute_query(connection, create_table)

#fetch the data from the xml files
all_rows = []
for filename in os.listdir():
    if filename.startswith("tree") and filename.endswith(".xml"):
        with open(filename, 'r') as reader:
            xml_content = reader.read()
            all_rows.append(f"('{filename}', XMLPARSE(DOCUMENT '{xml_content}'))")

#insert values into the table
get_rows = ", ".join(all_rows)
insert_into = f"INSERT INTO FamilyTree (FILE_NAME, FILE_CONTENT) VALUES {get_rows}"
execute_query(connection, insert_into)

# fetch all the rows
select_query = f"SELECT * FROM FamilyTree"
read_rows = read_query(connection, select_query)

#display all the rows from the table
for row in read_rows:
    print(row, end='\n')

# xpath query to fetch year of birth
xpath_query = f"SELECT DISTINCT CAST(unnest(xpath('//YearOfBirth/text()', FILE_CONTENT)) AS CHAR(50)) FROM FamilyTree"
read_rows = read_query(connection, xpath_query)

# display final results
for row in read_rows:
    print(row, end='\n')
