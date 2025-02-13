import 'package:flutter/material.dart';

class RepoCrawl extends StatelessWidget {
  const RepoCrawl({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 56.0, bottom: 20.0), // Updated padding
        child: Center(
          child: Text(
            'RepoCrawl Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
