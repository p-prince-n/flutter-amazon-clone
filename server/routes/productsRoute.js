const express = require("express");
const productsRoute = express.Router();
const auth = require("../middlewares/auth");
const {Product} = require("../models/product");

productsRoute.get("/api/products", auth, async (req, res, next) => {
  try {
    const category = req.query.category;
    let products = await Product.find({ category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productsRoute.get(
  "/api/products/search/:searchQuery",
  auth,
  async (req, res, next) => {
    try {
      const searchQuery = req.params.searchQuery;
      let products = await Product.find({
        name: { $regex: searchQuery, $options: "i" },
      });
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);


productsRoute.post('/api/rate-product', auth, async (req, res, next) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);
    for (let i = 0; i < product.rating.length; i++) {
      if (product.rating[i].userId == req.user) {
        product.rating.slice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    }
    product.rating.push(ratingSchema);
    product = await product.save();
    res.json(product);

  } catch (e) {
    res.status(500).json({ error: e.message })
  }
});


productsRoute.get('/api/deal-of-days', auth, async (req, res, next) => {
  try {
    let product = await Product.find({});
    product.sort((product1, product2) => {
      let aSum = 0;
      let bSum = 0;
      for (let i = 0; i < product1.rating.length; i++) {
        aSum += product1.rating[i].rating;
      }
      for (let j = 0; j < product2.rating.length; j++) {
        bSum += product2.rating[j].rating;
      }
      return aSum < bSum ? 1 : -1;
    })
    res.json(product[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productsRoute;
