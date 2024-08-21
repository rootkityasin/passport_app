const router = require('express').Router();
const { apply } = require('../controller/application.controller');

router.post('/apply', apply);

module.exports = router;
