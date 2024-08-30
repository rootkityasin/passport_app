const router = require('express').Router();
const ApplicationController = require('../controller/application.controller');

// Route for applying
router.post('/apply', ApplicationController.apply);

// Route for fetching all applications

module.exports = router;
