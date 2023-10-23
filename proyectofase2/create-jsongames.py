import pandas as pd
import json

# Cargar los datos de juegos y franquicias desde los archivos CSV
juegos_data = pd.read_csv('games.csv')
alternative_names_data = pd.read_csv('alternative_names.csv')
companies_data = pd.read_csv('companies.csv')
collections_data = pd.read_csv('collections.csv')
game_localizations_data = pd.read_csv('game-localizations.csv')
game_engines_data = pd.read_csv('game_engines.csv')
game_modes_data = pd.read_csv('game-mode.csv')
genre_data = pd.read_csv('genre.csv')
language_support_data = pd.read_csv('language-support.csv')
languages_data = pd.read_csv('languages.csv')
platforms_data = pd.read_csv('platforms.csv')
player_perspectives_data = pd.read_csv('player_perspectives.csv')
release_dates_data = pd.read_csv('release_dates.csv')
themes_data = pd.read_csv('themes.csv')
involved_companies_data = pd.read_csv('involved-company.csv')
franchises_data = pd.read_csv("franchises.csv")
def quitarNan(data):
    # Iterar a través de las claves del diccionario
    keys_to_remove = []
    for key, value in data.items():
        if pd.isna(value) or (isinstance(value, str) and value.strip() == 'nan'):
            keys_to_remove.append(key)
    # Eliminar las claves con valores NaN
    for key in keys_to_remove:
        data.pop(key, None)
    return data

# Función para limpiar una lista en un atributo específico
def limpiar_lista(data, attribute_name, file_data):
    # print(attribute_name)
    values = data.get(attribute_name, '')
    
    # ----
    # print(values)
    if pd.isna(values) or values.strip() == 'nan':
        data[attribute_name] = None
    else:
        values = values.replace('[', '')
        values = values.replace(']', '')
        values = values.replace('\"', '')
        values = values.replace('\'', '')
        values = values.split(',')
        values_cleaned = []
        
        for value in values:
            if value.strip("[]"):  # Verifica si la cadena no está vacía
                value = int(value.strip("[]"))
            matching_data = file_data[file_data['id'] == value].to_dict(orient='records')
            if matching_data:
                if attribute_name == 'game_modes':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name"]}]
                elif attribute_name == 'involved_companies':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "company"]}]
                    for matching_item in matching_data:
                        # print(matching_item)
                        values2 = matching_item.get("company",None)
                        # print(values2)
                        if pd.isna(values2) or values2 == 'nan':
                            matching_item["company"] = None
                        else:
                            values_cleaned2 = []
                            
                            value2 = int(values2)
                            matching_data2 = companies_data[companies_data['id'] == value2].to_dict(orient='records')
                            if matching_data2:
                                first_matching_item = matching_data2[0]  # Acceder al primer elemento de la lista
                                matching_data2 = [{key: first_matching_item.get(key, None) for key in ["id", "description","name","url"]}]
                                values_cleaned2.append(quitarNan(matching_data2[0]))
                            matching_item["company"] = values_cleaned2
                elif attribute_name == 'language_supports':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "language"]}]
                    for matching_item in matching_data:
                        # print(matching_item)
                        values2 = matching_item.get("language",None)
                        # print(values2)
                        if pd.isna(values2) or values2 == 'nan':
                            matching_item["language"] = None
                        else:
                            values_cleaned2 = []
                            
                            value2 = int(values2)
                            matching_data2 = languages_data[languages_data['id'] == value2].to_dict(orient='records')
                            if matching_data2:
                                first_matching_item = matching_data2[0]  # Acceder al primer elemento de la lista
                                matching_data2 = [{key: first_matching_item.get(key, None) for key in ["id", "locale","name","native_name"]}]
                                values_cleaned2.append(quitarNan(matching_data2[0]))
                            matching_item["language"] = values_cleaned2
                elif attribute_name == 'genres':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name"]}]
                elif attribute_name == 'platforms':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "abbreviation","alternative_name","name","summary"]}]
                elif attribute_name == 'release_dates':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id","human"]}]
                elif attribute_name == 'themes':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name"]}]
                elif attribute_name == 'player_perspectives':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name"]}]
                elif attribute_name == 'collection':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name","url"]}]
                elif attribute_name == 'game_engines':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "description","name"]}]
                elif attribute_name == 'game_localizations':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name","region"]}]
                elif attribute_name == 'alternative_names':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "comment","name"]}]
                elif attribute_name == 'franchises':
                    first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                    matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name"]}]
                values_cleaned.append(quitarNan(matching_data[0]))
        if values_cleaned:
            data[attribute_name] = values_cleaned


