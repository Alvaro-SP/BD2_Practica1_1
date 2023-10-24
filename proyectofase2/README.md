BD2_Proyecto_Fase2    

### <a id="documentation-body"></a>


Modelo MongoDB 
----------------------

#### Esquema:

Nombre del Modelo: Modelo Proyecto Fase 2

Autores: Grupo 1

Version: 1

Utilizando la herramineta: [Hackolade](https://hackolade.com/) - Polyglot data modeling for NoSQL databases, storage formats, REST APIs, and JSON in RDBMS

### <a id="contents"></a>

*   [Tabla de contenido](#)
*   [1\. Modelo](#)
*   [2\. Base de Datos](#)
    *   [2.1 mongodbVSCodePlaygroundDB](#)
        
        *    [2.1.1. Colleciones](#)
        
             * [2.1.1.1 games](#)
        

### <a id="model"></a>

##### 1\. Modelo

##### 1.1. **Detalles** 

<table><tbody><tr><td><span>Nombre Modelo</span></td><td>Modelo Proyecto Fase 2</td></tr><tr><td><span>Technical name</span></td><td>Core Data</td></tr><tr><div class="docs-markdown"></div></td></tr><tr><td><span>Autores</span></td><td>Grupo 1</td></tr><tr><td><span>Version</span></td><td>1</td></tr><tr><td><span>Target</span></td><td>MongoDB</td></tr><tr><td><span>DB version</span></td><td>v6.0</td>
</table>

### <a id="containers"></a>

##### 2\. Databases

### <a id="44b37304-5d2c-4d7d-90c2-52464ab86747"></a>2.1 Base de Datos **mongodbVSCodePlaygroundDB**

<table class="collection-properties-table"><thead><tr><td>Property</td><td>Value</td></tr></thead><tbody><tr><td>Nombre Base de Datos</td><td>mongodbVSCodePlaygroundDB</td></tr><tr><td>Nombre Técnico</td><td>Core Data</td></tr></tbody></table>


![Hackolade image](README/image3.png?raw=Si)



### <a id="44b37304-5d2c-4d7d-90c2-52464ab86747-children"></a>2.1.1 Collecciones **mongodbVSCodePlaygroundDB** 

### <a id="9b63503b-4205-47aa-93f1-0ecf4583695a"></a>2.1.1.1  **games**

<table class="collection-properties-table"><thead><tr><td>Propiedad</td><td>Valor</td></tr></thead><tbody><tr><td>Nombre de la Colección</td><td>games</td></tr><tr</tbody></table>

##### Diagrama de árbol

![Hackolade image](README/image4.png?raw=Si)




##### Campos

<table><thead><tr><td>Campo</td><td>Tipo</td><td>Obligatorio</td><td>Key</td></tr></thead><tbody><tr><td><a href=#37e99b62-28e3-418e-b9c0-12484201beb1 class="margin-0">_id</a></td><td class="no-break-word">objectId</td><td>Si</td><td>pk</td></tr><tr><td><a href=#67e98669-9aca-4369-93d6-1fab56f4b5ff class="margin-0">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#43b544ac-420c-49ce-9acd-e264ee421875 class="margin-0">first_release_date</a></td><td class="no-break-word">integer32</td><td>No</td><td></td></tr><tr><td><a href=#66a26e69-9d01-478d-8472-d743e1b70fc0 class="margin-0">game_modes</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#39b17855-749e-41ae-b8d4-6f4de7b67ec6 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#0a817d89-409e-4dc4-b076-92815c7dd8cc class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#a64dfb9c-4649-43e8-95b7-9384c461ae35 class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#44323187-beed-4038-9295-8cd2bbf4d843 class="margin-0">genres</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#63edbd08-a25a-471f-a60b-c7889bd68aa3 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#ab075c4f-9e16-4115-8022-0e0a7565987c class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#ad40579c-17fd-49db-9c32-a2ffcdeb531e class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#e1c92744-ea6a-404c-a203-9880feb9e6a5 class="margin-0">involved_companies</a></td><td class="no-break-word">array,string</td><td>No</td><td></td></tr><tr><td><a href=#d512a49f-816e-45de-a97b-4e743abdf31e class="margin-5">items</a></td><td class="no-break-word">multipleArray</td><td>No</td><td></td></tr><tr><td><a href=#49f145ad-36eb-4f14-9406-ecadefb99d4d class="margin-10">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#5e6eb3d8-b04e-4c39-8fc2-33051d6c5ef1 class="margin-15">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#63cc3db6-1cbd-430b-a287-0b44e5985f23 class="margin-15">company</a></td><td class="no-break-word">array</td><td>Si</td><td></td></tr><tr><td><a href=#331f2492-53b6-4d07-a590-78f579f445f1 class="margin-20">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#35549215-17d3-4739-a779-3b52d02e86a9 class="margin-25">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#2db6bc7e-0c66-405b-84ab-b00e8b8ac486 class="margin-25">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#3899b35c-2204-4a13-8133-54e7aaa6576a class="margin-25">url</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#0bf87293-19c0-40fb-b02d-e3e44bd8a8e3 class="margin-25">description</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#37382874-b352-4b53-bdf0-c80aaaddc203 class="margin-0">language_supports</a></td><td class="no-break-word">array,string</td><td>No</td><td></td></tr><tr><td><a href=#103bb412-fceb-45c5-ae71-ac3d8cccbf12 class="margin-5">items</a></td><td class="no-break-word">multipleArray</td><td>No</td><td></td></tr><tr><td><a href=#6d49469c-9070-4142-af5a-c511fdd1b84a class="margin-10">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#9b6998fd-9ac5-4126-961a-2ebc9ce3376f class="margin-15">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#2e3dda63-438c-4944-8cb1-8904e5e5dc4e class="margin-15">language</a></td><td class="no-break-word">array</td><td>Si</td><td></td></tr><tr><td><a href=#fa67a4fc-8016-4cb4-977d-cbeb57da3581 class="margin-20">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#4edf6da7-a49e-4408-80f1-b50f42be267e class="margin-25">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#37e876dd-2bf3-455b-b237-ae243665660d class="margin-25">locale</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#594929f2-635a-4750-8670-f106ead20939 class="margin-25">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#e59796c7-3ea0-4103-b7cb-bc939a7fd8c8 class="margin-25">native_name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#e9ad8466-cc76-4f5d-a2b2-26fd8b36769e class="margin-0">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#16fe4ea6-75ce-4e93-92b8-1217863ce62d class="margin-0">platforms</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#aa8a1308-cef3-4b86-b27c-2ca333d1c8b6 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#b823458c-0d34-41ca-8e51-6a67c2468445 class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#b1de3559-5336-4703-99a1-0f4062099dc7 class="margin-10">abbreviation</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#500fdd92-d1e2-40c7-b404-b6f66dcee5b7 class="margin-10">alternative_name</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#b865894d-4f7b-4394-a12d-41126e45faab class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#01d06480-7823-433c-ac97-bd1a25ada106 class="margin-10">summary</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#cb9ad00c-2588-4ec2-bc5a-732c77ee5524 class="margin-0">player_perspectives</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#22f5c7f0-7282-4fa4-a668-7299b9235715 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#1ae56996-a551-4de5-b3f2-8469a09effbb class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#a45f4270-1b81-474b-bf1e-084650f089c9 class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#b07565e2-3e7c-4055-931c-1d00af1ebeff class="margin-0">release_dates</a></td><td class="no-break-word">array,string</td><td>No</td><td></td></tr><tr><td><a href=#68e34bb8-55bd-4ae5-af33-243425dff787 class="margin-5">items</a></td><td class="no-break-word">multipleArray</td><td>No</td><td></td></tr><tr><td><a href=#c0354567-39b2-408c-8c60-9f297fe5c6f8 class="margin-10">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#9c41a173-b5e0-42e6-8632-38a2fa41b0b2 class="margin-15">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#277dc037-7f20-4e44-9c00-be7bc14d4444 class="margin-15">human</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#22b5938b-6361-4b59-82d0-6c2cab51bcfa class="margin-0">summary</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#d2dfd8db-d88b-4782-a000-4f3294cbf2d3 class="margin-0">themes</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#053845cd-4309-4417-b776-66393a523972 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#7825d3c3-0b4b-4917-8a60-613bb55196cd class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#4fb49f2c-e8de-405a-aa5e-5eb27b2ba999 class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#6716fb77-2124-4caa-8ea8-622dfbc9b842 class="margin-0">url</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#daa4a37d-9fba-4c81-9fda-f5bf785766d5 class="margin-0">aggregated_rating</a></td><td class="no-break-word">double</td><td>No</td><td></td></tr><tr><td><a href=#9918ada4-15a3-438a-9baf-6a173ad499e9 class="margin-0">alternative_names</a></td><td class="no-break-word">array,string</td><td>No</td><td></td></tr><tr><td><a href=#c7c43773-5929-48e9-9fe6-701bffbd2359 class="margin-5">items</a></td><td class="no-break-word">multipleArray</td><td>No</td><td></td></tr><tr><td><a href=#88fa1b45-2b62-443a-b87a-86efa3b02b9b class="margin-10">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#32f4e98a-4ee8-48ac-a03d-759585a6f0ba class="margin-15">comment</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#a5fa3314-a084-43cf-b0a3-e08c744ba443 class="margin-15">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#eb96c73d-8e35-49bb-8e22-98a62ef7d0d1 class="margin-15">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#9d1fae13-a6b5-44af-96a0-fd66faa0bfbd class="margin-0">collection</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#b56a3423-b032-4ab1-8dc1-b6c8688ea080 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#0a17158f-13a3-42de-930d-5c5a53ef4b2c class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#ca4a098f-50c7-4152-b90c-74c89178dcf8 class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#73e801a4-fa24-4c1b-aaf8-a094e4a18218 class="margin-10">url</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#3c7d66a2-9e37-4fba-80da-35cbb936da1f class="margin-0">franchises</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#1a664bd3-f33e-490c-b9a1-365578c2cc3a class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#88249cbf-8cc1-4a47-a3ff-23bcbfb66be1 class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#67d171d6-84cc-41a1-b238-1ea1c64203c8 class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#73630579-603d-448b-95ca-fae445c71fe5 class="margin-0">game_engines</a></td><td class="no-break-word">array</td><td>No</td><td></td></tr><tr><td><a href=#c4378535-ae7a-462c-bfaa-c762bb042710 class="margin-5">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#5429bd89-029c-460c-8bb7-a7a589f6b20b class="margin-10">id</a></td><td class="no-break-word">integer32</td><td>Si</td><td></td></tr><tr><td><a href=#09078f0b-064c-49b5-abba-806d16d8587a class="margin-10">name</a></td><td class="no-break-word">string</td><td>Si</td><td></td></tr><tr><td><a href=#5e6cce3c-376e-4014-b1f0-b3698baf3e17 class="margin-0">game_localizations</a></td><td class="no-break-word">array,string</td><td>No</td><td></td></tr><tr><td><a href=#fa163339-3ac7-4239-99ab-4e82044773ab class="margin-5">items</a></td><td class="no-break-word">multipleArray</td><td>No</td><td></td></tr><tr><td><a href=#338192fc-e788-447a-8da4-05af0fdab761 class="margin-10">[0]</a></td><td class="no-break-word">document</td><td>No</td><td></td></tr><tr><td><a href=#eeb9d645-ab4f-4fde-9e70-cfa2103eb5d6 class="margin-15">id</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#fbc5072f-f7e0-4217-acba-99c32513f3b4 class="margin-15">name</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr><tr><td><a href=#3e844708-3a7a-47a3-8312-7c62e8f8cc44 class="margin-15">region</a></td><td class="no-break-word">numeric</td><td>Si</td><td></td></tr><tr><td><a href=#9693d79e-9dd8-4a7c-b780-b380d065a92e class="margin-0">rating</a></td><td class="no-break-word">double</td><td>No</td><td></td></tr><tr><td><a href=#fc17da27-5493-40b4-8316-388af9b5dc31 class="margin-0">rating_count</a></td><td class="no-break-word">integer32</td><td>No</td><td></td></tr><tr><td><a href=#1017e5e1-a321-44b9-bf58-fa35705ee2d9 class="margin-0">storyline</a></td><td class="no-break-word">string</td><td>No</td><td></td></tr></tbody></table>


##### [GAMES] JSON Schema

JSON (JavaScript Object Notation) es un formato de intercambio de datos ampliamente utilizado para representar información estructurada.

JSON Schema es una forma de definir y validar la estructura de los datos en un formato JSON. Proporciona un conjunto de reglas y restricciones que los datos deben cumplir para ser considerados válidos.


```
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "games",
    "properties": {
        "_id": {
            "type": "string",
            "pattern": "^[a-fA-F0-9]{24}$"
        },
        "id": {
            "type": "integer"
        },
        "first_release_date": {
            "type": "integer"
        },
        "game_modes": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "genres": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "involved_companies": {
            "type": [
                "array",
                "string"
            ],
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "number"
                    },
                    "company": {
                        "type": "array",
                        "additionalItems": true,
                        "items": {
                            "type": "object",
                            "properties": {
                                "id": {
                                    "type": "number"
                                },
                                "name": {
                                    "type": "string"
                                },
                                "url": {
                                    "type": "string"
                                },
                                "description": {
                                    "type": "string"
                                }
                            },
                            "additionalProperties": true,
                            "required": [
                                "id",
                                "name",
                                "url"
                            ]
                        }
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "company"
                ]
            },
            "additionalItems": true
        },
        "language_supports": {
            "type": [
                "array",
                "string"
            ],
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "number"
                    },
                    "language": {
                        "type": "array",
                        "additionalItems": true,
                        "items": {
                            "type": "object",
                            "properties": {
                                "id": {
                                    "type": "number"
                                },
                                "locale": {
                                    "type": "string"
                                },
                                "name": {
                                    "type": "string"
                                },
                                "native_name": {
                                    "type": "string"
                                }
                            },
                            "additionalProperties": true,
                            "required": [
                                "id",
                                "locale",
                                "name",
                                "native_name"
                            ]
                        }
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "language"
                ]
            },
            "additionalItems": true
        },
        "name": {
            "type": "string"
        },
        "platforms": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "abbreviation": {
                        "type": "string"
                    },
                    "alternative_name": {
                        "type": "string"
                    },
                    "name": {
                        "type": "string"
                    },
                    "summary": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "player_perspectives": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "release_dates": {
            "type": [
                "array",
                "string"
            ],
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "number"
                    },
                    "human": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "human"
                ]
            },
            "additionalItems": true
        },
        "summary": {
            "type": "string"
        },
        "themes": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "url": {
            "type": "string"
        },
        "aggregated_rating": {
            "type": "number"
        },
        "alternative_names": {
            "type": [
                "array",
                "string"
            ],
            "items": {
                "type": "object",
                "properties": {
                    "comment": {
                        "type": "string"
                    },
                    "id": {
                        "type": "number"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            },
            "additionalItems": true
        },
        "collection": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    },
                    "url": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name",
                    "url"
                ]
            }
        },
        "franchises": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "game_engines": {
            "type": "array",
            "additionalItems": true,
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "integer"
                    },
                    "name": {
                        "type": "string"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "name"
                ]
            }
        },
        "game_localizations": {
            "type": [
                "array",
                "string"
            ],
            "items": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "number"
                    },
                    "name": {
                        "type": "string"
                    },
                    "region": {
                        "type": "number"
                    }
                },
                "additionalProperties": true,
                "required": [
                    "id",
                    "region"
                ]
            },
            "additionalItems": true
        },
        "rating": {
            "type": "number"
        },
        "rating_count": {
            "type": "integer"
        },
        "storyline": {
            "type": "string"
        }
    },
    "additionalProperties": true,
    "required": [
        "_id",
        "id",
        "name",
        "url"
    ]
}
```




##### [GAMES] Target Script 

"Script de Destino" se referirse a un script que permite la cración de la la coleción de la que se este refiriendo en el ámbito de Esquemas NoSQL.


```
use Core Data;

db.createCollection("games", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "games",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "id": {
                    "bsonType": "int"
                },
                "first_release_date": {
                    "bsonType": "int"
                },
                "game_modes": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "genres": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "involved_companies": {
                    "bsonType": [
                        "array",
                        "string"
                    ],
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "number"
                            },
                            "company": {
                                "bsonType": "array",
                                "additionalItems": true,
                                "items": {
                                    "bsonType": "object",
                                    "properties": {
                                        "id": {
                                            "bsonType": "number"
                                        },
                                        "name": {
                                            "bsonType": "string"
                                        },
                                        "url": {
                                            "bsonType": "string"
                                        },
                                        "description": {
                                            "bsonType": "string"
                                        }
                                    },
                                    "additionalProperties": true,
                                    "required": [
                                        "id",
                                        "name",
                                        "url"
                                    ]
                                }
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "company"
                        ]
                    },
                    "additionalItems": true
                },
                "language_supports": {
                    "bsonType": [
                        "array",
                        "string"
                    ],
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "number"
                            },
                            "language": {
                                "bsonType": "array",
                                "additionalItems": true,
                                "items": {
                                    "bsonType": "object",
                                    "properties": {
                                        "id": {
                                            "bsonType": "number"
                                        },
                                        "locale": {
                                            "bsonType": "string"
                                        },
                                        "name": {
                                            "bsonType": "string"
                                        },
                                        "native_name": {
                                            "bsonType": "string"
                                        }
                                    },
                                    "additionalProperties": true,
                                    "required": [
                                        "id",
                                        "locale",
                                        "name",
                                        "native_name"
                                    ]
                                }
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "language"
                        ]
                    },
                    "additionalItems": true
                },
                "name": {
                    "bsonType": "string"
                },
                "platforms": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "abbreviation": {
                                "bsonType": "string"
                            },
                            "alternative_name": {
                                "bsonType": "string"
                            },
                            "name": {
                                "bsonType": "string"
                            },
                            "summary": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "player_perspectives": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "release_dates": {
                    "bsonType": [
                        "array",
                        "string"
                    ],
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "number"
                            },
                            "human": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "human"
                        ]
                    },
                    "additionalItems": true
                },
                "summary": {
                    "bsonType": "string"
                },
                "themes": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "url": {
                    "bsonType": "string"
                },
                "aggregated_rating": {
                    "bsonType": "double"
                },
                "alternative_names": {
                    "bsonType": [
                        "array",
                        "string"
                    ],
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "comment": {
                                "bsonType": "string"
                            },
                            "id": {
                                "bsonType": "number"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    },
                    "additionalItems": true
                },
                "collection": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            },
                            "url": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name",
                            "url"
                        ]
                    }
                },
                "franchises": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "game_engines": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "int"
                            },
                            "name": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "name"
                        ]
                    }
                },
                "game_localizations": {
                    "bsonType": [
                        "array",
                        "string"
                    ],
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "id": {
                                "bsonType": "number"
                            },
                            "name": {
                                "bsonType": "string"
                            },
                            "region": {
                                "bsonType": "number"
                            }
                        },
                        "additionalProperties": true,
                        "required": [
                            "id",
                            "region"
                        ]
                    },
                    "additionalItems": true
                },
                "rating": {
                    "bsonType": "double"
                },
                "rating_count": {
                    "bsonType": "int"
                },
                "storyline": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": true,
            "required": [
                "_id",
                "id",
                "name",
                "url"
            ]
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});

db.games.createIndex({
    "_id": 1
},
{
    "name": "_id_"
});
```



##### [GAMES] Ejemplo JSON data


```
{
    "_id": ObjectId("b7b3adf311fa1af757b3deab"),
    "id": Int32(271396),
    "first_release_date": Int32(1735603200),
    "game_modes": [
        {
            "id": Int32(2),
            "name": "Multiplayer"
        }
    ],
    "genres": [
        {
            "id": Int32(31),
            "name": "Adventure"
        }
    ],
    "involved_companies": [
        {
            "id": -20,
            "company": [
                {
                    "id": -31,
                    "name": "Lorem",
                    "url": "Lorem",
                    "description": "Lorem"
                }
            ]
        }
    ],
    "language_supports": [
        {
            "id": -65,
            "language": [
                {
                    "id": -17,
                    "locale": "Lorem",
                    "name": "Lorem",
                    "native_name": "Lorem"
                }
            ]
        }
    ],
    "name": "Deep Down 2",
    "platforms": [
        {
            "id": Int32(38),
            "abbreviation": "PSP",
            "alternative_name": "PSP",
            "name": "PlayStation Portable",
            "summary": "Lorem"
        }
    ],
    "player_perspectives": [
        {
            "id": Int32(2),
            "name": "Third person"
        }
    ],
    "release_dates": [
        {
            "id": -6,
            "human": "Lorem"
        }
    ],
    "summary": "Keep the fire burning  stay away from the darkness",
    "themes": [
        {
            "id": Int32(34),
            "name": "Educational"
        }
    ],
    "url": "https://www.igdb.com/games/deep-down-2",
    "aggregated_rating": Double(75.75),
    "alternative_names": [
        {
            "comment": "Lorem",
            "id": 8,
            "name": "Lorem"
        }
    ],
    "collection": [
        {
            "id": Int32(1448),
            "name": "Shinobido",
            "url": "https://www.igdb.com/collections/shinobido"
        }
    ],
    "franchises": [
        {
            "id": Int32(2367),
            "name": "The Prince of Tennis"
        }
    ],
    "game_engines": [
        {
            "id": Int32(6),
            "name": "Unreal Engine"
        }
    ],
    "game_localizations": [
        {
            "id": 53,
            "name": "Lorem",
            "region": -99
        }
    ],
    "rating": Double(79.72204051835487),
    "rating_count": Int32(3580),
    "storyline": "In the near future  the latest space observation telescope discovers an enormous comet approaching the solar system. Its calculated trajectory is not in danger of colliding with Earth  but the effects its massive size would have on our planet and the sun are unfathomable. The damage caused by the resulting seismic  volcanic  and electromagnetic activity is catastrophic. In response  a large-scale evacuation plan is carried out. Residents  properties  and city functions in areas determined to be affected are almost all relocated to shelters and other regions. In place of its departed citizenry  unmanned AI defense robots called G-Mechs patrol the abandoned areas  effectively turning them into robot towns. The G-Mechs watch and defend the cities  expelling intruders  preventing robberies and accidents  and ensuring structural collapses and fires do not occur. They are to guard the cities until the comet passes and people can return to their homes.  Here enters Four-Seven Security Service. A security company that is dispatched to robot towns no longer inhabited by humans  Four-Seven Security Service provides a variety of defensive services  including crime prevention  building maintenance and repair  and the extinguishing of fires caused by volcanic eruptions. You are a new employee at the company.  A fellow part-time employee is showing you the ropes as you perform maintenance on a few security G-Mechs. Just then  a large earthquake rattles the area under the company s jurisdiction. You receive word that the security G-Mechs in the area have gone rogue  perhaps as a result of the earthquake. You also learn the rogue G-Mechs are equipped with autonomous AI.  As a member of Four-Seven Security Service  it is now your job to address the situation. You take control of the unit provided by the company and set out to suppress the rogue G-Mechs. Jobs like this are a part of the daily routine for a security company  you think to yourself. Little do you know  however  this will turn out to be a battle that alters the fate of mankind..."
}
```



### <a id="edges"></a>

**_Happy Coding!_**