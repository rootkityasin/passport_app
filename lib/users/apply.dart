import 'package:flutter/material.dart';
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
  String? selectedPlaceOfBirth;
  String? selectedGender;
  String? selectedCitizenType;
  String? selectedReligion;
  bool hasDualCitizenship = false;
  String? selectedotherCitizenship;
  
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
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _foreignPassportNoController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _spouseNationalityController = TextEditingController();
  final TextEditingController _spouseProfessionController = TextEditingController();
  final TextEditingController _spousePassportNoController = TextEditingController();
  final TextEditingController _spouseNationalIdController = TextEditingController();

  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _birthCertificateController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _presentDistrictController = TextEditingController();
  final TextEditingController _presentPoliceStationController = TextEditingController();
  final TextEditingController _presentPostOfficeController = TextEditingController();
  final TextEditingController _presentPostalCodeController = TextEditingController();
  final TextEditingController _presentCityVillageHouseController = TextEditingController();
  final TextEditingController _presentRoadBlockSectorController = TextEditingController();

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

 @override
  void dispose() {
    _fullNameController.dispose();
    _givenNameController.dispose();
    _surnameController.dispose();
    _dateOfBirthController.dispose();
    _nationalityController.dispose();
    _foreignPassportNoController.dispose();
    _spouseNameController.dispose();
    _spouseNationalityController.dispose();
    _spouseProfessionController.dispose();
    _spousePassportNoController.dispose();
    _spouseNationalIdController.dispose();

    _nationalIdController.dispose();
    _birthCertificateController.dispose();
    _professionController.dispose();
    _contactNoController.dispose();
    _emailController.dispose();

    _presentDistrictController.dispose();
    _presentPoliceStationController.dispose();
    _presentPostOfficeController.dispose();
    _presentPostalCodeController.dispose();
    _presentCityVillageHouseController.dispose();
    _presentRoadBlockSectorController.dispose();

    _permanentDistrictController.dispose();
    _permanentPoliceStationController.dispose();
    _permanentPostOfficeController.dispose();
    _permanentPostalCodeController.dispose();
    _permanentCityVillageHouseController.dispose();
    _permanentRoadBlockSectorController.dispose();
    
    _cardNumberController.dispose();
    _cardholderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    

    super.dispose();
  }

Future<void> submitApplication() async {
  final applicationData = {
    'personalInfo': {
      'fullName': _fullNameController.text,
      'givenName': _givenNameController.text,
      'surname': _surnameController.text,
      'dateOfBirth': _dateOfBirthController.text,
      'countryOfBirth': selectedCountry ?? 'Bangladesh',
      'nationality': _nationalityController.text,
      'placeOfBirth': selectedPlaceOfBirth,
      'gender': selectedGender,
      'citizenType': selectedCitizenType,
      'religion': selectedReligion,
      'dualCitizenshipStatus': hasDualCitizenship,
      'otherCitizenshipCountry': selectedotherCitizenship,
      'foreignPassportNo': _foreignPassportNoController.text,
      'maritalStatus': isMarried,
      'spouseName': _spouseNameController.text,
      'spouseNationality': _spouseNationalityController.text,
      'spouseProfession': _spouseProfessionController.text,
      'spousePassportNo': _spousePassportNoController.text,
      'spouseNationalId': _spouseNationalIdController.text,
      'nationalId': _nationalIdController.text,
      'birthCertificateNo': _birthCertificateController.text,
      'profession': _professionController.text,
      'contactNo': _contactNoController.text,
      'email': _emailController.text,
    },
    'presentAddress': {
      'district': _presentDistrictController.text,
      'policeStation': _presentPoliceStationController.text,
      'postOffice': _presentPostOfficeController.text,
      'postCode': _presentPostalCodeController.text,
      'city': _presentCityVillageHouseController.text,
      'road': _presentRoadBlockSectorController.text,
    },
    'permanentAddress': {
      'district': _permanentDistrictController.text,
      'policeStation': _permanentPoliceStationController.text,
      'postOffice': _permanentPostOfficeController.text,
      'postCode': _permanentPostalCodeController.text,
      'city': _permanentCityVillageHouseController.text,
      'road': _permanentRoadBlockSectorController.text,
    },
  };

  final wrappedApplicationData = {
    'applicationData': applicationData,
  };

  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/users/apply'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(wrappedApplicationData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final wrappedResponse = {
          'status': true,
          'success': 'Applied successfully',
          'apply': responseData,
        };
        print(jsonEncode(wrappedResponse));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully!')),
      );


      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Your application has been saved successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('Failed to apply: ${response.statusCode}');
      print('Response body: ${response.body}');
        print(wrappedApplicationData);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> verifyApplicationId(String applicationId) async {
  final url = Uri.parse('http://localhost:3000/api/apply/getApplicationId/$applicationId');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success']) {
      print('Application ID $applicationId recorded on blockchain');
    } else {
      print('Application ID $applicationId not found on blockchain');
    }
  } else {
    print('Failed to verify application ID');
  }
}


