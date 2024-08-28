const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const db = require('../config/db');
const { Schema } = mongoose;

const userSchema = new Schema({
     fname:
     {
          type: String,
          required: true
     },
     lname:
     {
          type: String,
          required: true
     },
     email:
     {
          type: String,
          lowercase: true,
          required: true, unique: true
     },
     dob:
     {
          type: Date,
          default: () => new Date().toISOString().split('T')[0],
          required: true
     },
     country:
     {
          type: String,
          default: '',
     },
     presentaddress:
     {
          type: String,
          default: '',
     },
     permanentaddress:
     {
          type: String,
          default: '',
     },
     phone:
     {
          type: Number,
          required: true
     },
     nid:
     {
          type: String,
          required: true,
     },
     password:
     {
          type: String,
          required: true
     }
});

userSchema.pre('save', async function () {
     try {
          var user = this;
          const salt = await (bcrypt.genSalt(10));
          const hashpass = await bcrypt.hash(user.password, salt);

          user.password = hashpass;
     } catch (error) {
          throw error;
     }
});

//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
     try {
          console.log('----------------no password', this.password);
          // @ts-ignore
          const isMatch = await bcrypt.compare(candidatePassword, this.password);
          console.log("Old hashed password:", isMatch);
          return isMatch;
     } catch (error) {
          throw error;
     }
};

const UserModel = db.model('User', userSchema);
module.exports = UserModel;