// ==========================================
// PROYECTO TRENZA - Backend Entry Point
// ==========================================

const express = require('express');
const cors = require('cors');
require('dotenv').config(); 

const pool = require('./src/config/db'); 

// Importar rutas
const authRoutes = require('./src/routes/auth');

const app = express();

app.use(cors()); 
app.use(express.json()); 

const PORT = process.env.PORT || 3000;

// Registrar las rutas en Express
// Todas las rutas dentro de authRoutes empezarán con /api/auth
app.use('/api/auth', authRoutes);

app.get('/', (req, res) => {
    res.json({
        mensaje: 'Bienvenido al servidor API del Proyecto Trenza',
        estado: 'Online'
    });
});

app.listen(PORT, () => {
    console.log(`🚀 Servidor backend corriendo en el puerto ${PORT}`);
});