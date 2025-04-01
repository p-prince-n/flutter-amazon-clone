const jwt = require("jsonwebtoken");
const User=require('../models/user')
const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ message: "no Auth token, access denied. " });
    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified)
      return res
        .status(401)
        .json({ message: "Token verification Faile, authorization denied," });

    const user=await User.findById(isVerified.id);
    if(user.type=='user'|| user.type=='seller'){
        return res
        .status(401)
        .json({ message: "You are not an Admin!" });
    }
    req.user = isVerified.id;
    req.token = isVerified.token;
    next();
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

module.exports=admin;
