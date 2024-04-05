import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:nutriary_flutter/presentation/screens/user_register_screen.dart';
import 'package:provider/provider.dart';

import '../../data/model/user/user.dart';
import '../provider/auth_provider.dart';
import 'dashboard_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    final userBox = Hive.box<User>('userBox');
    if (userBox.isNotEmpty ) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Get.off(() => HomeScreen());
      });
    }

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    if(Provider.of<AuthProvider>(context, listen: false).isLoading){
      return Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/nutrition_lottie.json',
                    height: 400, width: 400),
                Text('Welcome to Nutriary 👋',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold) ),
                Text('You should login first',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FutureBuilder(
                            future: Provider.of<AuthProvider>(context, listen: false).login(
                              context,
                              _usernameController.text,
                              _passwordController.text,
                            ),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                isLoading = true;
                                return Stack(
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.3,
                                      child: const ModalBarrier(dismissible: false, color: Colors.grey),
                                    ),
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ],
                                );
                              } else {
                                if (snapshot.hasError) {
                                  isLoading = false;
                                  return Text('Error: ${snapshot.error}');
                                }
                                else
                                  return Container(); // widget to return when future completes
                              }
                            },
                          );
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      child:  Text('Login', style: TextStyle(color: Colors.white, fontSize: 16))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.to(() => UserRegisterScreen());
                      },
                      child: Text('Register', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
