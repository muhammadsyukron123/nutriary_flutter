import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../data/model/user/user.dart';
import '../provider/get_user_log_dates_provider.dart';
import '../widget/calorie_cummary_gridview_cards.dart';
import '../widget/log_date_time_picker.dart';

class DailyReportScreen extends StatelessWidget {
  const DailyReportScreen({super.key});



  @override
  Widget build(BuildContext context) {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserlogDatesProvider>(context, listen: false).fetchUserLogDates(user!.userId!);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
              LogDateTimePicker(user: user!),
            SizedBox(height: 20),
            CalorieSummaryGrid(),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: foodNutritionInfoList.length,
            //     itemBuilder: (context, index) {
            //       return FoodNutritionInfoCard(
            //         foodNutritionInfo: foodNutritionInfoList[index],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
