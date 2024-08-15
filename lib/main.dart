import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'user_dashboard.dart';
import 'apply.dart';
import 'reissue.dart';
import 'missing.dart';
import 'status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(), 
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/user_dashboard': (context) => const UserDashboard(token: 'test_token'), // Static token for testing
        '/apply': (context) => const ApplyPage(),
        '/reissue': (context) => const ReissuePage(),
        '/missing': (context) => const MissingLostPage(),
        '/status': (context) => const StatusPage(),
      },
    );
  }
}