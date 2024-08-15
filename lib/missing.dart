import 'package:flutter/material.dart';

class MissingLostPage extends StatelessWidget {
  const MissingLostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Lost or Stolen'),
      ),
      body: const Center(
        child: Text('This is the Missing/Lost Page'),
      ),
    );
  }
}
