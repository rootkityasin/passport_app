const UserService = require("../services/user.services");
const UserModel = require('../model/user.model');
const jwt = require("jsonwebtoken");
require('dotenv').config();


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
};

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        let user = await UserService.checkUser(email);
        console.log("----------user-----------", user);
        if (!user) {
            throw new Error('User does not exist');
        }

        const isPasswordCorrect = await user.comparePassword(password);

        if (isPasswordCorrect === false) {
            throw new Error(`Password does not match`);
        }

        // Creating Token
        let tokenData;
        tokenData = { _id: user._id, email: user.email, fname: user.fname, lname: user.lname };

        const token = await UserService.generateAccessToken(tokenData);

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.getUser = async (req, res, next) => {
    try {
        const userId = req.params.id;
        const user = await UserModel.findById(userId); // Select only the required fields
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        res.status(200).json(user);
    } catch (error) {
        console.error('Error fetching user:', error);
        res.status(500).json({ message: 'Server error' });
    }
}

exports.updateUser = async (req, res, next) => {
    try {
        const userId = req.params.id;
        const userData = req.body;

        const updatedUser = await UserService.updateUser(userId, userData);

        if (!updatedUser) {
            return res.status(404).json({ status: false, message: 'User not found' });
        }

        res.status(200).json({ status: true, success: "User updated successfully", data: updatedUser });
    } catch (error) {
        res.status(500).json({ status: false, message: error.message });
    }
};

exports.logout = async (req, res, next) => {
    // Destroy the session
    req.session.destroy(err => {
        if (err) {
            return res.status(500).json({ error: 'Failed to logout' });
        }
        res.clearCookie('connect.sid'); // Optional: clear the session cookie
        res.status(200).json({ message: 'Logout successful' });
    });
}