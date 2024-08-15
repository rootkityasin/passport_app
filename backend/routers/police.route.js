const router = require('express').Router();
const PoliceController = require('../controller/police.controller')

router.post('/register', PoliceController.register);

router.post("/login", PoliceController.login);

module.exports = router;