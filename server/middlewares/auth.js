const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    let token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ message: "no Auth token, access denied. " });
    let isVaeified = jwt.verify(token, "passwordKey");
    if (!isVaeified)
      return res
        .status(401)
        .json({ message: "Token verification Faile, authorization denied," });
    req.user=isVaeified.id;
    req.token=token;
    next();

  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

module.exports=auth;
