const mongoose = require('mongoose');
const Rating = require('./rating');

const productScheme = mongoose.Schema({
    name: {
        type: String,
        trim: true,
        required: true
    },
    description: {
        type: String,
        trim: true,
        required: true
    },
    quantity: {
        type: Number,
        required: true
    },
    category: {
        type: String,
        trim: true,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    images: [
        {
            type: String,
            trim: true,
        },
    ],
    rating : [Rating]
})

const Product = mongoose.model('Product', productScheme);
module.exports = {Product, productScheme};