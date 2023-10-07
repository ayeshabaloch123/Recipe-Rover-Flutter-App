import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use a Future.delayed to simulate a delay
    Future.delayed(Duration(seconds: 1), () {
      // Navigate to the home screen after the delay
      Navigator.pushReplacementNamed(context, '/recipe');
    });

    return Scaffold(
      body: Container(
        // Set the background color to orange
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your splash screen content, such as logo or image
              Image.asset(
                'assets/logo.png', // Adjust the image path as needed
                height: 500,
                width: 500,
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
