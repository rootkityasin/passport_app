const router = require('express').Router();
const UserController = require('../controller/user.controller')
const ApplicationController = require("../controller/application.controller");

router.post('/apply', ApplicationController.apply);

router.post('/register', UserController.register);

router.post("/login", UserController.login);
router.post("/getUser/:id", UserController.getUser);
router.post("/login", UserController.logout);

module.exports = router;