bool _validatePersonalInfo() {
  return _fullNameController.text.isNotEmpty &&
      _givenNameController.text.isNotEmpty &&
      _surnameController.text.isNotEmpty &&
      _dateOfBirthController.text.isNotEmpty &&

      _nationalityController.text.isNotEmpty &&
      selectedPlaceOfBirth != null &&
      selectedGender != null &&
      selectedCitizenType != null &&
      selectedReligion != null &&
      _nationalIdController.text.isNotEmpty &&
      _birthCertificateController.text.isNotEmpty &&
      _professionController.text.isNotEmpty &&
      _contactNoController.text.isNotEmpty &&
      _emailController.text.isNotEmpty;
}

bool _validatePresentAddress() {
  return _presentDistrictController.text.isNotEmpty &&
      _presentPoliceStationController.text.isNotEmpty &&
      _presentPostOfficeController.text.isNotEmpty &&
      _presentPostalCodeController.text.isNotEmpty &&
      _presentCityVillageHouseController.text.isNotEmpty &&
      _presentRoadBlockSectorController.text.isNotEmpty;
}

bool _validatePermanentAddress() {
  return _permanentDistrictController.text.isNotEmpty &&
      _permanentPoliceStationController.text.isNotEmpty &&
      _permanentPostOfficeController.text.isNotEmpty &&
      _permanentPostalCodeController.text.isNotEmpty &&
      _permanentCityVillageHouseController.text.isNotEmpty &&
      _permanentRoadBlockSectorController.text.isNotEmpty;
}

bool _validatePaymentInfo() {
  return true; 
}

