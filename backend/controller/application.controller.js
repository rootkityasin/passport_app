const ApplicationService = require('../services/application.services');

exports.apply = async (req, res, next) => {
    try {
        const { userId,applicationData } = req.body;

        // Basic validation
        const requiredFields = ['personalInfo', 'presentAddress', 'permanentAddress'];
        for (let field of requiredFields) {
            if (!applicationData[field]) {
                return res.status(400).json({ error: `${field} is required` });
            }
        }

        const apply = await ApplicationService.applicationUser(applicationData);

        res.json({
            status: true,
            success: 'Applied successfully',
            apply
        });
    } catch (error) {
        console.error("Error in apply controller: ", error);
        res.status(500).json({
            status: false,
            message: error.message
        });
    }
};

exports.getAllApplications = async (req, res, next) => {
    try {
        const applications = await ApplicationService.getAllApplications();

        res.json({
            status: true,
            applications
        });
    } catch (error) {
        console.error("Error in getAllApplications controller: ", error);
        res.status(500).json({
            status: false,
            message: error.message
        });
    }
};

exports.deleteApplication = async (req, res) => {
    try {
      const applicationId = req.params.id;
      await Application.findByIdAndDelete(applicationId);
      res.status(200).json({ success: true, message: 'Application deleted successfully' });
    } catch (error) {
      res.status(500).json({ success: false, message: 'Failed to delete application' });
    }
  };
