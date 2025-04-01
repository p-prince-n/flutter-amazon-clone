const express = require('express');
const adminRoute = express.Router();
const admin = require('../middlewares/admin');
const { Product } = require('../models/product');
const User = require('../models/user');
const Order = require('../models/order');


adminRoute.post('/admin/add-product', admin, async (req, res, next) => {
    try {
        const { name, description, quantity, images, category, price } = req.body;
        let product = new Product({
            name,
            description,
            quantity,
            images,
            category,
            price,
        })
        product = await product.save();
        res.json(product);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminRoute.get('/admin/get-products', admin, async (req, res, next) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

adminRoute.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})


adminRoute.get('/admin/get-all-orders', admin, async (req, res, next) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

adminRoute.post('/admin/change-order-status', admin, async (req, res, next) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});


adminRoute.get('/admin/analytics', admin, async (req, res, next) => {
    try {
        const orders = await Order.find({});
        let totalEarning = 0;
        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarning += orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }
        let mobileEarning = await fetchCategoryWiseProduct('Mobiles');
        let essentialsEarning = await fetchCategoryWiseProduct('Essentials');
        let appliancesEarning = await fetchCategoryWiseProduct('Appliances');
        let booksEarning = await fetchCategoryWiseProduct('Books');
        let fashionEarning = await fetchCategoryWiseProduct('Fashion');

        let earnings = {
            totalEarning,
            mobileEarning,
            essentialsEarning,
            appliancesEarning,
            booksEarning,
            fashionEarning,
        }
        res.json(earnings);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})


async function fetchCategoryWiseProduct(category) {
    let earnings = 0;

    let categoryOrders = await Order.find({
        'products.product.category': category
    });

    categoryOrders.forEach(order => { 

        order.products
            .filter(p => p.product.category === category) // Ensure only relevant products
            .forEach(product => {
                let productTotal = product.quantity * product.product.price;
                earnings += productTotal; // Add to total earnings

           
            });
    });

    return earnings;
}


module.exports = adminRoute;