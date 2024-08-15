const PoliceModel = require('../model/police.model')
const jwt = require("jsonwebtoken");

class PoliceService {
     static async registerPolice(policeSchema) {
          try {
               const createPolice = new PoliceModel(policeSchema);
               return await createPolice.save();
          } catch (err) {
               throw err;
          }
     }
     static async getPoliceByPid(pid) {
          try {
               return await PoliceModel.findOne({ pid });
          } catch (err) {
               console.log(err);
          }
     }

     static async checkPolice(pid) {
          try {
               return await PoliceModel.findOne({ pid });
          } catch (error) {
               throw error;
          }
     }

     static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
          return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
     }
}

module.exports = PoliceService;