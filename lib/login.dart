import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  bool _passwordVisible = false;
  String _selectedRole = 'User';

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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
                  'Sign in to your             Account',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose Role',
                  style: TextStyle(fontSize: 20,
                   color: Color.fromARGB(186, 24, 140, 185),
                   fontWeight: FontWeight.bold,
                  ),
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
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the login logic based on the role and provided information
                    },
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
        ),
      ),
    );
  }
}
