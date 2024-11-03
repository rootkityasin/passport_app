import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pms_flutter_app/config.dart';
import 'package:pms_flutter_app/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _policeIdController = TextEditingController();
  final TextEditingController _adminIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'User';
  String _selectedCountryCode = '+880';
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.year}/${picked.month}/${picked.day}";
      });
    }
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final user = {
        "fname": _fnameController.text,
        "lname": _lnameController.text,
        "email": _emailController.text,
        "dob": _dobController.text,
        "phone": int.parse(_phoneController.text),
        "nid": _nidController.text,
        "password": _passwordController.text,
      };


      try {
        final response = await http.post(
          Uri.parse(registration),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user),
        );

        if (!mounted) return;

        if (response.statusCode == 200) {
          _showSnackBar('Registered Successfully');
          _navigateToLogin();
        } else {
          _showSnackBar('Registration Failed: ${response.statusCode}');
        }
      } catch (e) {
        _showSnackBar('An error occurred: $e');
      }
    }
  }

  Future<void> _registerAdmin() async {
    if (_formKey.currentState!.validate()) {
      final admin = {
        "fname": _fnameController.text,
        "lname": _lnameController.text,
        "email": _emailController.text,
        "dob": _dobController.text,
        "phone": int.parse(_phoneController.text),
        "aid": _adminIdController.text,
        "password": _passwordController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(adminregistration),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(admin),
        );

        if (!mounted) return;

        if (response.statusCode == 200) {
          _showSnackBar('Registered Successfully');
          _navigateToLogin();
        } else {
          _showSnackBar('Registration Failed: ${response.statusCode}');
        }
      } catch (e) {
        _showSnackBar('An error occurred: $e');
      }
    }
  }

  Future<void> _registerPolice() async {
    if (_formKey.currentState!.validate()) {
      final police = {
        "fname": _fnameController.text,
        "lname": _lnameController.text,
        "email": _emailController.text,
        "dob": _dobController.text,
        "phone": int.parse(_phoneController.text),
        "pid": _policeIdController.text,
        "password": _passwordController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(policeregistration),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(police),
        );

        if (!mounted) return;

        if (response.statusCode == 200) {
          _showSnackBar('Registered Successfully');
          _navigateToLogin();
        } else {
          _showSnackBar('Registration Failed: ${response.statusCode}');
        }
      } catch (e) {
        _showSnackBar('An error occurred: $e');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Widget _roleIcon(String role, String assetPath) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {});
      },
      onExit: (_) {
        setState(() {});
      },
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedRole = role;
                print("Selected role: $_selectedRole"); // Debugging output

          });
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedRole == role ? Colors.blue : Colors.grey,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                assetPath,
                height: 50,
                width: 50,
              ),
            ),
            Text(
              role,
              style: TextStyle(
                color: _selectedRole == role ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: const Color.fromARGB(185, 192, 202, 191),
        foregroundColor: const Color.fromARGB(185, 192, 202, 191),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(185, 192, 202, 191),
              Color.fromARGB(185, 192, 202, 191),
            ],
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Choose Role',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _roleIcon('User', 'images/user_icon.png'),
                        _roleIcon('Admin', 'images/admin_icon.png'),
                        _roleIcon('Police Officer', 'images/police_icon.png'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _fnameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lnameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: const OutlineInputBorder(),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountryCode,
                              items: <String>['+880'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCountryCode = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            // keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_selectedRole == 'User') ...[
                      TextFormField(
                        controller: _nidController,
                        decoration: const InputDecoration(
                          labelText: 'NID/Birth Certificate Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your NID/Birth Certificate Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (_selectedRole == 'Admin') ...[
                      TextField(
                        controller: _adminIdController,
                        decoration: const InputDecoration(
                          labelText: 'Admin ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (_selectedRole == 'Police Officer') ...[
                      TextField(
                        controller: _policeIdController,
                        decoration: const InputDecoration(
                          labelText: 'Police ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    if (_selectedRole == 'User') ...[
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (_selectedRole == 'Admin') ...[
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _registerAdmin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (_selectedRole == 'Police Officer') ...[
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _registerPolice,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
