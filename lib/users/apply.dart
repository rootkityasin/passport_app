import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms_flutter_app/config.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  _ApplyPageState createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  final _pageController = PageController();
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  // Controllers for Personal Info
  final _nationalIdController = TextEditingController();
  final _birthCertificateController = TextEditingController();
  final _citizenshipController = TextEditingController();
  final _dualCitizenshipController = TextEditingController();
  final _otherCitizenshipCountryController = TextEditingController();
  final _foreignPassportNoController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _professionController = TextEditingController();
  final _contactNoController = TextEditingController();
  final _emailController = TextEditingController();

  // Controllers for Permanent Address
  final _permanentDistrictController = TextEditingController();
  final _permanentPoliceStationController = TextEditingController();
  final _permanentPostOfficeController = TextEditingController();
  final _permanentPostCodeController = TextEditingController();
  final _permanentCityController = TextEditingController();
  final _permanentRoadController = TextEditingController();

  // Controllers for Present Address
  final _presentDistrictController = TextEditingController();
  final _presentPoliceStationController = TextEditingController();
  final _presentPostOfficeController = TextEditingController();
  final _presentPostCodeController = TextEditingController();
  final _presentCityController = TextEditingController();
  final _presentRoadController = TextEditingController();

  int currentStep = 1;

  Future<void> saveApplication() async {
    final applicationData = {
      'personalInfo': {
        'nationalId': _nationalIdController.text,
        'birthCertificate': _birthCertificateController.text,
        'citizenship': _citizenshipController.text,
        'dualCitizenship': _dualCitizenshipController.text,
        'otherCitizenshipCountry': _otherCitizenshipCountryController.text,
        'foreignPassportNo': _foreignPassportNoController.text,
        'maritalStatus': _maritalStatusController.text,
        'profession': _professionController.text,
        'contactNo': _contactNoController.text,
        'email': _emailController.text,
      },
      'permanentAddress': {
        'district': _permanentDistrictController.text,
        'policeStation': _permanentPoliceStationController.text,
        'postOffice': _permanentPostOfficeController.text,
        'postCode': _permanentPostCodeController.text,
        'city': _permanentCityController.text,
        'road': _permanentRoadController.text,
      },
      'presentAddress': {
        'district': _presentDistrictController.text,
        'policeStation': _presentPoliceStationController.text,
        'postOffice': _presentPostOfficeController.text,
        'postCode': _presentPostCodeController.text,
        'city': _presentCityController.text,
        'road': _presentRoadController.text,
      },
    };

    try {
      final response = await http.post(
        Uri.parse(userapply),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(applicationData),
      );

      if (response.statusCode == 200) {
        print('Application successful: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application successful!'),
            backgroundColor: Colors.green,
          ),
        );
        _clearFields();
      } else {
        print('Failed to apply: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to apply. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearFields() {
    _nationalIdController.clear();
    _birthCertificateController.clear();
    _citizenshipController.clear();
    _dualCitizenshipController.clear();
    _otherCitizenshipCountryController.clear();
    _foreignPassportNoController.clear();
    _maritalStatusController.clear();
    _professionController.clear();
    _contactNoController.clear();
    _emailController.clear();

    _permanentDistrictController.clear();
    _permanentPoliceStationController.clear();
    _permanentPostOfficeController.clear();
    _permanentPostCodeController.clear();
    _permanentCityController.clear();
    _permanentRoadController.clear();

    _presentDistrictController.clear();
    _presentPoliceStationController.clear();
    _presentPostOfficeController.clear();
    _presentPostCodeController.clear();
    _presentCityController.clear();
    _presentRoadController.clear();
  }

  DateTime? selectedDate;
  String? selectedCountry;
  String? selectedDistrict;
  String? selectedGender;
  String? selectedReligion;
  bool hasDualCitizenship = false;
  bool isMarried = false;
  final List<String> districts = [
    'Bagerhat',
    'Bandarban',
    'Barguna',
    'Barisal',
    'Bhola',
    'Bogra',
    'Brahmanbaria',
    'Chandpur',
    'Chapai Nawabganj',
    'Chattogram',
    'Chuadanga',
    'Comilla',
    'Cox\'s Bazar',
    'Dhaka',
    'Dinajpur',
    'Faridpur',
    'Feni',
    'Gaibandha',
    'Gazipur',
    'Gopalganj',
    'Habiganj',
    'Jamalpur',
    'Jashore',
    'Jhalokathi',
    'Jhenaidah',
    'Joypurhat',
    'Khagrachari',
    'Khulna',
    'Kishoreganj',
    'Kurigram',
    'Kushtia',
    'Lakshmipur',
    'Lalmonirhat',
    'Madaripur',
    'Magura',
    'Manikganj',
    'Meherpur',
    'Moulvibazar',
    'Munshiganj',
    'Mymensingh',
    'Naogaon',
    'Narail',
    'Narayanganj',
    'Narsingdi',
    'Natore',
    'Netrokona',
    'Nilphamari',
    'Noakhali',
    'Pabna',
    'Panchagarh',
    'Patuakhali',
    'Pirojpur',
    'Rajbari',
    'Rajshahi',
    'Rangamati',
    'Rangpur',
    'Satkhira',
    'Shariatpur',
    'Sherpur',
    'Sirajganj',
    'Sunamganj',
    'Sylhet',
    'Tangail',
    'Thakurgaon'
  ];
  final List<String> countries = [
    'Bangladesh',
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ]..sort();
  final List<String> religions = [
    'Islam',
    'Hinduism',
    'Christianity',
    'Buddhism',
    'Judaism',
    'Sikhism',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start New Application'),
        backgroundColor: const Color.fromARGB(
            122, 76, 175, 79), // Change AppBar color to green
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
        color: const Color.fromARGB(
            73, 19, 99, 32), // Set your desired theme color here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                      title: const Text('Personal Information'),
                      content: Column(
                        children: [
                          _buildTextField('Full Name'),
                          _buildTextField('Given Name'),
                          _buildTextField('Surname'),
                          _buildDatePickerField('Date Of Birth'),
                          _buildDropdownField(
                              'Country Of Birth', countries, 'Bangladesh'),
                          _buildDropdownField(
                              'District Of Birth', districts, null),
                          _buildTextField('Place Of Birth'),
                          _buildRadioButtonField('Gender', ['Male', 'Female']),
                          _buildAutoSuggestField('Religion', religions),
                          _buildCitizenTypeField('Type Of Citizen',
                              ['Citizen by Birth', 'Naturalized Citizen']),
                          _buildToggleIconField(
                              'Dual Citizenship Status', hasDualCitizenship),
                          _buildToggleIconField('Marital Status', isMarried),
                          _buildTextField('National ID No'),
                          _buildTextField('Birth Registration'),
                          _buildDropdownField(
                              'Country Of Other Citizenship (If Any)',
                              countries,
                              null),
                          _buildTextField('Foreign Passport No'),
                          _buildTextField('Marital Status'),
                          _buildTextField('Profession'),
                          _buildTextField('Contact No'),
                          _buildTextField('Email'),
                        ],
                      ),
                      isActive: currentStep >= 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    // Step(
                    //   title: const Text('Personal Information'),
                    //   content: Column(
                    //     children: [
                    //
                    //     ],
                    //   ),
                    //   isActive: currentStep >= 2,
                    //   state: currentStep > 2
                    //       ? StepState.complete
                    //       : StepState.indexed,
                    // ),
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
                      ), //fd
                      isActive: currentStep >= 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
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
                      isActive: currentStep >= 3,
                      state: currentStep > 3
                          ? StepState.complete
                          : StepState.indexed,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          _buildTextField('Card Number', isNumeric: true),
                          const SizedBox(height: 16.0),
                          _buildTextField('Cardholder Name'),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField('Expiry Date (MM/YY)',
                                    isNumeric: true),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: _buildTextField('CVV',
                                    isNumeric: true, obscureText: true),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (bool? value) {
                                  // Handle checkbox state
                                },
                              ),
                              const Text('Save card for future payments'),
                            ],
                          ),
                        ],
                      ),
                      isActive: currentStep >= 4,
                      state: currentStep > 4
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                  onStepContinue: () {
                    if (currentStep < 4) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      // Handle form submission here
                    }
                  },
                  onStepCancel: () {
                    if (currentStep > 1) {
                      setState(() {
                        currentStep--;
                      });
                    }
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep < 4)
                          ElevatedButton(
                            onPressed: controls.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.green, // Change button color to green
                            ),
                            child: const Text('Next'),
                          ),
                        if (currentStep == 4)
                          ElevatedButton(
                            onPressed: () {
                              // Handle form submission here
                            },
                            child: const Text('Submit'),
                          ),
                        if (currentStep > 1)
                          TextButton(
                            onPressed: controls.onStepCancel,
                            child: const Text('Back'),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText,
      {bool isNumeric = false, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: TextField(
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // More rounded corners
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 6.0, horizontal: 12.0), // Smaller height
          filled: true,
          fillColor: const Color.fromARGB(
              255, 255, 255, 255), // Background color set to white
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: InkWell(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              selectedDate = pickedDate;
            });
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), // More rounded corners
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 6.0, horizontal: 12.0), // Smaller height
            filled: true,
            fillColor: const Color.fromARGB(
                255, 255, 255, 255), // Background color set to white
          ),
          child: Text(
            selectedDate != null
                ? selectedDate!.toLocal().toString().split(' ')[0]
                : 'Select Date',
            style: TextStyle(
                color: selectedDate != null ? Colors.black : Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String labelText, List<String> items, String? initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 9.0, top: 16.0), // Added top padding to start a bit lower
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // More rounded corners
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 6.0, horizontal: 12.0), // Smaller height
          filled: true,
          fillColor: const Color.fromARGB(
              255, 255, 255, 255), // Background color set to white
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              'Select your district',
              style: TextStyle(
                  color: Colors.grey
                      .withOpacity(0.6)), // Less opacity for hint text
            ),
            value: initialValue,
            isDense: true,
            onChanged: (String? newValue) {
              setState(() {
                initialValue = newValue;
              });
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtonField(String labelText, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: const TextStyle(fontSize: 16)),
          Row(
            children: options.map((option) {
              return Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: selectedGender,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  Text(option),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoSuggestField(String labelText, List<String> suggestions) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return suggestions.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          setState(() {
            selectedReligion = selection;
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // More rounded corners
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 6.0, horizontal: 12.0), // Smaller height
              filled: true,
              fillColor: const Color.fromARGB(
                  255, 255, 255, 255), // Background color set to white
            ),
          );
        },
      ),
    );
  }

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
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Apply',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            // CircleAvatar(
            //   radius: 20,
            //   backgroundImage: AssetImage('images/wahab.png'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleIconField(String labelText, bool value) {
    String activeImage;
    String inactiveImage;

    if (labelText == 'Dual Citizenship Status') {
      activeImage = 'images/dual.png';
      inactiveImage = 'images/dual_border.png';
    } else if (labelText == 'Marital Status') {
      activeImage = 'images/favourite.png';
      inactiveImage = 'images/favourite_border.png';
    } else {
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
              color: value
                  ? Colors.blue
                  : Colors.grey, // Background color changes based on state
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

  Widget _buildPersonalInfoForm() {
    return Form(
      key: _formKeys[0],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Personal Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nationalIdController,
                  decoration:
                      const InputDecoration(labelText: 'National ID No'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _birthCertificateController,
                  decoration:
                      const InputDecoration(labelText: 'Birth Certificate No'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _citizenshipController,
                  decoration:
                      const InputDecoration(labelText: 'Type of Citizenship'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _dualCitizenshipController,
                  decoration:
                      const InputDecoration(labelText: 'Dual Citizenship'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _otherCitizenshipCountryController,
                  decoration: const InputDecoration(
                      labelText: 'Country of Other Citizenship'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _foreignPassportNoController,
                  decoration:
                      const InputDecoration(labelText: 'Foreign Passport No'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _maritalStatusController,
                  decoration:
                      const InputDecoration(labelText: 'Marital Status'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _professionController,
                  decoration: const InputDecoration(labelText: 'Profession'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _contactNoController,
                  decoration: const InputDecoration(labelText: 'Contact No'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermanentAddressForm() {
    return Form(
      key: _formKeys[1],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Permanent Address",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Column(
              children: [
                TextFormField(
                  controller: _permanentDistrictController,
                  decoration: const InputDecoration(labelText: 'District'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _permanentPoliceStationController,
                  decoration:
                      const InputDecoration(labelText: 'Police Station'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _permanentPostOfficeController,
                  decoration: const InputDecoration(labelText: 'Post Office'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _permanentPostCodeController,
                  decoration: const InputDecoration(labelText: 'Post Code'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _permanentCityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _permanentRoadController,
                  decoration: const InputDecoration(labelText: 'Road'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresentAddressForm() {
    return Form(
      key: _formKeys[2],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Present Address",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Column(
              children: [
                TextFormField(
                  controller: _presentDistrictController,
                  decoration: const InputDecoration(labelText: 'District'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _presentPoliceStationController,
                  decoration:
                      const InputDecoration(labelText: 'Police Station'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _presentPostOfficeController,
                  decoration: const InputDecoration(labelText: 'Post Office'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _presentPostCodeController,
                  decoration: const InputDecoration(labelText: 'Post Code'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _presentCityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _presentRoadController,
                  decoration: const InputDecoration(labelText: 'Road'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}