import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Your Status'),
      ),
      body: const Center(
        child: Text('This is the Status Page'),
      ),
    );
  }
}
