const express = require("express");
const authRouter = express.Router();
const byCrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const auth=require('../middlewares/auth');
authRouter.post("/api/signUp", async (req, res, next) => {
  try {
    const { name, email, password } = req.body;
    const alreadyExist = await User.findOne({ email });
    if (alreadyExist) {
      return res
        .status(400)
        .json({ message: "User with same email already exist." });
    }
    const hashPassword = await byCrypt.hash(password, 8);
    let user = new User({ name, email, password: hashPassword });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});

authRouter.post("/api/signIn", async (req, res, next) => {
  try {
    const { email, password } = req.body;
    let user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ message: "User with this email does not exist." });
    }
    let isMatch = await byCrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Incorrect Password." });
    }
    let token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});
authRouter.post("/isVerifiedToken", async (req, res, next) => {
  try {
    let token = req.header("x-auth-token");
    if (!token) return res.json(false);
    let isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified) return res.json(false);
    let user = await User.findById(isVerified.id);
    if (!user) return res.json(false);
    return res.json(true);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
