import csv
# import requests
from requests import post
import re
import pyodbc

server = '35.238.49.198'
database = 'PROYECTO_CLASE'
username = 'grupodb'
password = 'grupodb123'
conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = conn.cursor()

def jalarDatos(url, fields):

    # Nombre del archivo CSV de salida
    name_file = url.split("/")[4]+'.csv'
    # output_file = 'C:/Users/socop/Videos/REPOS TEMP/BD2_Practica1_1/proyecto/CSV_first/'+name_file

    # # Inicializa el archivo CSV y escribe el encabezado
    # with open(output_file, 'w', newline='') as csvfile:
    #     csv_writer = csv.DictWriter(csvfile, fieldnames=fields.split(','))
    #     csv_writer.writeheader()

    # Realiza solicitudes paginadas hasta que no haya más resultados
    offset = 5000
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
            print(f'----------------Terminado----------------')
            break
        c = 'id,change_date,change_date_category,changed_company_id,checksum,country,created_at,description,developed,logo,name,parent,published,slug,start_date,start_date_category,updated_at,url,websites'
        # Agrega los resultados al archivo CSV
        # with open(output_file, 'a', newline='' ,encoding='utf-8') as csvfile:
        #     csv_writer = csv.DictWriter(csvfile, fieldnames=fields.split(','))
        for item in response_json:
            try:
                insert_sql = f"INSERT INTO companies ({c}) VALUES ("
                # Recorrer los campos en la cadena c y agregar los valores de item
                for column_name in c.split(','):
                    column_name = column_name.strip()  # Eliminar espacios en blanco adicionales
                    value = item.get(column_name, None)  # Obtener el valor del campo o None si no existe

                    if value is not None:
                        # Si el valor es una cadena, escapar las comillas simples
                        if isinstance(value, str):
                            value = value.replace("'", "''")
                        insert_sql += f"'{value}', "
                    else:
                        insert_sql += "NULL, "  # Si no hay valor, insertar NULL

                # Eliminar la coma y el espacio extra al final y cerrar la sentencia SQL
                insert_sql = insert_sql.rstrip(", ") + ")"
                cursor.execute(insert_sql)
            except Exception as e:
                # print(item)
                print('Error  -- '+str(offset))
                print(e)
        print(f'¡Guardado {offset} resultados!')
        offset += 500
        conn.commit()

    # Cerrar la conexión
    cursor.close()
    conn.close()
        # if offset == 1000:
        #     break
    


    print(f'¡Datos guardados en {name_file}!')


urls = 'https://api.igdb.com/v4/'



c='id,change_date,change_date_category,changed_company_id,checksum,country,created_at,description,developed,logo,name,parent,published,slug,start_date,start_date_category,updated_at,url,websites'
jalarDatos(urls+'companies',(c))

# tx = '''257070,,,,,,,0,01670c22-1cf4-e7ce-910f-e890bfce7cdf,,316260,1689677277,,,,[2722236],1687478400,,,,,[448],,[1],[31],,[223174],[27825],,,For Elise,,[6],[3],,,,[495006],,,"[1090727, 1090728]","[257071, 257072, 257073, 257086, 257087, 257088, 257090, 257193, 257194, 257196]",for-elise,,,,"There's something I wanted to make for that one person.
# I wanted to make something for Elise...

# A Yume Nikki fangame developed for the Dream Diary Jam 7.","[268435487, 536898737]",,,,1689858378,https://www.igdb.com/games/for-elise,,,,"[565789, 565790]"'''
# tclean = tx.replace('\n', '')
# print(tclean)
print("=========================================FIN=========================================")

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

# c = 'checksum,created_at,name,slug,updated_at,url'
# jalarDatos(urls+'themes',("id,"+c))


                # if 'summary' in item and item['summary'] is not None:
                #     # print("--------------------------------------------")
                #     otra = str(item['summary'])
                #     # print("otra: [["+otra+"]]")
                #     a = otra
                #     a = otra.replace(',', ' ')
                #     a = otra.replace('\"', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n', ' ')
                #     a = otra.replace('\n\n', ' ')
                #     a = a.replace('\r', ' ')
                #     a = a.replace('\s', ' ')
                #     a = a.replace('\t', ' ')
                #     a = a.replace('\v', ' ')
                #     a = a.replace('\f', ' ')
                #     a = a.replace('\b', ' ')
                #     a = a.replace('\a', ' ')
                #     a = a.replace('\e', ' ')
                #     a = a.replace('\0', ' ')
                #     a = a.replace('\1', ' ')
                #     a = a.replace('\2', ' ')
                #     a = a.replace('\3', ' ')
                #     a = a.replace('\4', ' ')
                #     a = a.replace('\ñ', ' ')
                #     a = re.sub(r'[\x00-\x1F\x7F-\x9F]', ' ', a)
                #     a = a.replace(',', ' ')
                #     a = a.replace('\"', ' ')
                #     a = re.sub(r'\s+', ' ', a)
                #     a = a.rstrip()
                #     # print("a: [["+a+"]]")
                #     item['summary'] = a
                # csv_writer.writerow(item)