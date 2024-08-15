const AdminService = require("../services/admin.services");

exports.register = async (req, res, next) => {
     try {
          const { fname, lname, email, dob, phone, aid, password } = req.body;

          if (!fname || !lname || !email || !dob || !phone || !aid || !password) {
               return res.status(400).json({ status: false, message: 'All fields are required' });
          }

          const admin = await AdminService.registerAdmin({ fname, lname, email, dob, phone, aid, password });

          res.json({ status: true, success: 'Admin Registered Successfully', admin });
     } catch (error) {
          res.status(500).json({ status: false, message: error.message });
     }
}

exports.login = async (req, res, next) => {
     try {

          const { aid, password } = req.body;

          let admin = await AdminService.checkAdmin(aid);
          console.log("----------Admin-----------", admin);
          if (!admin) {
               throw new Error('Admin does not exist');
          }

          const isPasswordCorrect = await admin.comparePassword(password);

          if (isPasswordCorrect === false) {
               throw new Error(`Password does not match`);
          }

          // Creating Token

          let tokenData;
          tokenData = { _id: admin._id, aid: admin.aid };


          const token = await AdminService.generateAccessToken(tokenData, "secret", "1h")

          res.status(200).json({ status: true, success: "sendData", token: token });
     } catch (error) {
          console.log(error, 'err---->');
          next(error);
     }
}