import 'dart:ui';
import 'package:flutter/material.dart';

class MissingLostPage extends StatefulWidget {
  const MissingLostPage({super.key});

  @override
  _MissingLostPageState createState() => _MissingLostPageState();
}

class _MissingLostPageState extends State<MissingLostPage> {
  int _selectedRadio = 1;
  TextEditingController _reportedDateController = TextEditingController();
  TextEditingController _previousPassportNumberController = TextEditingController();
  TextEditingController _dateOfIssueController = TextEditingController();
  TextEditingController _dateOfExpirationController = TextEditingController();
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Report Lost or Stolen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCardWithRadioButton(
                      context,
                      'Yes, I have a Machine Readable Passport (MRP)',
                      'images/mrp.jpg', 
                      1,
                    ),
                    _buildCardWithRadioButton(
                      context,
                      'Yes, I have an Electronic Passport (ePP)',
                      'images/epp.jpg', 
                      2,
                    ),
                    _buildCardWithRadioButton(
                      context,
                      "No, I don't have any previous passport / handwritten passport",
                      'images/no_passport.jpg', 
                      3,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildDropdownField('Select reissue reason', ['LOST/STOLEN']),
                        _buildDropdownField('Country of Police Station', ['BANGLADESH'], initialValue: 'BANGLADESH'),
                        _buildTextField(
                          label: 'Police case number with G.D. number',
                          controller: _reportedDateController,
                          readOnly: false,
                        ),
                        _buildDropdownField('Select district', _getDistricts()),
                        _buildDropdownField('Select police station', _getPoliceStations()),
                        _buildDatePickerField(context, 'Select reported date', _reportedDateController),
                        _buildTextField(
                          label: 'Previous passport number',
                          controller: _previousPassportNumberController,
                          readOnly: _checkboxValue,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDatePickerField(
                                context,
                                'Select date of issue',
                                _dateOfIssueController,
                                readOnly: _checkboxValue,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildDatePickerField(
                                context,
                                'Select date of expiration',
                                _dateOfExpirationController,
                                readOnly: _checkboxValue,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _checkboxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _checkboxValue = value ?? false;
                                });
                              },
                            ),
                            const Text("I don't know the data of the previous passport"),
                          ],
                        ),

                        // Adding the radio button section at the bottom
                        const SizedBox(height: 30),
                        const Text(
                          'Do you have passports of other countries?',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        RadioListTile<int>(
                          title: const Text("No, I don't have"),
                          value: 1,
                          groupValue: _selectedRadio,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRadio = value!;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: const Text("Yes, I have another passport"),
                          value: 2,
                          groupValue: _selectedRadio,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRadio = value!;
                            });
                          },
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
    );
  }

  Widget _buildCardWithRadioButton(BuildContext context, String text, String imagePath, int value) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedRadio = value;
            });
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
                Radio(
                  value: value,
                  groupValue: _selectedRadio,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedRadio = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, {String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        value: initialValue,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[300], // Set grey color for the field
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Change the border color when focused
            width: 2.0,
          ),
        ),
      ),
      style: TextStyle(color: Colors.black), // Text color remains black
    );
  }

  Widget _buildDatePickerField(BuildContext context, String label, TextEditingController controller, {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
          filled: true,
          fillColor: Colors.grey[300], // Set grey color for the field
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Change the border color when focused
              width: 2.0,
            ),
          ),
        ),
        readOnly: readOnly,
        onTap: readOnly ? null : () => _selectDate(context, controller),
        style: TextStyle(color: Colors.black), // Text color remains black
      ),
    );
  }

  void _selectDate(BuildContext context, TextEditingController controller) async {
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

  List<String> _getDistricts() {
    return ['Dhaka', 'Chittagong', 'Rajshahi', 'Sylhet', 'Khulna', 'Barisal', 'Rangpur', 'Mymensingh'];
  }

  List<String> _getPoliceStations() {
    return ['Gulshan', 'Dhanmondi', 'Khilgaon', 'Mirpur', 'Kotwali', 'Tejgaon', 'Motijheel', 'Uttara'];
  }
}
