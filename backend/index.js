const app = require('./app');
const db = require('./config/db');
const userModel = require('./model/user.model');
const adminModel = require('./model/admin.model');
const policeModel = require('./model/police.model');
const PORT = 3000;


app.get('/', (req, res) => {
     res.send("Hello World");
});

app.listen(PORT, () => {
     console.log(`Server Listening on Port http://192.168.0.110:${PORT}`);
});