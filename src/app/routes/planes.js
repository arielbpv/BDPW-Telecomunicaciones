const express = require('express');
const { route } = require('.');
const router = express.Router();

const pool = require('../../database');

router.get('/add', (req, res) => {
    res.render('plans/add');
});

router.post('/add', (req, res) => {
    res.send('resived');
});

module.exports = router;