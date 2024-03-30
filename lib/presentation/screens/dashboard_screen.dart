import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';

import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<User>('userBox');
    if (box.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
    final User? user = box.getAt(0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        box.clear();
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        });
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text('No'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        title: Text('Nutriary', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              child: Text('Welcome to Nutriary, ${user?.firstName} ${user?.lastName}',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}