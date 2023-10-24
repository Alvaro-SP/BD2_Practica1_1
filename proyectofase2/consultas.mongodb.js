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
use("mongodbVSCodePlaygroundDB");

// ! AQUI VOY A INSERTAR TODA LA DATA QUE GENERE EL JSON
// mongoimport --uri "mongodb+srv://3034161730108:dqUeDQxkCYEQDucE@fase2grupo1mongo.qzzcnmt.mongodb.net/" --file 'E:\U
// sers\PC\Downloads\CSV_fase2\rich_games_optimized.json' -d mongodbVSCodePlaygroundDB -c games --jsonArray --drop

// * CONSULTA 1
// use('mongodbVSCodePlaygroundDB');
// const c1 = db.getCollection('games').find({}, //buscar todos los documentos en tu colección.
//     { name: 1, "platforms.name": 1, rating: 1, "genres.name": 1 })//campos a mostrar
//     .sort({ rating: -1 }) //ordenar los juegos en orden descendente según la valoración (Rating). Esto significa que los juegos con la valoración más alta aparecerán primero.
//     .limit(100); //  limitar los resultados a los 100 primeros juegos en función de su valoración.

// c1.forEach(function (item) {
//     console.log("Name:", item.name);
//     if (item.genres) {
//         console.log("Genres:");
//         for (const genre of item.genres) {
//             console.log("  -" + genre.name);
//         }
//     }
//     if (item.platforms) {
//         console.log("Platforms:");
//         for (const platform of item.platforms) {
//             console.log("  -" + platform.name);
//         }
//     }
//     console.log("Rating:", item.rating);
//     console.log("----------------------");
// });

// * CONSULTA GENERAL
use("mongodbVSCodePlaygroundDB");
const searchGameByName = (name) => {
    const regex = new RegExp(name, 'i'); // 'i' para que la búsqueda no distinga entre mayúsculas y minúsculas
    const query = { name: { $regex: regex } };

    const results = db.getCollection('games').find(query).limit(100).toArray();

    return results;
};

// Llamar a la función para buscar juegos por nombre
//const searchResults = searchGameByName('Super'); // Cambia 'Super Mario' por el nombre que desees buscar
function convertirFechaUnixATexto(fechaInt) {
    // Convierte la fecha INT a DATETIME
    const fecha = new Date(fechaInt * 1000); // Multiplicamos por 1000 para convertir segundos a milisegundos

    // Formatea la fecha en un formato legible (ISO 8601)
    const fechaTexto = fecha.toISOString(); // Esto da formato en "YYYY-MM-DDTHH:MM:SS.sssZ"

    return fechaTexto;
}
// Imprimir los resultados
/*searchResults.forEach(function (item) {
    console.log('Name:' + item.name);
    if (item.first_release_date) {
        console.log('First release date:', convertirFechaUnixATexto(item.first_release_date));
    }
    if (Array.isArray(item.alternative_names)) {
        console.log('alternative_names:', item.alternative_names.map(platform => '\t - ' + platform.name + '--' + platform.comment).join(', '));
    }
    console.log('Genres:', item.genres && item.genres.length > 0 ? item.genres.map(genre => '\t - ' + genre.name).join(', ') : 'No genres available');
    if (Array.isArray(item.platforms)) {
        console.log('Platforms:', item.platforms.map(platform => '\t - ' + platform.name).join(', '));
    }
    if (item.rating) {
        console.log('Rating:' + item.rating);
    }
    if (item.aggregated_rating) {
        console.log('aggregated_rating:' + item.aggregated_rating);
    }
    if (item.rating_count) {
        console.log('rating_count:' + item.rating_count);
    }
    if (item.summary) {
        console.log('summary:' + item.summary);
    }
    if (Array.isArray(item.release_dates)) {
        console.log('release_dates:', item.release_dates.map(release => '\t - ' + release.human).join(', '));
    }
    if (Array.isArray(item.involved_companies)) {
        console.log('involved_companies:', item.involved_companies.map(r => {
            if (Array.isArray(r.company)) {
                return r.company.map(w => w.name).join(', ');
            }
        }));
    }
    if (Array.isArray(item.genres)) {
        console.log('genres:', item.genres.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.themes)) {
        console.log('themes:', item.themes.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.game_modes)) {
        console.log('game_modes:', item.game_modes.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.player_perspectives)) {
        console.log('player_perspectives:', item.player_perspectives.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.collection)) {
        console.log('collection:', item.collection.map(g => '\t - ' + g.name).join(', '));
    }
    if (item.storyline) {
        console.log('storyline:', item.storyline);
    }
    if (Array.isArray(item.franchises)) {
        console.log('franchises:', item.franchises.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.game_engines)) {
        console.log('game_engines:', item.game_engines.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.game_localizations)) {
        console.log('game_localizations:', item.game_localizations.map(g => '\t - ' + g.name).join(', '));
    }
    if (Array.isArray(item.language_supports)) {
        console.log('game_localizations:', item.language_supports.map(r => {
            if (Array.isArray(r.language)) {
                return r.language.map(w => w.name + " " + w.locale).join(', ');
            }
        }));
    }

    console.log('----------------------');
});

*/

