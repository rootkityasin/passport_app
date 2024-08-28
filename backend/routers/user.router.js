const router = require('express').Router();
const UserController = require('../controller/user.controller');
const ApplicationController = require("../controller/application.controller");

router.post('/apply', ApplicationController.apply);
router.post('/register', UserController.register);
router.post("/login", UserController.login);
router.get("/getUser/:id", UserController.getUser); // Correctly defined as GET method
router.put('/updateUser/:id', UserController.updateUser);
router.post("/logout", UserController.logout); // Fixed duplicate route

module.exports = router;