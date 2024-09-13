// controller/missing.controller.js
const ReportService = require('../services/missing.services');

exports.submitMissingReport = async (req, res) => {
  try {
    const reportData = req.body;
    const newReport = await ReportService.createReport(reportData);
    res.status(201).json({ success: true, report: newReport });
  } catch (error) {
    console.error("Error in submitMissingReport controller: ", error);
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.getAllMissingReports = async (req, res) => {
  try {
    const reports = await ReportService.getAllReports();
    res.status(200).json({ success: true, reports });
  } catch (error) {
    console.error("Error in getAllMissingReports controller: ", error);
    res.status(500).json({ success: false, message: error.message });
  }
};
