const express = require('express');
const morgan = require('morgan');
const { engine } = require('express-handlebars');
const path = require('path');


//initializations
const app = express();

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
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());

//global variables
app.use((req, res, next) => {

    next();
});

//routes
app.use(require('./app/routes'));
app.use(require('./app/routes/authentication'));
app.use('/plans', require('./app/routes/planes'));


//public
app.use(express.static(path.join(__dirname, 'public')));


//starting server
app.listen(app.get('port'), () =>{
    console.log('Server on port', app.get('port')); 
});