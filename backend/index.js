// index.js
const app = require('./app');
const db = require('./config/db'); // Ensure your database connection is correctly set up
const PORT = 3000;

app.get('/', (req, res) => {
  res.send("Hello World");
});

app.listen(PORT, () => {
  console.log(`Server Listening on Port http://localhost:${PORT}`);
});
