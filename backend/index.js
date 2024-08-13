
const app = require('./app');
const db = require('./config/db');
const userModel = require('./model/user.model');
const PORT = 3000;
const cors = require('cors');

app.use(cors());

app.get('/', (req, res) => {
     res.send("Hello World");
});

app.listen(PORT,'localhost', () => {
     console.log(`Server Listening on Port http://localhost:${PORT}`);
});