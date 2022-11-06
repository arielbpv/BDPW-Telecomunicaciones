const express = require('express');
const morgan = require('morgan');
const { engine } = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session = require('express-session');
const MySQLStore = require('express-mysql-session');
const {database} = require('./keys');
const passport =  require('passport');

//initializations
const app = express();
require('./app/lib/passport');

//settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'app/views'));
app.engine('.hbs', engine({
    defaultlayout: 'main',
    layoutDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'),'partials'),
    extname: '.hbs',
    helpers: require('./app/lib/Handlebars') 
}));
app.set('view engine', '.hbs'); 

//middlewares
app.use(session({
    secret:'telecomunicaciones',
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore(database)
}));
app.use(flash());
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());


//global variables
app.use((req, res, next) => {
    app.locals.success = req.flash('success');
    next();
});

//routes
app.use(require('./app/routes'));
app.use(require('./app/routes/authentication'));
app.use('/plans', require('./app/routes/planes'));
//app.use('/plans', require('./app/routes/home'));


//public
app.use(express.static(path.join(__dirname, 'public')));


//starting server
app.listen(app.get('port'), () =>{
    console.log('Server on port', app.get('port')); 
});