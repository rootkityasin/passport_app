const mongoose = require('mongoose');
const UserModel = require("../model/user.model");
const { Schema } = mongoose;
const ApplicationSchema = new mongoose.Schema({
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } ,
    personalInfo: {
        fullName: { type: String, required: true },
        givenName: { type: String, required: true },
        surname: { type: String, required: true },
        dateOfBirth: { type: String, required: true },
        countryOfBirth: { type: String, required: true },
        nationality: { type: String, required: true },
        placeOfBirth: { type: String, required: true },
        gender: { type: String, required: true },
        citizenType: { type: String, required: true },
        religion: { type: String, required: true },
        dualCitizenshipStatus: { type: Boolean, required: true },
        otherCitizenshipCountry: { type: String },
        foreignPassportNo: { type: String },
        maritalStatus: { type: Boolean, required: true },
        spouseName: { type: String },
        spouseNationality: { type: String },
        spouseProfession: { type: String },
        spousePassportNo: { type: String },
        spouseNationalId: { type: String },  

        nationalId: { type: String, required: true },
        birthCertificateNo: { type: String, required: true },
        profession: { type: String, required: true },
        contactNo: { type: String, required: true },
        email: { type: String, required: true },
    },
    presentAddress: {
        district: { type: String, required: true },
        policeStation: { type: String, required: true },
        postOffice: { type: String, required: true },
        postCode: { type: String, required: true },
        city: { type: String, required: true },
        road: { type: String, required: true },
    },
    permanentAddress: {
        district: { type: String, required: true },
        policeStation: { type: String, required: true },
        postOffice: { type: String, required: true },
        postCode: { type: String, required: true },
        city: { type: String, required: true },
        road: { type: String, required: true },
    }
    
  }, { timestamps: true });

const ApplicationModel = mongoose.model('Application', ApplicationSchema);

module.exports = ApplicationModel;
