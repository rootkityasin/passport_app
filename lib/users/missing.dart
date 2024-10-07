import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MissingLostPage extends StatefulWidget {
  const MissingLostPage({super.key});

  @override
  _MissingLostPageState createState() => _MissingLostPageState();
}

class _MissingLostPageState extends State<MissingLostPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedCardText = 'Yes, I have a Machine Readable Passport (MRP)';
  final TextEditingController _reportedDateController = TextEditingController();
  final TextEditingController _previousPassportNumberController =
      TextEditingController();
  final TextEditingController _dateOfIssueController = TextEditingController();
  final TextEditingController _dateOfExpirationController =
      TextEditingController();
  final TextEditingController _policeCaseNumberController =
      TextEditingController();
  String? _selectedReissueReason;
  String? _selectedCountry;
  String? _selectedDistrict;
  String? _selectedPoliceStation;
  bool checkboxValue = false;
  String selectedOtherCountryOption = "No, I don't have";

  List<String> _getDistricts() {
    return [
      'Dhaka',
      'Chittagong',
      'Rajshahi',
      'Sylhet',
      'Khulna',
      'Barisal',
      'Rangpur',
      'Mymensingh'
    ];
  }

  List<String> _getPoliceStations() {
    return [
      'Gulshan',
      'Dhanmondi',
      'Khilgaon',
      'Mirpur',
      'Kotwali',
      'Tejgaon',
      'Motijheel',
      'Uttara'
    ];
  }

  List<String> _getCountries() {
    return [
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
    ];
  }

  @override
  void dispose() {
    _reportedDateController.dispose();
    _previousPassportNumberController.dispose();
    _dateOfIssueController.dispose();
    _dateOfExpirationController.dispose();
    _policeCaseNumberController.dispose();
    super.dispose();
  }

  Future<void> submitReport() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final reportData = {
      'passportType': selectedCardText,
      'reissueReason': _selectedReissueReason,
      'country': _selectedCountry,
      'policeCaseNumber': _policeCaseNumberController.text,
      'district': _selectedDistrict,
      'policeStation': _selectedPoliceStation,
      'reportedDate': _reportedDateController.text,
      'previousPassportNumber':
          checkboxValue ? null : _previousPassportNumberController.text,
      'dateOfIssue': checkboxValue ? null : _dateOfIssueController.text,
      'dateOfExpiration':
          checkboxValue ? null : _dateOfExpirationController.text,
      'unknownPreviousPassportData': checkboxValue,
      'otherCountryPassport': selectedOtherCountryOption,
    };

    final wrappedReportData = {
      'reportData': reportData,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/missing'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(wrappedReportData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final wrappedResponse = {
          'status': true,
          'success': 'Report submitted successfully',
          'report': responseData,
        };
        print(jsonEncode(wrappedResponse));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully!')),
        );

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Your report has been saved successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Failed to submit report: ${response.statusCode}');
        print('Response body: ${response.body}');
        print(wrappedReportData);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(122, 76, 175, 79),
        elevation: 0,
        title: const Text('Report Lost or Stolen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(73, 19, 99, 32).withOpacity(0.2),
              const Color.fromARGB(73, 19, 99, 32).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Do you have passports of other countries?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCardWithRadioButton(
                        context,
                        'Yes, I have a Machine Readable Passport (MRP)',
                        'images/mrp.jpg',
                        selectedCardText,
                        (String? newValue) {
                          setState(() {
                            selectedCardText = newValue!;
                          });
                        },
                      ),
                      _buildCardWithRadioButton(
                        context,
                        'Yes, I have an Electronic Passport (ePP)',
                        'images/epp.jpg',
                        selectedCardText,
                        (String? newValue) {
                          setState(() {
                            selectedCardText = newValue!;
                          });
                        },
                      ),
                      _buildCardWithRadioButton(
                        context,
                        "No, I don't have any previous passport / handwritten passport",
                        'images/no_passport.jpg',
                        selectedCardText,
                        (String? newValue) {
                          setState(() {
                            selectedCardText = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'What is the reason of your passport request?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          _buildDropdownField(
                            'Select reissue reason',
                            ['LOST', 'STOLEN'],
                            onChanged: (value) {
                              setState(() {
                                _selectedReissueReason = value;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Details of the Lost/Stolen passport?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          _buildDropdownField(
                            'Country of Police Station',
                            _getCountries(),
                            initialValue: 'Bangladesh',
                            onChanged: (value) {
                              setState(() {
                                _selectedCountry = value;
                              });
                            },
                          ),
                          _buildTextField(
                            label: 'Police case number with G.D. number',
                            controller: _policeCaseNumberController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          _buildDropdownField(
                            'Select district',
                            _getDistricts(),
                            onChanged: (value) {
                              setState(() {
                                _selectedDistrict = value;
                              });
                            },
                          ),
                          _buildDropdownField(
                            'Select police station',
                            _getPoliceStations(),
                            onChanged: (value) {
                              setState(() {
                                _selectedPoliceStation = value;
                              });
                            },
                          ),
                          _buildDatePickerField(
                            context,
                            'Select reported date',
                            _reportedDateController,
                          ),
                          _buildTextField(
                            label: 'Previous passport number',
                            controller: _previousPassportNumberController,
                            readOnly: checkboxValue,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                            fillColor: Colors.grey[300], // Grey color
                            validator: (value) {
                              if (!checkboxValue &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter previous passport number';
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDatePickerField(
                                  context,
                                  'Select date of issue',
                                  _dateOfIssueController,
                                  readOnly: checkboxValue,
                                  fillColor: Colors.grey[300], // Grey color
                                  validator: (value) {
                                    if (!checkboxValue &&
                                        (value == null || value.isEmpty)) {
                                      return 'Please select date of issue';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: _buildDatePickerField(
                                  context,
                                  'Select date of expiration',
                                  _dateOfExpirationController,
                                  readOnly: checkboxValue,
                                  fillColor: Colors.grey[300], // Grey color
                                  validator: (value) {
                                    if (!checkboxValue &&
                                        (value == null || value.isEmpty)) {
                                      return 'Please select date of expiration';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: checkboxValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkboxValue = value ?? false;
                                    if (checkboxValue) {
                                      _previousPassportNumberController.clear();
                                      _dateOfIssueController.clear();
                                      _dateOfExpirationController.clear();
                                    }
                                  });
                                },
                              ),
                              const Text(
                                  "I don't know the data of the previous passport"),
                            ],
                          ),
                          const SizedBox(height: 30),
                          _buildOtherCountryRadio(
                            selectedOtherCountryOption,
                            (String? value) {
                              setState(() {
                                selectedOtherCountryOption = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                submitReport();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all fields')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Submit Report'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardWithRadioButton(BuildContext context, String text,
      String imagePath, String groupValue, void Function(String?) onChanged) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            onChanged(text);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  height: 80,
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                Radio<String>(
                  value: text,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      {String? initialValue, void Function(String?)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: initialValue,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    bool readOnly = false,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    Color? fillColor,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: fillColor != null,
        fillColor: fillColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: validator,
    );
  }

  Widget _buildDatePickerField(
      BuildContext context, String label, TextEditingController controller,
      {bool readOnly = false,
      Color? fillColor,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
          filled: fillColor != null,
          fillColor: fillColor,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
        readOnly: readOnly,
        onTap: readOnly ? null : () => _selectDate(context, controller),
        style: const TextStyle(color: Colors.black),
        validator: validator,
      ),
    );
  }

  Widget _buildOtherCountryRadio(
      String groupValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Do you have passports of other countries?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        RadioListTile<String>(
          title: const Text("No, I don't have"),
          value: "No, I don't have",
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        RadioListTile<String>(
          title: const Text("Yes, I have another passport"),
          value: "Yes, I have another passport",
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
}
