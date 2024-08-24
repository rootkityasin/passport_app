const ApplicationService = require('../services/application.services');

exports.apply = async (req, res, next) => {
    try {
        const { applicationData } = req.body;

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
