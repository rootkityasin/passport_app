const UserModel = require('../model/user.model')
const jwt = require("jsonwebtoken");
const bcrypt = require('bcrypt'); // Ensure bcrypt is imported
require('dotenv').config();

class UserService {
     static async registerUser(userSchema) {
          try {
               const createUser = new UserModel(userSchema);
               return await createUser.save();
          } catch (err) {
               throw err;
          }
     }
     static async getUserByEmail(email) {
          try {
               return await UserModel.findOne({ email });
          } catch (err) {
               console.log(err);
          }
     }

     static async checkUser(email) {
          try {
               return await UserModel.findOne({ email });
          } catch (error) {
               throw error;
          }
     }

     static async updateUser(userId, userData) {
          try {
               // Fetch the existing user to retain the password if not provided in the update
               const existingUser = await UserModel.findById(userId);
               if (!existingUser) {
                    throw new Error('User not found');
               }

               // If the request doesn't include a password, use the existing password
               if (!userData.password) {
                    userData.password = existingUser.password;
               } else {
                    // If the password is being updated, hash it before saving

                    const hashedPassword = await bcrypt.hash(userData.password, 10);
                    console.log("New hashed password:", hashedPassword);
                    userData.password = hashedPassword;
               }

               const updatedUser = await UserModel.findByIdAndUpdate(userId, userData, { new: true });
               console.log("Updated user in DB:", updatedUser);
               return updatedUser;
          } catch (error) {
               throw error;
          }
     }
     static async generateAccessToken(tokenData) {
          const JWTSecret_Key = process.env.JWT_SECRET_KEY; // Use secret key from environment variables
          const JWT_EXPIRE = process.env.JWT_EXPIRE; // Use expiration time from environment variables
          console.log('JWT_SECRET_KEY:', process.env.JWT_SECRET_KEY);
          console.log('JWT_EXPIRE:', process.env.JWT_EXPIRE);
          if (!JWTSecret_Key || !JWT_EXPIRE) {
               throw new Error('JWT_SECRET_KEY or JWT_EXPIRE is not defined in the environment variables.');
          }

          return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
     }

     static async getUser(id) {
          try {
               const user = await User.findById(id);
               if (!user) {
                    return res.status(404).send({ message: 'User not found' });
               }
               return user;
          } catch (error) {
               throw error;
          }
     }
}

module.exports = UserService;