# Definir una función para enriquecer un juego con información de franquicias
def enrich_game_with_info(game_info, atributos_deseados):
    # Iterar a través de las claves del diccionario
    game_info = {key: game_info.get(key, None) for key in atributos_deseados}
    game_info = quitarNan(game_info)
    limpiar_lista(game_info, 'alternative_names', alternative_names_data)
    # limpiar_lista(game_info, 'themes', companies_data)
    # limpiar_lista(game_info, 'collection', collections_data)
    limpiar_lista(game_info, 'game_localizations', game_localizations_data)
    limpiar_lista(game_info, 'game_engines', game_engines_data)
    limpiar_lista(game_info, 'game_modes', game_modes_data)
    limpiar_lista(game_info, 'genres', genre_data)
    limpiar_lista(game_info, 'language_supports', language_support_data)
    limpiar_lista(game_info, 'platforms', platforms_data)
    limpiar_lista(game_info, 'player_perspectives', player_perspectives_data)
    limpiar_lista(game_info, 'release_dates', release_dates_data)
    limpiar_lista(game_info, 'themes', themes_data)
    limpiar_lista(game_info, 'involved_companies', involved_companies_data)
    limpiar_lista(game_info, 'franchises', franchises_data)

    values = game_info.get("collection", '')
    # print(values)
    if pd.isna(values) or values == 'nan':
        game_info["collection"] = None
    else:
        values_cleaned = []
        if values:  # Verifica si la cadena no está vacía
            value = int(values)
            matching_data = collections_data[collections_data['id'] == value].to_dict(orient='records')
            if matching_data:
                first_matching_item = matching_data[0]  # Acceder al primer elemento de la lista
                matching_data = [{key: first_matching_item.get(key, None) for key in ["id", "name","url"]}]
                values_cleaned.append(quitarNan(matching_data[0]))
            game_info["collection"] = values_cleaned
    # platforms_ids = game_info.get('platforms', '')
    # print(platforms_ids)
    #  # Manejar el caso de NaN o valores faltantes
    # if pd.isna(platforms_ids) or platforms_ids.strip() == 'nan':
    #     game_info['platforms'] = None
    # else:
    #     platforms_ids = platforms_ids.replace('[', '')
    #     platforms_ids = platforms_ids.replace(']', '')
    #     platforms_ids = platforms_ids.split(',')
    #     print(platforms_ids)
    #     platform_info = []
    #     print("--------------------------------------------------------")
    #     for platform_id in platforms_ids:
    #         platform_id = int(platform_id.strip("[]"))
    #         matching_platform = platforms_data[platforms_data['id'] == platform_id].to_dict(orient='records')
    #         if matching_platform:
    #             platform_info.append(quitarNan(matching_platform[0]))
    #     game_info['platforms'] = platform_info
    return game_info

# Crear una lista para almacenar los juegos enriquecidos
rich_games = []

# ! START OF THE PROGRAM
# Iterar a través de todos los juegos en el archivo CSV
# Lista de atributos deseados
atributos_deseados = ["id", "aggregated_rating", "alternative_names", "collection", "first_release_date", "franchises", "game_engines", "game_localizations", "game_modes", "genres", "involved_companies", "language_supports", "name", "platforms", "player_perspectives", "rating", "rating_count", "release_dates", "storyline", "summary", "themes", "url"]

for index, game_row in juegos_data.iterrows():
    game_info = enrich_game_with_info(game_row.to_dict(), atributos_deseados)
    rich_games.append(game_info)

# Reemplazar NaN por None (null) en la lista de juegos enriquecidos
rich_games = [None if pd.isna(value) else value for value in rich_games]

# Guardar la lista de juegos enriquecidos en un archivo JSON
with open('rich_games_optimized.json', 'w') as json_file:
    json.dump(rich_games, json_file, indent=4)

print('Información de juegos enriquecida y guardada en rich_games.json')
