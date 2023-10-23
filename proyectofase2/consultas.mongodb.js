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

// ! AQUI VOY A INSERTAR TODA LA DATA QUE GENERE EL JSON
// mongoimport --uri "mongodb+srv://3034161730108:dqUeDQxkCYEQDucE@fase2grupo1mongo.qzzcnmt.mongodb.net/" --file 'E:\U
// sers\PC\Downloads\CSV_fase2\rich_games_optimized.json' -d mongodbVSCodePlaygroundDB -c games --jsonArray --drop

use('mongodbVSCodePlaygroundDB');
// * CONSULTA 1
const c1 = db.getCollection('games').find({}, //buscar todos los documentos en tu colección.
    { name: 1, "platforms.name": 1, rating: 1, "genres.name": 1 })//campos a mostrar
    .sort({ rating: -1 }) //ordenar los juegos en orden descendente según la valoración (Rating). Esto significa que los juegos con la valoración más alta aparecerán primero.
    .limit(100); //  limitar los resultados a los 100 primeros juegos en función de su valoración.

c1.forEach(function (item) {
    console.log("Name:", item.name);
    if (item.genres) {
        console.log("Genres:");
        for (const genre of item.genres) {
            console.log("  -" + genre.name);
        }
    }
    if (item.platforms) {
        console.log("Platforms:");
        for (const platform of item.platforms) {
            console.log("  -" + platform.name);
        }
    }
    console.log("Rating:", item.rating);
    console.log("----------------------");
});