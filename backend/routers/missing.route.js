// routers/missing.route.js
const express = require('express');
const router = express.Router();
const MissingController = require('../controller/missing.controller');

router.post('/', MissingController.submitMissingReport);
router.get('/', MissingController.getAllMissingReports);

module.exports = router;
