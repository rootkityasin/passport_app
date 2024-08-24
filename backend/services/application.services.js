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
}

module.exports = ApplicationService;
