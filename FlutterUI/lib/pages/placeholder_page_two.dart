import 'package:flutter/material.dart';

class PlaceholderPageTwo extends StatelessWidget {
  const PlaceholderPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 56.0, bottom: 20.0),
        child: Center(
          child: Text(
            'Page Three',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
