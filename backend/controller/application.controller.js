
const ApplicationService = require('../services/application.services');

exports.apply = async (req, res,next) => {
    try {
        const { 
            personalInfo: {
                nationalId,
                birthCertificate,
                citizenship,
                dualCitizenship,
                otherCitizenshipCountry,
                foreignPassportNo,
                maritalStatus,
                profession,
                contactNo,
                email
            },
            permanentAddress: {
                district: permanentDistrict,
                policeStation: permanentPoliceStation,
                postOffice: permanentPostOffice,
                postCode: permanentPostCode,
                city: permanentCity,
                road: permanentRoad
            },
            presentAddress: {
                district: presentDistrict,
                policeStation: presentPoliceStation,
                postOffice: presentPostOffice,
                postCode: presentPostCode,
                city: presentCity,
                road: presentRoad
            }
        } = req.body;
    
        // Basic validation
        if (
            !nationalId || !birthCertificate || !citizenship || !dualCitizenship || !otherCitizenshipCountry ||
            !foreignPassportNo || !maritalStatus || !profession || !contactNo || !email ||
            !permanentDistrict || !permanentPoliceStation || !permanentPostOffice || !permanentPostCode || !permanentCity || !permanentRoad ||
            !presentDistrict || !presentPoliceStation || !presentPostOffice || !presentPostCode || !presentCity || !presentRoad
        ) {
            return res.status(400).json({ error: "All fields are required" });
         }
    
         const apply = await ApplicationService.applicationUser(nationalId,birthCertificate,citizenship,dualCitizenship,otherCitizenshipCountry,foreignPassportNo,
            maritalStatus,profession,contactNo,email,permanentDistrict,permanentPoliceStation,permanentPostOffice,permanentPostCode,permanentCity,
            permanentRoad,presentDistrict,presentPoliceStation,presentPostOffice,presentPostCode,presentCity,presentRoad
         )
         res.json({
            status:true,
            success:"apply successfully",
            apply
         })
    } catch (error) {
        res.status(500).json({
            status:false,
            message:error.message

        })
        console.log(error.message)
    }
   



 
};


