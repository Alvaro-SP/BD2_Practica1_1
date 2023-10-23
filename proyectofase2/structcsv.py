import csv
# import requests
from requests import post

def jalarDatos(url, fields):
    headers = {
        'Client-ID': 'id9o6yogun0iffjhw6ir4fcby7riop',
        'Authorization': 'Bearer qr1028wr9ak8of1fm43nmx0891sjt2'
    }
    # Nombre del archivo CSV de salida
    output_file = url.split("/")[4]+'.csv'

    # Inicializa el archivo CSV y escribe el encabezado
    with open(output_file, 'w', newline='') as csvfile:
        csv_writer = csv.DictWriter(csvfile, fieldnames=fields.split(','))
        csv_writer.writeheader()

    # Realiza solicitudes paginadas hasta que no haya más resultados
    offset = 0
    while True:
        response = post(url, **{
                'headers': {
                    'Client-ID': 'id9o6yogun0iffjhw6ir4fcby7riop',
                    'Authorization': 'Bearer qr1028wr9ak8of1fm43nmx0891sjt2'
                },
                'data': 'fields '+fields+'; limit 500;'+f' offset {offset};'
            }
            )
        response_json = response.json()

        # Verifica si hay resultados
        if not response_json:
            break

        # Agrega los resultados al archivo CSV
        with open(output_file, 'a', newline='' ,encoding='utf-8') as csvfile:
            csv_writer = csv.DictWriter(csvfile, fieldnames=fields.split(','))
            for item in response_json:
                try:
                    # Verificar si el campo "summary" no es None antes de aplicar sustituciones.
                    if item.get('description') is not None:
                        quitar = item['description'].replace('\n', ' ').replace('\r', '').replace('\'', ' ').replace('\"', ' ').replace(';', ' ').replace(',', ' ')
                        # cambiar el valor de summary
                        item['description'] = quitar
                    # if item.get('storyline') is not None:
                    #     quitar = item['storyline'].replace('\n', ' ').replace('\r', '').replace('\'', ' ').replace('\"', ' ').replace(';', ' ').replace(',', ' ')
                    #     # cambiar el valor de summary
                    #     item['storyline'] = quitar
                    csv_writer.writerow(item)
                except:
                    print(item)
                    print('Error  -- '+str(offset))
        print(f'¡Guardado {offset} resultados!')
        offset += 500


    print(f'¡Datos guardados en {output_file}!')


urls = 'https://api.igdb.com/v4/'
# jalarDatos('https://api.igdb.com/v4/age_ratings', 'category,checksum,content_descriptions,rating,rating_cover_url,synopsis')
# c = 'category,checksum,description'
# jalarDatos(urls+'age_rating_content_descriptions',("id,"+c))

# c = 'checksum,comment,game,name'
# jalarDatos(urls+'alternative_names',("id,"+c))

# c = 'alpha_channel,animated,checksum,game,height,image_id,url,width'
# jalarDatos(urls+'artworks',("id,"+c))

# c = 'akas,checksum,country_name,created_at,description,games,gender,mug_shot,name,slug,species,updated_at,url'
# jalarDatos(urls+'characters',("id,"+c))

# c = 'alpha_channel,animated,checksum,height,image_id,url,width'
# jalarDatos(urls+'character_mug_shots',("id,"+c))

# c = 'checksum,created_at,games,name,slug,updated_at,url'
# jalarDatos(urls+'collections',("id,"+c))

c = 'change_date,change_date_category,changed_company_id,checksum,country,created_at,description,developed,logo,name,parent,published,slug,start_date,start_date_category,updated_at,url,websites'
jalarDatos(urls+'companies',("id,"+c))

# c = 'alpha_channel,animated,checksum,height,image_id,url,width'
# jalarDatos(urls+'company_logos',("id,"+c))

# c = 'category,checksum,trusted,url'
# jalarDatos(urls+'company_websites',("id,"+c))

# c = 'alpha_channel,animated,checksum,game,game_localization,height,image_id,url,width'
# jalarDatos(urls+'covers',("id,"+c))

# c = 'category,checksum,countries,created_at,game,media,name,platform,uid,updated_at,url,year'
# jalarDatos(urls+'external_games',("id,"+c))

# c = 'checksum,created_at,games,name,slug,updated_at,url'
# jalarDatos(urls+'franchises',("id,"+c))

# c = 'age_ratings,aggregated_rating,aggregated_rating_count,alternative_names,artworks,bundles,category,checksum,collection,cover,created_at,dlcs,expanded_games,expansions,external_games,first_release_date,follows,forks,franchise,franchises,game_engines,game_localizations,game_modes,genres,hypes,involved_companies,keywords,language_supports,multiplayer_modes,name,parent_game,platforms,player_perspectives,ports,rating,rating_count,release_dates,remakes,remasters,screenshots,similar_games,slug,standalone_expansions,status,storyline,summary,tags,themes,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites'
# jalarDatos(urls+'games',("id,"+c))

# c = 'checksum,companies,created_at,description,logo,name,platforms,slug,updated_at,url'
# jalarDatos(urls+'game_engines',("id,"+c))