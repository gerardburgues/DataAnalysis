import pandas
import psycopg2

pandas.set_option('display.max_columns',14)
from psycopg2 import Error

conn = psycopg2.connect(

    host="localhost",
    database="Opposite",
    user="gerardburgues",
    password=""
)
try:
    # Connect to an existing database
    conn = psycopg2.connect(

        host="localhost",
        database="Opposite",
        user="gerardburgues",
        password=""
    )

    # Create a cursor to perform database operations
    cursor = conn.cursor()
    # Print PostgreSQL details
    print("PostgreSQL server information")
    print(conn.get_dsn_parameters(), "\n")
    # Executing a SQL query
    cursor.execute("SELECT version();")
    # Fetch result
    record = cursor.fetchone()
    print("You are connected to - ", record, "\n")

except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
def create_pandas_table(sql_query, database = conn):
    table= pandas.read_sql_query(sql_query,database)
    for index, row in table.iterrows():
        if row["sexo"] == "Hombre":
            row["sexo"] = "H"
        else:
            row["sexo"] = "M"
        if row["population"] == "Más de 600.000":
            row["population"]="+600.000"
        elif row["population"] == "Entre 200.000 y 600.000":
            row["population"] = "Between_200/600"
        elif row["population"] == "Entre 50.000 y 200.000":
            row["population"] = "Between_50/200"
        else: row["population"] = "-50.000"

        if row["exerciseTimes"] == "Entre 1 y 2":
            row["exerciseTimes"] ="1/2"
        elif row["exerciseTimes"] == "Entre 3 y 4":
            row["exerciseTimes"] ="3/4"
        elif row["exerciseTimes"] == "Más de 4":
            row["exerciseTimes"] ="+4"
        else: row["exerciseTimes"] = "None"


        if row["exerciseWhere"] == "En casa":
            row["exerciseWhere"]  = "Home"
        elif row["exerciseWhere"] == "En el aire libre":
            row["exerciseWhere"]  = "Outside"
        elif row["exerciseWhere"] == "En un gimnasio":
            row["exerciseWhere"]  = "Gym"
        elif row["exerciseWhere"] == "En casa;En un gimnasio":
            row["exerciseWhere"]  = "Home/Gym"
        elif row["exerciseWhere"] == "En casa;En el aire libre":
            row["exerciseWhere"]  = "Home/Outside"
        elif row["exerciseWhere"] == "En el aire libre;En un gimnasio":
            row["exerciseWhere"]  = "Outside/Gym"
        else: row["exerciseWhere"] = "Home/Outside/Gym"

        if row["afterPandemic"] == "NS/NC":
            row["afterPandemic"] = "NoAnswer"

        if row["trainingType"] == "Cardiovascular":
            row["trainingType"] = "Cardio"
        elif row["trainingType"] == "Musculación (levantamiento de pesas)":
            row["trainingType"] = "WeightLifting"
        elif row["trainingType"] == "Tonificación":
            row["trainingType"] = "Tone"
        elif row["trainingType"] == "Musculación (levantamiento de pesas);Cardiovascular":
            row["trainingType"] = "WeightLifting/Cardio"
        elif row["trainingType"] == "Musculación (levantamiento de pesas);Tonificación":
            row["trainingType"] = "WeightLifting/Tone"
        elif row["trainingType"] == "Musculación (levantamiento de pesas);Tonificación;Cardiovascular":
            row["trainingType"] = "WeightLifting/Tone/Cardio"
        elif row["trainingType"] == "Tonificación;Cardiovascular":
            row["trainingType"] = "Tone/Cardio"

        if row["application"] == "Sí":
            row["application"] = "Yes"

        if row["fitnessChannel"] == "Sí":
            row["fitnessChannel"] = "Yes"

        if row["classes"] == "A veces":
            row["classes"] = "Sometimes"
        elif row["classes"] == "Sí":
            row["classes"] = "Yes"

        if row["individualSpace"] == "Sí":
            row["individualSpace"] = "Yes"

        if row["price"] == "Entre 20 y 30":
            row["price"] = "20/30"
        elif row["price"] == "Entre 20 y 30;No lo utilizaría":
            row["price"] ="20/30/NotUse"
        elif row["price"] == "Entre 20 y 30;Entre 30 y 40":
            row["price"] = "20/40"
        elif row["price"] == "Entre 30 y 40":
            row["price"] = "30/40"
        elif row["price"] == "Más de 40":
            row["price"] = "+40"
        else: row["price"] = "NotUse"

        if row["homeorIndividual"] == "En el espacio mencionado anteriormente":
            row["homeorIndividual"] = "individual"
        elif row["homeorIndividual"] == "En casa;En el espacio mencionado anteriormente":
            row["homeorIndividual"] = "Home/individual"
        else: row["homeorIndividual"] = "Home"



    return table


table_info = create_pandas_table("Select * from table1")

df = pandas.DataFrame(data=table_info)
print(df)
df.to_csv("transformedData.csv")

