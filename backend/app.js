// app.js
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const userRouter = require('./routers/user.router');
const adminRouter = require('./routers/admin.route');
const policeRouter = require('./routers/police.route');
const missingRoute = require('./routers/missing.route');
const applyRoute = require('./routers/application.route');

const app = express();

app.use(cors());
app.use(bodyParser.json());

app.use('/api/users', userRouter);
app.use('/api/admin', adminRouter);
app.use('/api/police', policeRouter);
app.use('/api/missing', missingRoute);
app.use('/api/apply', applyRoute);

module.exports = app;
