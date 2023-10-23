import json

import json
from pymongo import MongoClient

# Conecta a la base de datos MongoDB
client = MongoClient('mongodb+srv://3034161730108:dqUeDQxkCYEQDucE@fase2grupo1mongo.qzzcnmt.mongodb.net/')
db = client['mongodbVSCodePlaygroundDB']
# Lee el archivo JSON completo y carga los datos en una lista
data = []
with open('E:\\Users\\PC\\Downloads\\CSV_fase2\\rich_games_optimized.json', 'r') as file:
    try:
        data = json.load(file)
    except json.decoder.JSONDecodeError as e:
        print(f'Error al cargar el archivo JSON: {e}')

# Inserta los datos en MongoDB
if data:
    collection = db['games']
    result = collection.insert_many(data)
    print(f'Inserción completada. Se insertaron {len(result.inserted_ids)} documentos.')

client.close()  # Cierra la conexión a MongoDB cuando hayas terminado