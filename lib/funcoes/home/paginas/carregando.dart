import 'package:flutter/material.dart';

class HomeCarregando extends StatelessWidget {
  const HomeCarregando({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
