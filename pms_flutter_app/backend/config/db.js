const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb+srv://parvez:12345@pms2024.prban7k.mongodb.net/pms').on('open', () => {
     console.log("MongoDb Connected")
}).on('error', () => {
     console.log("MongoDb Connection error")
});

module.exports = connection;