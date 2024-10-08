const mongoose = require('mongoose');

async function connectDB() {
    try {
        await mongoose.connect('mongodb+srv://parvez:12345@pms2024.prban7k.mongodb.net/pms', {
           
            serverSelectionTimeoutMS: 10000,
            socketTimeoutMS: 45000, 
        });
        console.log("MongoDB Connected Successfully");
    } catch (error) {
        console.error("MongoDB Connection Error: ", error);
        process.exit(1);
    }
}

connectDB();

module.exports = mongoose;
