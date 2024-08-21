const ApplicationModel = require('../model/application.model');
class ApplicationService{
    static async applicationUser(applicationSchema) {
    try {
        const saveApplication = new ApplicationModel(applicationSchema)

        return await saveApplication.save();
        //console.log(saveApplication);
       // res.status(201).json({savedApplication}); // Send status 201 for a successful creation
    } catch (err) {
        console.error(err);
       //res.status(500).json({ error: "Failed to save the application" }); // Send status 500 for server errors
    }
}
}

module.exports = ApplicationService;