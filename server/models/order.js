const mongoose = require('mongoose');
const { productScheme } = require('./product');

const orderSchema = mongoose.Schema({
    products: [
        {
            product: productScheme,
            quantity: {
                type: Number,
                required: true,
            },
        },
    ],
    totalAmount: {
        type: Number,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    userId : {
        type: String,
        required: true,
    },
    orderAt : {
        type: Number,
        required: true,
    }, 
    status : {
        type : Number,
        default : 0,
    },
});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;