// services/missing.services.js
const Report = require('../models/report.model'); // Update path to the correct model file

class ReportService {
  // Method to create a new report
  static async createReport(reportData) {
    try {
      const report = new Report(reportData);
      await report.save();
      return report;
    } catch (error) {
      throw new Error('Failed to create report: ' + error.message);
    }
  }

  // Method to fetch all reports
  static async getAllReports() {
    try {
      const reports = await Report.find();
      return reports;
    } catch (error) {
      throw new Error('Failed to retrieve reports: ' + error.message);
    }
  }
}

module.exports = ReportService;
