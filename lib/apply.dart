import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  _ApplyPageState createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 1;
  DateTime? selectedDate;
  String? selectedCountry;
  String? selectedDistrict;
  String? selectedGender;
  String? selectedReligion;
  bool hasDualCitizenship = false;
  bool isMarried = false;

  final List<String> districts = [
    'Bagerhat', 'Bandarban', 'Barguna', 'Barisal', 'Bhola', 'Bogra', 'Brahmanbaria', 'Chandpur', 'Chapai Nawabganj', 'Chattogram', 'Chuadanga', 'Comilla', 'Cox\'s Bazar', 'Dhaka', 'Dinajpur', 'Faridpur', 'Feni', 'Gaibandha', 'Gazipur', 'Gopalganj', 'Habiganj', 'Jamalpur', 'Jashore', 'Jhalokathi', 'Jhenaidah', 'Joypurhat', 'Khagrachari', 'Khulna', 'Kishoreganj', 'Kurigram', 'Kushtia', 'Lakshmipur', 'Lalmonirhat', 'Madaripur', 'Magura', 'Manikganj', 'Meherpur', 'Moulvibazar', 'Munshiganj', 'Mymensingh', 'Naogaon', 'Narail', 'Narayanganj', 'Narsingdi', 'Natore', 'Netrokona', 'Nilphamari', 'Noakhali', 'Pabna', 'Panchagarh', 'Patuakhali', 'Pirojpur', 'Rajbari', 'Rajshahi', 'Rangamati', 'Rangpur', 'Satkhira', 'Shariatpur', 'Sherpur', 'Sirajganj', 'Sunamganj', 'Sylhet', 'Tangail', 'Thakurgaon'
  ];
  final List<String> countries = [
    'Bangladesh', 'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Canada', 'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo', 'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Eswatini', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Korea', 'North Macedonia', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Palestine', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Korea', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe'
  ]..sort();
  final List<String> religions = [
    'Islam', 'Hinduism', 'Christianity', 'Buddhism', 'Judaism', 'Sikhism', 'Other'
  ];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _givenNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _typeOfCitizenController = TextEditingController();
  final TextEditingController _nationalIdNoController = TextEditingController();
  final TextEditingController _birthRegistrationController = TextEditingController();
  final TextEditingController _countryOfOtherCitizenshipController = TextEditingController();
  final TextEditingController _foreignPassportNoController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _presentCountryController = TextEditingController();
  final TextEditingController _presentDistrictController = TextEditingController();
  final TextEditingController _presentPoliceStationController = TextEditingController();
  final TextEditingController _presentPostOfficeController = TextEditingController();
  final TextEditingController _presentPostalCodeController = TextEditingController();
  final TextEditingController _presentCityVillageHouseController = TextEditingController();
  final TextEditingController _presentRoadBlockSectorController = TextEditingController();
  final TextEditingController _permanentCountryController = TextEditingController();
  final TextEditingController _permanentDistrictController = TextEditingController();
  final TextEditingController _permanentPoliceStationController = TextEditingController();
  final TextEditingController _permanentPostOfficeController = TextEditingController();
  final TextEditingController _permanentPostalCodeController = TextEditingController();
  final TextEditingController _permanentCityVillageHouseController = TextEditingController();
  final TextEditingController _permanentRoadBlockSectorController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardholderNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  Future<void> submitApplication() async {
    final applicationData = {
      'personalInfo': {
        'fullName': _fullNameController.text,
        'givenName': _givenNameController.text,
        'surname': _surnameController.text,
        'dateOfBirth': selectedDate?.toIso8601String(),
        'countryOfBirth': selectedCountry,
        'districtOfBirth': selectedDistrict,
        'placeOfBirth': _placeOfBirthController.text,
        'gender': selectedGender,
        'religion': selectedReligion,
        'citizenType': _typeOfCitizenController.text,
        'dualCitizenshipStatus': hasDualCitizenship,
        'nationalId': _nationalIdNoController.text,
        'birthCertificate': _birthRegistrationController.text,
        'otherCitizenshipCountry': _countryOfOtherCitizenshipController.text,
        'foreignPassportNo': _foreignPassportNoController.text,
        'profession': _professionController.text,
        'contactNo': _contactNoController.text,
        'email': _emailController.text,
      },
      'presentAddress': {
        'country': _presentCountryController.text,
        'district': _presentDistrictController.text,
        'policeStation': _presentPoliceStationController.text,
        'postOffice': _presentPostOfficeController.text,
        'postCode': _presentPostalCodeController.text,
        'city': _presentCityVillageHouseController.text,
        'road': _presentRoadBlockSectorController.text,
      },
      'permanentAddress': {
        'country': _permanentCountryController.text,
        'district': _permanentDistrictController.text,
        'policeStation': _permanentPoliceStationController.text,
        'postOffice': _permanentPostOfficeController.text,
        'postCode': _permanentPostalCodeController.text,
        'city': _permanentCityVillageHouseController.text,
        'road': _permanentRoadBlockSectorController.text,
      },
      'paymentInfo': {
        'cardNumber': _cardNumberController.text,
        'cardholderName': _cardholderNameController.text,
        'expiryDate': _expiryDateController.text,
        'cvv': _cvvController.text,
      },
    };

    // Check for null or empty values
    applicationData.forEach((section, data) {
      data.forEach((key, value) {
        if (value == null || (value as String).isEmpty) {
          print('Field $key in section $section is empty or null');
        }
      });
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/apply'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(applicationData),
      );

      if (response.statusCode == 200) {
        // Handle successful submission
        print('Application submitted successfully');
      } else {
        // Handle error
        print('Failed to submit application: ${response.body}');
      }
    } catch (e) {
      print('Error submitting application: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Start New Application'),
      backgroundColor: const Color.fromARGB(122, 76, 175, 79), // Change AppBar color to green
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (currentStep > 1) {
            setState(() {
              currentStep--;
            });
          } else {
            Navigator.pop(context);
          }
        },
      ),
    ),
    body: Container(
      color: const Color.fromARGB(73, 19, 99, 32), // Set your desired theme color here
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stepper(
                  currentStep: currentStep - 1,
                  onStepTapped: (index) {
                    setState(() {
                      currentStep = index + 1;
                    });
                  },
                  steps: [
                    Step(
                      title: const Text('New Application'),
                      content: Column(
                        children: [
                          _buildTextField('Full Name'),
                          _buildTextField('Given Name'),
                          _buildTextField('Surname'),
                          _buildDatePickerField('Date Of Birth'),
                          _buildDropdownField('Country Of Birth', countries, 'Bangladesh'),
                          _buildDropdownField('District Of Birth', districts, null),
                          _buildTextField('Place Of Birth'),
                          _buildRadioButtonField('Gender', ['Male', 'Female', 'Others']),
                          _buildAutoSuggestField('Religion', religions),
                          _buildCitizenTypeField('Type Of Citizen', ['Citizen by Birth', 'Naturalized Citizen']),
                          _buildToggleIconField('Dual Citizenship Status', hasDualCitizenship),
                          _buildToggleIconField('Marital Status', isMarried),
                        ],
                      ),
                      isActive: currentStep >= 1,
                      state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Personal Information'),
                      content: Column(
                        children: [
                          _buildTextField('National ID No'),
                          _buildTextField('Birth Registration'),
                          _buildDropdownField('Country Of Other Citizenship (If Any)', countries, null),
                          _buildTextField('Foreign Passport No'),
                          _buildTextField('Profession'),
                          _buildTextField('Contact No'),
                          _buildTextField('Email'),
                        ],
                      ),
                      isActive: currentStep >= 2,
                      state: currentStep > 2 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Present Address'),
                      content: Column(
                        children: [
                          _buildDropdownField('Country', countries, null),
                          _buildTextField('District'),
                          _buildTextField('Police Station'),
                          _buildTextField('Post Office'),
                          _buildTextField('Postal Code'),
                          _buildTextField('City/Village/House'),
                          _buildTextField('Road/Block/Sector'),
                        ],
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep > 3 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Permanent Address'),
                      content: Column(
                        children: [
                          _buildDropdownField('Country', countries, null),
                          _buildTextField('District'),
                          _buildTextField('Police Station'),
                          _buildTextField('Post Office'),
                          _buildTextField('Postal Code'),
                          _buildTextField('City/Village/House'),
                          _buildTextField('Road/Block/Sector'),
                        ],
                      ),
                      isActive: currentStep >= 4,
                      state: currentStep > 4 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Payment'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Choose Payment Method',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          _buildPaymentOption('Bkash', 'images/bkash.png'),
                          const SizedBox(height: 16.0),
                          _buildPaymentOption('Nagad', 'images/nagad.png'),
                          const SizedBox(height: 24.0),
                          const Text(
                            'Enter Payment Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          _buildTextField('Card Number'),
                          _buildTextField('Cardholder Name'),
                          _buildTextField('Expiry Date'),
                          _buildTextField('CVV'),
                        ],
                      ),
                      isActive: currentStep >= 5,
                      state: currentStep > 5 ? StepState.complete : StepState.indexed,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitApplication,
                  child: const Text('Submit Application'),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget _buildTextField(String label) {
  return TextFormField(
    decoration: InputDecoration(labelText: label),
  );
}

Widget _buildDatePickerField(String label) {
  return TextFormField(
    decoration: InputDecoration(labelText: label),
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    },
  );
}

Widget _buildDropdownField(String label, List<String> items, String? initialValue) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(labelText: label),
    value: initialValue,
    items: items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (newValue) {
      setState(() {
        if (label == 'Country Of Birth') {
          selectedCountry = newValue;
        } else if (label == 'District Of Birth') {
          selectedDistrict = newValue;
        }
      });
    },
  );
}

Widget _buildRadioButtonField(String label, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      Row(
        children: options.map((option) {
          return Expanded(
            child: RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildAutoSuggestField(String label, List<String> suggestions) {
  return TextFormField(
    decoration: InputDecoration(labelText: label),
    onChanged: (value) {
      setState(() {
        selectedReligion = value;
      });
    },
  );
}

String? selectedCitizenType;

Widget _buildCitizenTypeField(String labelText, List<String> options) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: const TextStyle(fontSize: 16)),
        Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedCitizenType,
              onChanged: (value) {
                setState(() {
                  selectedCitizenType = value;
                });
              },
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildPaymentOption(String label, String imagePath) {
  return GestureDetector(
    onTap: () {
      // Handle payment option selection
      // You could navigate to a payment processing screen here
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade700, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 16.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildToggleIconField(String labelText, bool value) {
  String activeImage;
  String inactiveImage;

  switch (labelText) {
    case 'Dual Citizenship Status':
      activeImage = 'images/dual.png';
      inactiveImage = 'images/dual_border.png';
      break;
    case 'Marital Status':
      activeImage = 'images/favourite.png';
      inactiveImage = 'images/favourite_border.png';
      break;
    default:
      activeImage = 'images/dual.png';
      inactiveImage = 'images/dual.png';
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: ListTile(
      title: Text(labelText, style: const TextStyle(fontSize: 16)),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            if (labelText == 'Dual Citizenship Status') {
              hasDualCitizenship = !hasDualCitizenship;
            } else if (labelText == 'Marital Status') {
              isMarried = !isMarried;
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: value ? Colors.blue : Colors.grey, // Background color changes based on state
          ),
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            value ? activeImage : inactiveImage,
            width: 24,
            height: 24,
          ),
        ),
      ),
    ),
  );
}
}