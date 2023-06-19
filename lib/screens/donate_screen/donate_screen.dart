import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              child: Image.asset('res'),
            ),
          ],
        ),
      ),
    );
  }
}
