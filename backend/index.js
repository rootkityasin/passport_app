
const app = require('./app');
const db = require('./config/db');
const userModel = require('./model/user.model');
const port = 8000;

app.get('/', (req, res) => {
     res.send("Hello World");
});

app.listen(port, 'localhost', () => {
     console.log(`Server Listening on Port http://localhost:${port}`);
});