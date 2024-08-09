const UserService = require("../services/user.services");

exports.register = async (req, res, next) => {
     try {
          const { fname, lname, email, dob, phone, nid, password } = req.body;

          if (!fname || !lname || !email || !dob || !phone || !nid || !password) {
               return res.status(400).json({ status: false, message: 'All fields are required' });
          }

          const user = await UserService.registerUser({ fname, lname, email, dob, phone, nid, password });

          res.json({ status: true, success: 'User Registered Successfully', user });
     } catch (error) {
          res.status(500).json({ status: false, message: error.message });
     }
}

exports.login = async (req, res, next) => {
     try {

          const { email, password } = req.body;

          let user = await UserService.checkUser(email);
          console.log("----------user-----------",user);
          if (!user) {
               throw new Error('User does not exist');
          }

          const isPasswordCorrect = await user.comparePassword(password);

          if (isPasswordCorrect === false) {
               throw new Error(`Password does not match`);
          }

          // Creating Token

          let tokenData;
          tokenData = { _id: user._id, email: user.email };


          const token = await UserService.generateAccessToken(tokenData, "secret", "1h")

          res.status(200).json({ status: true, success: "sendData", token: token });
     } catch (error) {
          console.log(error, 'err---->');
          next(error);
     }
}