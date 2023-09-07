import csv
# import requests
from requests import post

def jalarDatos(url, fields):

    # Nombre del archivo CSV de salida
    name_file = url.split("/")[4]+'.csv'
    output_file = 'B:\GitHub\BD2_Practica1_1\proyecto\Sergie\\'+name_file

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
            print(f'-----Terminado-----')
            break

        # Agrega los resultados al archivo CSV
        with open(output_file, 'a', newline='' ,encoding='utf-8') as csvfile:
            csv_writer = csv.DictWriter(csvfile, fieldnames=fields.split(','))
            for item in response_json:
                try:
                    csv_writer.writerow(item)
                except:
                    print(item)
                    print('Error  -- '+str(offset))
        print(f'¡Guardado {offset} resultados!')
        offset += 500

        if offset == 1000:
            break


    print(f'¡Datos guardados en {name_file}!')


urls = 'https://api.igdb.com/v4/'

# c = 'checksum,created_at,locale,name,native_name,updated_at'
# jalarDatos(urls+'languages',("id,"+c))

# c = 'campaigncoop,checksum,dropin,game,lancoop,offlinecoop,offlinecoopmax,offlinemax,onlinecoop,onlinecoopmax,onlinemax,platform,splitscreen,splitscreenonline'
# jalarDatos(urls+'multiplayer_modes',("id,"+c))

# c = 'abbreviation,alternative_name,category,checksum,created_at,generation,name,platform_family,platform_logo,slug,summary,updated_at,url,versions,websites'
# jalarDatos(urls+'platforms',("id,"+c))

# c = 'checksum,name,slug'
# jalarDatos(urls+'platform_families',("id,"+c))

# c = 'checksum,companies,connectivity,cpu,graphics,main_manufacturer,media,memory,name,online,os,output,platform_logo,platform_version_release_dates,resolutions,slug,sound,storage,summary,url'
# jalarDatos(urls+'platform_versions',("id,"+c))

# c = 'checksum,comment,company,developer,manufacturer'
# jalarDatos(urls+'platform_version_companies',("id,"+c))

# c = 'category,checksum,created_at,date,human,m,platform_version,region,updated_at,y'
# jalarDatos(urls+'platform_version_release_dates',("id,"+c))

# c = 'category,checksum,trusted,url'
# jalarDatos(urls+'platform_websites',("id,"+c))

# c = 'checksum,created_at,name,slug,updated_at,url'
# jalarDatos(urls+'player_perspectives',("id,"+c))

# c = 'category,checksum,created_at,identifier,name,updated_at'
# jalarDatos(urls+'regions',("id,"+c))

# c = 'category,checksum,created_at,date,game,human,m,platform,region,status,updated_at,y'
# jalarDatos(urls+'release_dates',("id,"+c))

# c = 'checksum,created_at,description,name,updated_at'
# jalarDatos(urls+'release_date_statuses',("id,"+c))

# c = 'alternative_name,character,checksum,collection,company,description,game,name,platform,published_at,test_dummy,theme'
# jalarDatos(urls+'search',("id,"+c))

# c = 'category,checksum,game,trusted,url'
# jalarDatos(urls+'websites',("id,"+c))

c = 'checksum,created_at,name,slug,updated_at,url'
jalarDatos(urls+'themes',("id,"+c))




