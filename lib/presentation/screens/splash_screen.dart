import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:nutriary_flutter/presentation/screens/dashboard_screen.dart';
import 'package:nutriary_flutter/presentation/screens/login_screen.dart';

import '../../data/model/user/user.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      body: Center( // Add this
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // And this
          children: [
            Container(
              height: 200,
              child: Center(
                child: Text('Nutriary',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              height: 300,
              child: Center(
                child: Lottie.asset('assets/lottie/splash_animation.json'),
              ),
            ),
            Container(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}


