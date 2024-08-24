const mongoose = require('mongoose');

const ApplicationSchema = new mongoose.Schema({
    personalInfo: {
        fullName: { type: String, required: true },
        givenName: { type: String, required: true },
        surname: { type: String, required: true },
        dateOfBirth: { type: Date, required: true },
        countryOfBirth: { type: String, required: true },
        districtOfBirth: { type: String, required: true },
        placeOfBirth: { type: String, required: true },
        gender: { type: String, required: true },
        religion: { type: String, required: true },
        citizenType: { type: String, required: true },
        dualCitizenshipStatus: { type: Boolean, required: true },
        maritialStatus: { type: Boolean, required: true },
        nationalId: { type: String, required: true },
        birthCertificate: { type: String, required: true },
        otherCitizenshipCountry: { type: String },
        foreignPassportNo: { type: String },
        profession: { type: String, required: true },
        contactNo: { type: String, required: true },
        email: { type: String, required: true },
    },
    presentAddress: {
        country: { type: String, required: true },
        district: { type: String, required: true },
        policeStation: { type: String, required: true },
        postOffice: { type: String, required: true },
        postCode: { type: String, required: true },
        city: { type: String, required: true },
        road: { type: String, required: true },
    },
    permanentAddress: {
        country: { type: String, required: true },
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
