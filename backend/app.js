require('dotenv').config();
const express = require('express');
const body_parser = require('body-parser');
const userRouter = require('./routers/user.router');
const adminRouter = require('./routers/admin.route');
const policeRouter = require('./routers/police.route');
const apply = require('./routers/application.route');
//const policeRouter = require('./routers/application.route');
const app = express();
const cors = require('cors');

app.use(cors());

app.use(body_parser.json());
app.use('/api/users', userRouter);
app.use('/api/admin', adminRouter);
app.use('/api/police', policeRouter);
//app.use('/api/apply', apply);
module.exports = app;