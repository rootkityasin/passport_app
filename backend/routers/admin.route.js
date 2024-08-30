const router = require('express').Router();
const AdminController = require('../controller/admin.controller')
const ApplicationController = require('../controller/application.controller')

router.post('/register', AdminController.register);

router.post("/login", AdminController.login);
router.get('/applications', ApplicationController.getAllApplications);

module.exports = router;