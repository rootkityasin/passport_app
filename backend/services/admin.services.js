const AdminModel = require('../model/admin.model')
const jwt = require("jsonwebtoken");

class AdminService {
     static async registerAdmin(adminSchema) {
          try {
               const createAdmin = new AdminModel(adminSchema);
               return await createAdmin.save();
          } catch (err) {
               throw err;
          }
     }
     static async getAdminByAid(aid) {
          try {
               return await AdminModel.findOne({ aid });
          } catch (err) {
               console.log(err);
          }
     }

     static async checkAdmin(aid) {
          try {
               return await AdminModel.findOne({ aid });
          } catch (error) {
               throw error;
          }
     }

     static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
          return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
     }
}

module.exports = AdminService;