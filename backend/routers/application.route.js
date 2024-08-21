const router = require('express').Router();
const ApplicationController = require("../controller/application.controller");

router.post('/apply', ApplicationController.apply);

module.exports = router;
