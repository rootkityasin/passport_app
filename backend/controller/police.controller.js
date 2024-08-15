const PoliceService = require("../services/police.services");

exports.register = async (req, res, next) => {
     try {
          const { fname, lname, email, dob, phone, pid, password } = req.body;

          if (!fname || !lname || !email || !dob || !phone || !pid || !password) {
               return res.status(400).json({ status: false, message: 'All fields are required' });
          }

          const police = await PoliceService.registerPolice({ fname, lname, email, dob, phone, pid, password });

          res.json({ status: true, success: 'Police Registered Successfully', police });
     } catch (error) {
          res.status(500).json({ status: false, message: error.message });
     }
}

exports.login = async (req, res, next) => {
     try {

          const { pid, password } = req.body;

          let police = await PoliceService.checkPolice(pid);
          console.log("----------Police-----------",police);
          if (!police) {
               throw new Error('Police does not exist');
          }

          const isPasswordCorrect = await police.comparePassword(password);

          if (isPasswordCorrect === false) {
               throw new Error(`Password does not match`);
          }

          // Creating Token

          let tokenData;
          tokenData = { _id: police._id, pid: police.pid };


          const token = await PoliceService.generateAccessToken(tokenData, "secret", "1h")

          res.status(200).json({ status: true, success: "sendData", token: token });
     } catch (error) {
          console.log(error, 'err---->');
          next(error);
     }
}