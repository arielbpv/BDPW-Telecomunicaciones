const { Router } = require('express');
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
    console.log(newPlan);
    await pool.query('INSERT INTO plan set ?', [newPlan]);
    req.flash('success', 'Plan creado correctamente');
    res.redirect('/plans');
});

router.get('/', async (req, res) => { 
    const plan = await pool.query('SELECT * FROM plan');
    res.render('plans/list', {plan});
});

router.get('/delete/:id', async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM plan WHERE IDPlan = ?', [id]);
    req.flash('success', 'Plan Removed successfully');
    res.redirect('/plans');
});

router.get('/edit/:id', async (req, res) => {
    const { id } = req.params;
    const plan = await pool.query('SELECT * FROM plan WHERE IDPlan = ?', [id]);
    res.render('plans/edit', {plan: plan[0]});
});

router.post('/edit/:id', async (req, res) => {
    const { id } = req.params;
    const { Nombre, Precio, Descripcion } = req.body;
    
    const newPlan = {
        Precio,
        Descripcion,
        Nombre
    };
    await pool.query('UPDATE plan set ? WHERE IDPlan = ?', [newPlan, id]);
    req.flash('success', 'Plan Updated successfully');
    res.redirect('/plans');
}); 

module.exports = router;