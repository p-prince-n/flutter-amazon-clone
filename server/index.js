const exprees = require('express');
const app = exprees();
const mongoose=require('mongoose');
const authRouterouter = require('./routes/authRoute');
const adminRoute = require('./routes/adminRoute');
const productsRoute = require('./routes/productsRoute');
const addToCart=require('./routes/user')
const PORT = 8000;
const DB='Add Your MongaDB Driver';
//example mongodb+srv://<username>:<db_password>@clustername.0gzjb.mongodb.net/?retryWrites=true&w=majority&appName=Clustername
app.use(exprees.json());
app.use('/',authRouterouter);
app.use('/',adminRoute);
app.use('/', productsRoute);
app.use('/', addToCart)

mongoose.connect(DB).then(()=>{
    console.log('DataBase Connected Successfully.')
}).catch(e=>{console.log(e)});
app.listen(PORT,'0.0.0.0', () => {
    console.log(`server started at http://localhost:${PORT}`);
})