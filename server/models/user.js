const mongoose=require('mongoose');
const { productScheme } = require('./product');

const userScheme=mongoose.Schema({
    name:{
        type : String,
        trim: true,
        required: true,
    },
    email :{
        type : String,
        trim: true,
        required: true,
        validate: {
            validator: (value)=>{
                const re=/^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/;
                return value.match(re);
            },
            message: "Please Enter a valid Password.",
        }
    },
    password: {
        required: true,
        type : String,
    },
    address  : {
        type : String,
        default :'',
    },
    type :{
        type : String,
        default: 'user',
    },
    cart:[
        {
            product : productScheme,
            quantity: {
                type : Number,
                required : true,
            }
        }
    ]
})
const User= mongoose.model('User', userScheme);
module.exports=User;