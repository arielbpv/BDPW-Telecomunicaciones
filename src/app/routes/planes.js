const express = require('express');
const router = express.Router();

const pool = require('../../database');

router.get('/add', (req, res) => {
    res.render('plans/add');
});

router.post('/add', async (req, res) =>{
    const { Nombre, Precio, Descripcion } = req.body;
    const newPlan = {
        Precio,
        Descripcion,
        Nombre
    };
    
    await pool.query('INSERT INTO plan set ?', [newPlan]);
    res.send('recivido');
});

router.get('/', async (req, res) => { 
    const plan= await pool.query('SELECT * FROM plan');
    console.log(plan);
    res.send('planes aca')
});

module.exports = router;