import 'package:flutter/material.dart';

class ReissuePage extends StatelessWidget {
  const ReissuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reissue or Renew'),
      ),
      body: Center(
        child: const Text('This is the Reissue Page'),
      ),
    );
  }
}
