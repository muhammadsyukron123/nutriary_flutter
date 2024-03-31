import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final box = Hive.box<User>('userBox');
    if (box.isNotEmpty ) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }


    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
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
                    FutureBuilder(
                      future: Provider.of<AuthProvider>(context, listen: false).login(
                        context,
                        _usernameController.text,
                        _passwordController.text,
                      ),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
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
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return Container(); // widget to return when future completes
                        }
                      },
                    );
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16))),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserRegisterScreen()),
                    );
                  },
                  child: Text('Register', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
