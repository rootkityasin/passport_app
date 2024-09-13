// models/report.model.js
const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  passportType: { type: String, required: true },
  reissueReason: { type: String, required: true },
  country: { type: String, required: true },
  policeCaseNumber: { type: String, required: true },
  district: { type: String, required: true },
  policeStation: { type: String, required: true },
  reportedDate: { type: Date, required: true },
  previousPassportNumber: { type: String, required: false },
  dateOfIssue: { type: Date, required: false },
  dateOfExpiration: { type: Date, required: false },
  unknownPreviousPassportData: { type: Boolean, required: true },
  otherCountryPassport: { type: String, required: true },
}, { timestamps: true });

const Report = mongoose.model('Report', reportSchema);

module.exports = Report;
