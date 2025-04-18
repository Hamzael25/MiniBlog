const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.static('public'));

app.use(express.json());

app.use(express.urlencoded({ extended: true }));

app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

// Récup variables d'environnement pour la DB
const dbHost = process.env.DB_HOST || 'localhost';
const dbPort = process.env.DB_PORT || 5432;
const dbName = process.env.DB_NAME || 'blogdb';
const dbUser = process.env.DB_USER || 'bloguser';
const dbPassword = process.env.DB_PASSWORD || 'blogpass';

const pool = new Pool({
	host: dbHost,
	port: dbPort,
	database: dbName,
	user: dbUser,
	password: dbPassword,
});

app.get('/', (req, res) => {
	res.render('index', { title: 'Bienvenue sur mon Mini Blog' });
});

app.get('/new-article', (req, res) => {
	res.render('new-article');
});

app.get('/list-articles', async (req, res) => {
	try {
		const result = await pool.query('SELECT * FROM articles ORDER BY id DESC;');
		res.render('list-articles', { articles: result.rows });
	} catch (err) {
		console.error(err);
		res.status(500).send('Erreur lors de la récupération des articles');
}
});


app.get('/articles', async (req, res) => {
	try {
		const result = await pool.query('SELECT * FROM articles ORDER BY id DESC;');
		res.json(result.rows);
	} catch (err) {
		console.error(err);
		res.status(500).json({ error: 'Erreur de récupération' });
	}
});

app.post('/articles', async (req, res) => {
	const { title, content } = req.body;
	try {
		const result = await pool.query(
		'INSERT INTO articles (title, content) VALUES ($1, $2) RETURNING *;',
		[title, content]
		);
		res.redirect('/list-articles');
	} catch (err) {
		console.error(err);
		res.status(500).send('Erreur de création');
	}
});


app.listen(port, () => {
	console.log(`Server running on port ${port}`);
});