bool _validateCurrentStep() {
  switch (currentStep) {
    case 1:
      return _validatePersonalInfo();
    case 2:
      return _validatePresentAddress();
    case 3:
      return _validatePermanentAddress();
    case 4:
      return _validatePaymentInfo();
    default:
      return false;
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Start New Application'),
      backgroundColor: const Color.fromARGB(122, 76, 175, 79),
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
      color: const Color.fromARGB(73, 19, 99, 32),
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
                  onStepContinue: () {
                    if (_validateCurrentStep()) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please complete all required fields.')),
                        );
                      }
                    }
                  },
                  onStepCancel: currentStep > 1
                      ? () {
                          setState(() {
                            currentStep--;
                          });
                        }
                      : null,
                  steps: [
                    Step(
                      title: const Text('Personal Information'),
                      content: Column(
                        children: [
                          _buildTextField('Full Name', _fullNameController),
                          _buildTextField('Given Name', _givenNameController),
                          _buildTextField('Surname', _surnameController),
                          _buildDatePickerField('Date Of Birth', _dateOfBirthController),
                          _buildDropdownField('Country Of Birth', countries, 'Bangladesh'),
                          _buildTextField('Nationality', _nationalityController),
                          _buildDropdownField('Place Of Birth', districts, null),
                          _buildRadioButtonField('Gender', ['Male', 'Female', 'Others']),
                          _buildRadioButtonField('Type Of Citizen', ['Citizen by Birth', 'Naturalized Citizen']),
                          _buildAutoSuggestField('Religion', religions),
                          _buildToggleIconField('Dual Citizenship Status', hasDualCitizenship),
                          if (hasDualCitizenship) ...[
                            _buildDropdownField('Country of Other Citizenship', countries, null),
                            _buildTextField('Foreign Passport No', _foreignPassportNoController),
                          ],
                          _buildToggleIconField('Marital Status', isMarried),
                          if (isMarried) ...[
                            _buildTextField('Spouse Name', _spouseNameController),
                            _buildTextField('Spouse Nationality', _spouseNationalityController),
                            _buildTextField('Spouse Profession', _spouseProfessionController),
                            _buildTextField('Spouse Passport Number (if any)', _spousePassportNoController),
                            _buildTextField('Spouse National ID', _spouseNationalIdController),
                          ],
                          _buildTextField('National ID No', _nationalIdController),
                          _buildTextField('Birth Registration', _birthCertificateController),
                          _buildTextField('Profession', _professionController),
                          _buildTextField('Contact No', _contactNoController),
                          _buildTextField('Email', _emailController),
                        ],
                      ),
                      isActive: currentStep >= 1,
                      state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Present Address'),
                      content: Column(
                        children: [
                          _buildTextField('District', _presentDistrictController),
                          _buildTextField('Police Station', _presentPoliceStationController),
                          _buildTextField('Post Office', _presentPostOfficeController),
                          _buildTextField('Postal Code', _presentPostalCodeController),
                          _buildTextField('City/Village/House', _presentCityVillageHouseController),
                          _buildTextField('Road/Block/Sector', _presentRoadBlockSectorController),
                        ],
                      ),
                      isActive: currentStep >= 2,
                      state: currentStep > 2 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Permanent Address'),
                      content: Column(
                        children: [
                          _buildTextField('District', _permanentDistrictController),
                          _buildTextField('Police Station', _permanentPoliceStationController),
                          _buildTextField('Post Office', _permanentPostOfficeController),
                          _buildTextField('Postal Code', _permanentPostalCodeController),
                          _buildTextField('City/Village/House', _permanentCityVillageHouseController),
                          _buildTextField('Road/Block/Sector', _permanentRoadBlockSectorController),
                        ],
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep > 3 ? StepState.complete : StepState.indexed,
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
                        ],
                      ),
                      isActive: currentStep >= 4,
                      state: currentStep > 4 ? StepState.complete : StepState.indexed,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (currentStep == 4) // Show the submit button only on the last step
                  ElevatedButton(
                    onPressed: _formKey.currentState!.validate()
                        ? () {
                            submitApplication();
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        _formKey.currentState!.validate() ? Colors.green : Colors.grey,
                      ),
                    ),
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

Widget _buildTextField(String label, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $label';
      }
      return null;
    },
  );
}

Widget _buildDatePickerField(String label, TextEditingController controller) {
  return TextFormField(
    controller: _dateOfBirthController,
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
          _dateOfBirthController.text = "${pickedDate.toLocal()}".split(' ')[0];
        });
      }
    },
    validator: (value) {
      if (selectedDate == null) {
        return 'Please select $label';
      }
      return null;
    },
  );
}

Widget _buildDropdownField(String label, List<String> items, String? initialValue,) {
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
        } else if (label == 'Place Of Birth') {
          selectedPlaceOfBirth = newValue;
        } else if (label == 'Country of Other Citizenship') {
          selectedotherCitizenship = newValue;
        }
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select $label';
      }
      return null;
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
              groupValue: label == 'Gender' ? selectedGender : selectedCitizenType,
              onChanged: (value) {
                setState(() {
                  if (label == 'Gender') {
                    selectedGender = value;
                  } else {
                    selectedCitizenType = value;
                  }
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
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text.isEmpty) {
        return const Iterable<String>.empty();
      }
      return suggestions.where((String option) {
        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
      });
    },
    onSelected: (String selection) {
      setState(() {
        selectedReligion = selection;
      });
    },
    fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
      return TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(labelText: label),
        onChanged: (value) {
          setState(() {
            selectedReligion = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      );
    },
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
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
                color: value ? Colors.blue : Colors.grey,
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
      ],
    ),
  );
}
}  