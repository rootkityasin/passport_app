import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pms_flutter_app/users/setting.dart';
import 'login.dart';
import 'signup.dart';
import 'users/user_dashboard.dart';
import 'users/apply.dart';
import 'users/reissue.dart';
import 'users/missing.dart';
import 'users/status.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    'asset://assets/logo.png',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'User Notifications',
        channelDescription: 'Notifications for general users',
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: 'admin_channel',
        channelName: 'Admin Notifications',
        channelDescription: 'Notifications for admins',
        defaultColor: Colors.red,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: 'police_channel',
        channelName: 'Police Notifications',
        channelDescription: 'Notifications for police officers',
        defaultColor: Colors.green,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      ),
    ],
  );
  //
  // AwesomeNotifications().actionStream.listen((receivedNotification) {
  //   if (receivedNotification.buttonKeyPressed == 'REPLY') {
  //     // Handle reply action
  //     print('User pressed reply');
  //   } else if (receivedNotification.buttonKeyPressed == 'MARK_READ') {
  //     // Handle mark as read action
  //     print('User marked as read');
  //   }
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color to blue
      ),
      home: const LoginPage(),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/user_dashboard': (context) => const UserDashboard(
            token: 'test_token'), // Static token for testing
        '/apply': (context) => const ApplyPage(),
        '/reissue': (context) => const ReissuePage(),
        '/missing': (context) => const MissingLostPage(),
        '/status': (context) => const StatusPage(token: 'test_token'),
        '/setting': (context) => const SettingsPage(token: 'test_token'),
      },
    );
  }
}
