/* global use, db */
// MongoDB Playground
// To disable this template go to Settings | MongoDB | Use Default Template For Playground.
// Make sure you are connected to enable completions and to be able to run a playground.
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.
// The result of the last command run in a playground is shown on the results panel.
// By default the first 20 documents will be returned with a cursor.
// Use 'console.log()' to print to the debug output.
// For more documentation on playgrounds please refer to
// https://www.mongodb.com/docs/mongodb-vscode/playgrounds/

// Select the database to use.
use('mongodbVSCodePlaygroundDB');

// Insert a few documents into the sales collection.
db.getCollection('games').insertMany([
    {
        "_id": 1,
        "nombre_juego": "Juego 1",
        "ids_empresa": [4, 5, 78, 7, 8]
    }
]);
// Insert a few documents into the sales collection.
db.getCollection('empresas').insertMany([
    {
        "_id": 4,
        "nombre_empresa": "Empresa A",
        "telefono": "123-456-789",
        "otros_campos": "Otros datos"
    },
    {
        "_id": 5,
        "nombre_empresa": "Empresa B",
        "telefono": "987-654-321",
        "otros_campos": "Otros datos"
    },
    {
        "_id": 7,
        "nombre_empresa": "Empresa C",
        "telefono": "555-555-555",
        "otros_campos": "Otros datos"
    },
    {
        "_id": 8,
        "nombre_empresa": "Empresa D",
        "telefono": "111-222-333",
        "otros_campos": "Otros datos"
    }
]);



const salesOnApril4th = db.getCollection('games').aggregate([
    {
        $unwind: "$ids_empresa"
    },
    {
        $lookup: {
            from: "empresas",
            localField: "ids_empresa",
            foreignField: "_id",
            as: "empresa_info"
        }
    },
    {
        $unwind: "$empresa_info"
    },
    {
        $group: {
            _id: "$_id",
            nombre_juego: { $first: "$nombre_juego" },
            empresas: { $push: "$empresa_info" }
        }
    }
])
console.log(salesOnApril4th.toArray());