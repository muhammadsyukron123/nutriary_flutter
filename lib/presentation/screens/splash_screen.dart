import 'dart:async';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
      );
    });
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            child: Center(
              child: Text('Nutriary',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            height: 200,
            child: Center(
              child: Lottie.asset('assets/lottie/nutrition_lottie.json'),
            ),
          ),
          Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
              ),
            ),
          )
        ],
      ),
    );
  }
}



