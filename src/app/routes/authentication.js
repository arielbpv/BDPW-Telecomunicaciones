const express = require('express');
const router = express.Router();
const passport = require('passport');

router.get('/signup',(req, res) => {
    res.render('auth/signup');
});

router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/perfil',
    failureRedirect: '/signup',
    failureFlash: true
}));

router.get('/perfil', (req, res) => {
    res.send('este es tu perfil')
});
module.exports = router;