// backend/src/routes/auth.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Importamos la conexión a la base de datos

// ==========================================
// ENDPOINT: Login con PIN
// Ruta: POST /api/auth/login
// Descripción: Valida el PIN de acceso de un usuario y devuelve su rol
// ==========================================
router.post('/login', async (req, res) => {
    try {
        const { pin } = req.body;

        if (!pin) {
            return res.status(400).json({ error: 'El PIN es requerido' });
        }

        // Consultamos la base de datos para buscar al usuario con ese PIN
        // Usamos JOIN para obtener también el nombre de su rol
        const query = `
            SELECT u.id, u.nombre, r.nombre as rol_nombre
            FROM usuarios u
            JOIN roles r ON u.rol_id = r.id
            WHERE u.pin_acceso = $1
        `;
        
        const result = await pool.query(query, [pin]);

        // Si no encontramos ningún usuario con ese PIN
        if (result.rows.length === 0) {
            return res.status(401).json({ error: 'PIN incorrecto o usuario no encontrado' });
        }

        const usuario = result.rows[0];

        // Retornamos los datos del usuario (En un proyecto real aquí se generaría un token JWT, 
        // pero para mantenerlo simple y rápido para la Tablet, con el PIN basta por ahora).
        res.json({
            mensaje: 'Login exitoso',
            usuario: {
                id: usuario.id,
                nombre: usuario.nombre,
                rol: usuario.rol_nombre
            }
        });

    } catch (error) {
        console.error('Error en el login:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

// ==========================================
// ENDPOINT: Obtener todos los roles
// Ruta: GET /api/auth/roles
// Descripción: Lista los roles disponibles para cuando se cree un nuevo empleado
// ==========================================

router.get('/roles', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM roles ORDER BY id ASC');
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener roles:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

module.exports = router;