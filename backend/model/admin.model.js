const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const db = require('../config/db');
const { Schema } = mongoose;

const adminSchema = new Schema({
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
          required: true, unique: true
     },
     dob:
     {
          type: Date,
          default: () => new Date().toISOString().split('T')[0],
          required: true
     },
     phone:
     {
          type: Number,
          required: true
     },
     aid:
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

adminSchema.pre('save', async function () {
     try {
          var admin = this;
          const salt = await (bcrypt.genSalt(10));
          const hashpass = await bcrypt.hash(admin.password, salt);

          admin.password = hashpass;
     } catch (error) {
          throw error;
     }
});

//used while signIn decrypt
adminSchema.methods.comparePassword = async function (candidatePassword) {
     try {
          console.log('----------------Password Encrypted', this.password);
          // @ts-ignore
          const isMatch = await bcrypt.compare(candidatePassword, this.password);
          return isMatch;
     } catch (error) {
          throw error;
     }
};
const AdminModel = db.model('Admin', adminSchema);
module.exports = AdminModel;
