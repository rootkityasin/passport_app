// controller/missing.controller.js
const ReportService = require('../services/missing.services');

// Controller function to handle the submission of a new missing report
exports.submitMissingReport = async (req, res) => {
  try {
    console.log("Received report data:", req.body); // Log the incoming data
    const reportData = req.body.reportData;
    const newReport = await ReportService.createReport(reportData);
    res.status(200).json({ success: true, report: newReport });
  } catch (error) {
    console.error("Error in submitMissingReport controller:", error);
    res.status(500).json({ success: false, message: error.message });
  }
};

// Controller function to retrieve all missing reports
exports.getAllMissingReports = async (req, res) => {
  try {
    const reports = await ReportService.getAllReports();
    res.status(200).json({ success: true, reports });
  } catch (error) {
    console.error("Error in getAllMissingReports controller: ", error);
    res.status(500).json({ success: false, message: error.message });
  }
};
