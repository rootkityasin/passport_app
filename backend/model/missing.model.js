// model/report.model.js
const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  passportType: { type: String, required: true },
  reissueReason: { type: String, required: true },
  country: { type: String, required: true },
  policeCaseNumber: { type: String, required: true },
  district: { type: String, required: true },
  policeStation: { type: String, required: true },
  reportedDate: { type: Date, required: true },
  previousPassportNumber: { type: String },
  dateOfIssue: { type: Date },
  dateOfExpiration: { type: Date },
  unknownPreviousPassportData: { type: Boolean, required: true },
  otherCountryPassport: { type: String, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Report', reportSchema);