// Query 2:
/*const query2 = (name, minWordLength) => {
	// Create a regex to find a coincidence of a word in a specific words by length
	const regex = new RegExp(`\\b\\w{${minWordLength},}\\w*${name}\\w*`, "i");
	// The query
	const query = {
		name: {
			$regex: regex,
		},
	};
	// Find all the games
	const results = db.getCollection("games").find(query).toArray();
	return results;
};

// Get the search results.
const query2Results = query2("The", 8);

// Print the results.
query2Results.forEach(function (item) {
	console.log("Name:" + item.name);
	if (Array.isArray(item.platforms)) {
		console.log(
			"Platforms:",
			item.platforms.map((platform) => "\t - " + platform.name).join(", ")
		);
	}
	if (item.rating) {
		console.log("Rating:" + item.rating);
	}
	if (item.aggregated_rating) {
		console.log("aggregated_rating:" + item.aggregated_rating);
	}
	if (item.rating_count) {
		console.log("rating_count:" + item.rating_count);
	}
	if (item.summary) {
		console.log("summary:" + item.summary);
	}
	if (Array.isArray(item.genres)) {
		console.log("genres:", item.genres.map((g) => "\t - " + g.name).join(", "));
	}
	if (Array.isArray(item.game_modes)) {
		console.log(
			"game_modes:",
			item.game_modes.map((g) => "\t - " + g.name).join(", ")
		);
	}
	if (Array.isArray(item.franchises)) {
		console.log(
			"franchises:",
			item.franchises.map((g) => "\t - " + g.name).join(", ")
		);
	}
	if (Array.isArray(item.game_engines)) {
		console.log(
			"game_engines:",
			item.game_engines.map((g) => "\t - " + g.name).join(", ")
		);
	}
	console.log("****************************************************************************************");
});*/




// Query 3:
/*const query3 = (name) => {
	// The regex
	const regex = new RegExp(name, 'i');
	// The query
	const query = {
		name: {
			$regex: regex,
		},
	};
	// Find all the games
	const results = db.getCollection("games").find(query).toArray();
	return results;
};

// Get the search results.
const query3Results = query3("The Legend");

// Print the results.
query3Results.forEach(function (item) {
    console.log("****************************************************************************************");
	console.log("\nName:" + item.name);
	if (Array.isArray(item.platforms)) {
		console.log(
			"\nPlatforms:\n",
			item.platforms.map((platform) => "\tPlatform name: " + platform.name+ " --- Platform Abbreviation: "+platform.abbreviation).join("\n"),
		);
	}else{
        console.log("\nPlatforms:" + " No information");
    }
	if (item.rating) {
		console.log("\nRating:" + item.rating);
	}else{
        console.log("\nRating:" + " No information");
    }
	if (item.aggregated_rating) {
		console.log("\naggregated_rating:" + item.aggregated_rating);
	}else{
        console.log("\naggregated_rating:" + " No information");
    }
	if (item.rating_count) {
		console.log("\nrating_count:" + item.rating_count);
	}else{
        console.log("\nrating_count:" + " No information");
    }
	if (item.summary) {
		console.log("\nsummary:" + item.summary);
	}else{
        console.log("\nsummary:" + " No information");
    }
	if (Array.isArray(item.genres)) {
		console.log("\ngenres:", item.genres.map((g) => "\t - " + g.name).join(", "));
	}else{
        console.log("\ngenres:" + " No information");
    }
	console.log("\n****************************************************************************************");
});
*/



/*const query4 = () => {
    const pipeline = [
        {
            $match: {
                "language_supports": {
                    $elemMatch: {
                        "language": { $exists: true, $not: { $size: 0 } },
                    },
                },
            },
        },
        {
            $addFields: {
                totalLanguages: {
                    $size: {
                        $reduce: {
                            input: "$language_supports",
                            initialValue: [],
                            in: { $setUnion: ["$$value", "$$this.language"] },
                        },
                    },
                },
            },
        },
        {
            $project: {
                _id: 0,
                name: 1,
                rating: 1,
                supportedLanguages: "$totalLanguages",
                "language_supports.language.name": 1,
            },
        },
        {
            $sort: {
                supportedLanguages: -1, // Ordena por cantidad de lenguajes soportados (mayor a menor)
                rating: -1, // Luego, ordena por rating (mayor a menor)
                name: 1, // En caso de empate en rating, ordena por nombre (ascendente)
            },
        },
        {
            $limit: 100,
        },
    ];

    // Aggregate and sort the games
    const cursor = db.getCollection("games").aggregate(pipeline);

    // Convert the cursor to an array
    const results = cursor.toArray();

    // Print the sorted results

    for (let i = 0; i < results.length; i++) {
        console.log(`#${i + 1}`);
        console.log(`Nombre: ${results[i].name}`);
        console.log(`Rating: ${results[i].rating ? results[i].rating :"No information"}`);
        console.log(`Idiomas Soportados: ${results[i].supportedLanguages}`);
        const printedLanguages = new Set();
        if(results[i].language_supports){
            console.log("Lenguajes Soportados:");
            results[i].language_supports.forEach((language) => {
                const languageName = language.language[0].name;
                if (!printedLanguages.has(languageName)) {
                    console.log(`- ${language.language[0].name}`);
                    printedLanguages.add(languageName);
                }
                
            });
        }
        console.log("***************************************************");
    }
};
query4();
*/