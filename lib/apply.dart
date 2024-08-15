import 'package:flutter/material.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  _ApplyPageState createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start New Application'),
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
      body: Padding(
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
                        _buildCheckmarkField('Type Of Citizen', ['Citizen by Birth', 'Naturalized Citizen']),
                        _buildToggleIconField('Dual Citizenship Status', hasDualCitizenship),
                        _buildToggleIconField('Marital Status', isMarried),
                      ],
                    ),
                    isActive: currentStep >= 1,
                  ),
                  Step(
                    title: const Text('Personal Information'),
                    content: Column(
                      children: [
                        _buildTextField('National ID No'),
                        _buildTextField('Birth Registration'),
                        _buildTextField('Type Of Citizen'),
                        _buildTextField('Dual Citizenship Status'),
                        _buildDropdownField('Country Of Other Citizenship', countries, null),
                        _buildTextField('Foreign Passport No'),
                        _buildTextField('Marital Status'),
                        _buildTextField('Profession'),
                        _buildTextField('Contact No'),
                        _buildTextField('Email'),
                      ],
                    ),
                    isActive: currentStep >= 2,
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
                  ),
                  Step(
                    title: const Text('Payment'),
                    content: Column(
                      children: [
                        _buildTextField('Bkash'),
                        _buildTextField('Nagad'),
                      ],
                    ),
                    isActive: currentStep >= 5,
                  ),
                ],
                onStepContinue: () {
                  if (currentStep < 5) {
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
                controlsBuilder: (BuildContext context, ControlsDetails controls) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentStep < 5)
                        ElevatedButton(
                          onPressed: controls.onStepContinue,
                          child: const Text('Next'),
                        ),
                      if (currentStep == 5)
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
    );
  }

  Widget _buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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
            border: OutlineInputBorder(),
          ),
          child: Text(
            selectedDate != null ? selectedDate!.toLocal().toString().split(' ')[0] : 'Select Date',
            style: TextStyle(color: selectedDate != null ? Colors.black : Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String labelText, List<String> items, String? initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: initialValue == 'Bangladesh' ? 'Bangladesh' : (labelText == 'Country Of Birth' ? selectedCountry : selectedDistrict),
            isDense: true,
            onChanged: (String? newValue) {
              setState(() {
                if (labelText == 'Country Of Birth' || labelText == 'Country') {
                  selectedCountry = newValue;
                } else {
                  selectedDistrict = newValue;
                }
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
          Text(labelText, style: TextStyle(fontSize: 16)),
          ...options.map((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                activeColor: Colors.green, // Use green color for radio button
              )),
        ],
      ),
    );
  }

  Widget _buildAutoSuggestField(String labelText, List<String> suggestions) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Autocomplete<String>(
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
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCheckmarkField(String labelText, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(fontSize: 16)),
          ...options.map((option) => CheckboxListTile(
                title: Text(option),
                value: selectedGender == option,
                onChanged: (bool? value) {
                  setState(() {
                    selectedGender = value! ? option : null;
                  });
                },
              )),
        ],
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
      title: Text(labelText, style: TextStyle(fontSize: 16)),
      trailing: IconButton(
        icon: Image.asset(
          value ? activeImage : inactiveImage,
        ),
        onPressed: () {
          setState(() {
            if (labelText == 'Dual Citizenship Status') {
              hasDualCitizenship = !hasDualCitizenship;
            } else if (labelText == 'Marital Status') {
              isMarried = !isMarried;
            }
          });
        },
      ),
    ),
  );
}
}