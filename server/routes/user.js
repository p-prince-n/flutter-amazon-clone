const express = require("express");
const userRoute = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

userRoute.post("/api/add-to-cart", auth, async (req, res, next) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let productFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          productFound = true;
          break;
        }
      }
      if (productFound) {
        let producttt = user.cart.find((productt) => 
          productt.product._id.equals(product._id)
        );
        producttt.quantity += 1;
      }else{
        user.cart.push({ product, quantity: 1 });
      }
    }
    user=await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


userRoute.delete("/api/remove-from-cart/:id", auth, async(req, res, next)=>{
  try{
    const {id}=req.params;
    const product = await  Product.findById(id);
    let user= await User.findById(req.user);
    for(let i=0; i<user.cart.length; i++){
      if (user.cart[i].product._id.equals(product._id)){
        if(user.cart[i].quantity==1){

          user.cart.splice(i, 1);
        } else{
          user.cart[i].quantity -= 1;
        }
      }
    }
    user=await user.save();
    res.json(user);
  }catch(e){
    res.status(500).json({ error: e.message });
  }
});


userRoute.post("/api/add-user-address", auth, async(req, res, next)=>{
  try{
    console.log('/api/add-user-address');
    const {address}=req.body;
  let user=await User.findById(req.user);
  user.address=address;
  console.log(user, 1);
  user=await user.save();
  
  console.log(user, 1);
  res.json(user);
  }catch(e){
    res.status(500).json({ error: e.message });
  }

});


userRoute.post("/api/order", auth, async(req, res, next)=>{
  try{
    console.log('/api/order');
    const { address, totalAmount, cart}=req.body;
    console.log(address);
    let products=[];
    for(let i=0; i<cart.length; i++){
      let product=await Product.findById(cart[i].product._id);
      if(product.quantity>=cart[i].quantity){
        product.quantity -= cart[i].quantity;
        products.push({product, quantity: cart[i].quantity});
        await product.save();
      }else{
        res.status(400).json({msg : `${product.name} out of Stock .`});
      }
    }
    console.log('user');
    let user= await User.findById(req.user);
    user.cart=[];
    await user.save();
    console.log('user');
    let order= new Order({
      products,
      totalAmount,
      address,
      userId : req.user,
      orderAt: new Date().getTime(),
    });

    order= await order.save();
    res.json(order);
  }catch(e){
    res.status(500).json({ error: e.message });
  }

});
userRoute.get('/api/order/me', auth, async (req, res, next)=>{
try{
  const order=await Order.find({userId : req.user});
  res.json(order);
}catch(e){
  res.status(500).json({ error: e.message });
}
});


module.exports=userRoute;
