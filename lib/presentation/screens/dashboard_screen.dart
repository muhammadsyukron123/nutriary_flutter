import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/model/summary/summary_today_hive_model.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';
import 'package:nutriary_flutter/presentation/provider/summary_provider.dart';
import 'package:provider/provider.dart';

import '../../data/model/summary/consumption_summary_model.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('userBox');
    final summaryBox = Hive.box<SummaryHiveModel>('summaryBox');
    if (userBox.isEmpty && summaryBox.isEmpty) {
      Get.off(() => LoginScreen());
    }
    final User? user = userBox.getAt(0);

    final summaryProvider = Provider.of<SummaryProvider>(context)
        .getConsumptionSummaryToday(user!.userId!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nutriary', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text('Welcome to Nutriary 🍀',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
              '${user?.firstName} ${user?.lastName}',
              style: TextStyle(fontSize: 20)
            ),
            SizedBox(height: 20),
            Consumer<SummaryProvider>(
                builder: (context, summaryProvider, child) {
              Provider.of<SummaryProvider>(context)
                  .getConsumptionSummaryToday(user.userId!);
              var summary = summaryBox.getAt(0);
              if (summary == null) {
                return Center(child: CircularProgressIndicator());
              }
              else{
                return GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 100,
                      child: Card(
                        child: ListTile(
                          title: Text('Today\'s \nIntake 🍽',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                          subtitle: Text('${summary?.consumedCalories} kcal', style: TextStyle(fontSize: 16),),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Card(
                        child: ListTile(
                          title: Text('Remaining \nCalorie 🔥',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                          subtitle: Text('${summary?.remainingCalories} kcal', style: TextStyle(fontSize: 16)),

                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Card(
                        child: ListTile(
                          title: Text('Calorie \nLimit 🏋️‍♂️',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                          subtitle: Text('${summary?.bmr} kcal', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),

            // Row(
            //   children: [
            //     Expanded(
            //       child: Card(
            //         child: ListTile(
            //           title: Text('Your Calorie Consumption 🍽'),
            //           subtitle: Text('${} kcal'), //tampilkan data disini
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Card(
            //         child: ListTile(
            //           title: Text('Remaining Calorie 🔥'),
            //           subtitle: Text('remainingCalories kcal'), // tampilkan data disini
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //         child: Card(
            //           child: ListTile(
            //             title: Text('Calorie Limit 🏋️‍♂️'), // tampilkan data disini
            //             subtitle: Text('bmr kcal'),
            //           ),
            //         )
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
