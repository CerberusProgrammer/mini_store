import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final bool mode;

  const Dashboard({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return mode ? editMode() : viewMode();
  }

  Widget viewMode() {
    return Scaffold(
      body: Text('view'),
    );
  }

  Widget editMode() {
    return Scaffold(
      body: Text('edit'),
    );
  }
}
