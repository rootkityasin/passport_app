const router = require('express').Router();
const ApplicationController = require('../controller/application.controller');

// Route for applying
router.post('/apply', ApplicationController.apply);
router.delete('/:id', ApplicationController.deleteApplication);

// Route for fetching all applications

module.exports = router;
