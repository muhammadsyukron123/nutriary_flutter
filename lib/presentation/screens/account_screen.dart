import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/presentation/provider/consumption_log_provider.dart';
import 'package:provider/provider.dart';

import '../../data/model/summary/summary_today_hive_model.dart';
import '../../data/model/user/user.dart';
import '../provider/bottom_navbar_provider.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('userBox');
    final summaryBox = Hive.box<SummaryHiveModel>('summaryBox');
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Account'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                //snack bar
                Get.snackbar('Account', 'Under development');
              },
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.manage_accounts),
              onTap: () {
                //snack bar
                Get.snackbar('Profile', 'Under development');
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            WidgetsBinding.instance!.addPostFrameCallback((_) async {
                              await userBox.clear();
                              await summaryBox.clear();
                              Provider.of<BottomNavigationProvider>(context, listen: false).resetIndex();
                              Provider.of<ConsumptionLogProvider>(context, listen: false).clearData();
                              Get.offAll(LoginScreen());
                            });

                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
