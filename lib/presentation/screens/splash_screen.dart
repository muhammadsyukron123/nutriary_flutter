import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
      Get.off(() => LoginScreen());
    });

    return Scaffold(
      body: Center(
        // Add this
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // And this
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Center(
                  child: Text('Nutriary',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
