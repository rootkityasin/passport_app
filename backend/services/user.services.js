const UserModel = require('../model/user.model')
const jwt = require("jsonwebtoken");

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

     static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
          return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
     }

     static async getUser(id) {
          try {
               const user = await User.findById(id);
               if (!user) {
                   return res.status(404).send({ message: 'User not found' });
               }
               res.status(200).send(user);
          } catch (error) {
               res.status(500).send({ message: 'Server error' });
          }
     }
}

module.exports = UserService;