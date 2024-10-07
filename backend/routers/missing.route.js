// routers/missing.route.js
const express = require('express');
const router = express.Router();
const MissingController = require('../controller/missing.controller');

// Route for submitting a new missing report
router.post('/', MissingController.submitMissingReport);

// Route for retrieving all missing reports
router.get('/', MissingController.getAllMissingReports);

module.exports = router;
