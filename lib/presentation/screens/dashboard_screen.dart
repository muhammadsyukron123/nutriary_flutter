import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nutriary_flutter/data/model/summary/summary_today_hive_model.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';
import 'package:nutriary_flutter/presentation/provider/summary_provider.dart';
import 'package:nutriary_flutter/presentation/screens/create_profile_screen.dart';
import 'package:nutriary_flutter/presentation/widget/status_calorie_card.dart';
import 'package:provider/provider.dart';

import '../../data/model/summary/consumption_summary_model.dart';
import '../provider/consumption_log_provider.dart';
import '../widget/food_log_detail_card.dart';
import '../widget/nutrition_report_list.dart';
import 'add_food_log.dart';
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
    final user = userBox.get('user');
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SummaryProvider>(context, listen: false)
          .getConsumptionSummaryByDate(user!.userId!, DateTime.now());
    });

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/letter-n.svg',
            height: 50, width: 50),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text('Welcome to Nutriary 🍀',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${user?.firstName} ${user?.lastName}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Consumer<SummaryProvider>(
                builder: (context, summaryProvider, child) {
              var summary = summaryBox.get('summary');
              if (summary == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('You have not set your profile yet, set it now!',
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () {
                          Get.off(CreateProfileScreen());
                        },
                        child: Text('Profile',
                            style: TextStyle(color: Colors.blue, fontSize: 20)),
                      ),
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<SummaryProvider>(context)
                        .getConsumptionSummaryByDate(
                            user!.userId!, DateTime.now());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StatusCalorieCard(summary: summary),
                      SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            child: Card(
                              color: Colors.indigo,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total\nCalorie 🍽',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text('${summary?.consumedCalories} kcal',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              color: Colors.indigo,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Remaining\nCalorie 🔥',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
                                  Text('${summary?.remainingCalories} kcal',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              color: Colors.indigo,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Calorie\nLimit 🏋️‍♂️',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center),
                                    Text('${summary?.bmr} kcal',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                          title: Text('Nutrition Report',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now())}')),
                      Container(
                        child: summary.consumedCalories == 0
                            ? Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("You haven't consumed any food yet today",
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 16),
                                  //text button add food log
                                  TextButton(
                                    onPressed: () {
                                      Get.to(AddFoodLog());
                                    },
                                    child: Text('Add Food Log',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  )
                                ]),
                              ),
                            )
                            : NutritionReportList(user: user!),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
