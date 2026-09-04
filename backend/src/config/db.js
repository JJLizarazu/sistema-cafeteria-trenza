// backend/src/config/db.js
const { Pool } = require('pg');
require('dotenv').config(); // Llama al archivo .env

// Configuramos las conexiones a la base de datos
const pool = new Pool({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
});

// Probamos que la conexión funcione
pool.connect()
    .then(() => console.log('✅ Base de datos PostgreSQL (trenza_core) conectada con éxito.'))
    .catch(err => console.error('❌ Error al conectar con PostgreSQL:', err.stack));

module.exports = pool;