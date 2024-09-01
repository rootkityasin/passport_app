const ApplicationModel = require('../model/application.model');

class ApplicationService {
    static async applicationUser(applicationData) {
        try {
            const saveApplication = new ApplicationModel(applicationData);
            return await saveApplication.save();
        } catch (err) {
            console.error("Failed to save the application: ", err);
            throw new Error('Failed to save the application');
        }
    }

    static async getAllApplications() {
        try {
            const applications = await ApplicationModel.find().populate('user');
            return applications;
        } catch (error) {
            console.error("Error fetching applications: ", error);
            throw new Error('Error fetching applications: ' + error.message);
        }
    }
}

module.exports = ApplicationService;
