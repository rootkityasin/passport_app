import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pms_flutter_app/admin/admin_dashboard.dart';
import 'package:pms_flutter_app/police/police_dashboard.dart';
import 'package:pms_flutter_app/users/user.dart';
import 'package:http/http.dart' as http;
import 'package:pms_flutter_app/users/user_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pms_flutter_app/config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _policeIdController = TextEditingController();
  final TextEditingController _adminIdController = TextEditingController();
  User user = User('', '');
  bool rememberMe = false;
  bool _passwordVisible = false;
  String _selectedRole = 'User';
  late SharedPreferences prefs;

  Future loginUser() async {
    if (_formKey.currentState!.validate()) {
      final user = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        final mytoken = jsonResponse['token'];
        prefs.setString('token', mytoken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDashboard(token: mytoken)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'] ?? 'Login failed')),
        );
      }
    }
  }

  Future loginAdmin() async {
    if (_formKey.currentState!.validate()) {
      final admin = {
        "aid": _adminIdController.text,
        "password": _passwordController.text,
      };

      var response = await http.post(Uri.parse(adminlogin),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(admin));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        final mytoken = jsonResponse['token'];
        prefs.setString('token', mytoken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminDashboard(token: mytoken)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'] ?? 'Login failed')),
       );
      }
    }
  }

  Future loginPolice() async {
    if (_formKey.currentState!.validate()) {
      final police = {
        "pid": _policeIdController.text,
        "password": _passwordController.text,
      };

      var response = await http.post(Uri.parse(policelogin),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(police));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        final mytoken = jsonResponse['token'];
        prefs.setString('token', mytoken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PoliceDashboard(token: mytoken)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'] ?? 'Login failed')),
       );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget _roleIcon(String role, String assetPath) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRole = role;
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: AssetImage('images/immigration.png'),
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Sign in to your Account',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Choose Role',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _roleIcon('User', 'images/user_icon.png'),
                        _roleIcon('Admin', 'images/admin_icon.png'),
                        _roleIcon('Police Officer', 'images/police_icon.png'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (_selectedRole == 'User') ...[
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (_selectedRole == 'Admin') ...[
                      TextFormField(
                        controller: _adminIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Unique Id';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Admin ID',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (_selectedRole == 'Police Officer') ...[
                      TextFormField(
                        controller: _policeIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Unique Id';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Police ID',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    TextFormField(
                      obscureText: !_passwordVisible,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
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
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            const Text(
                              'Remember Me?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_selectedRole == 'User') ...[
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: loginUser,
                          // Handle the login logic based on the role and provided information
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Log In',
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
                          onPressed: loginAdmin,
                          // Handle the login logic based on the role and provided information
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Log In',
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
                          onPressed: loginPolice,
                          // Handle the login logic based on the role and provided information
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Or'),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage('images/google.png'),
                          height: 20,
                          width: 20,
                        ),
                        label: const Text('Continue with Google'),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage('images/fb.png'),
                          height: 20,
                          width: 20,
                        ),
                        label: const Text('Continue with Facebook'),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
