const express = require('express');
const router = express.Router();

const pool = require('../../database')

router.get('/', (req,res) => {
    res.render('Hello World');
});

module.exports =router;