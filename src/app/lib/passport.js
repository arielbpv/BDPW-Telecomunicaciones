const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

passport.use('local.signup', new LocalStrategy({
    usernameField: 'RUT',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async (req, RUT, contraseña, done ) => {

    console.log(req.body);

}));

///passport.serializeUser((usr, done) =>{
///}); 