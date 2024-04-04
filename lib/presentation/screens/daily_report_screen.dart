import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/model/user/user.dart';
import '../provider/get_user_log_dates_provider.dart';
import '../widget/calorie_cummary_gridview_cards.dart';
import '../widget/food_log_list_card.dart';
import '../widget/log_date_time_picker.dart';

class DailyReportScreen extends StatelessWidget {
  const DailyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserlogDatesProvider>(context, listen: false)
          .setSelectedDate(DateTime.now()); // Set the selected date to today's date
      Provider.of<GetUserlogDatesProvider>(context, listen: false)
          .fetchUserLogDates(user!.userId!);
    });

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/letter-n.svg',
            height: 50, width: 50),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<GetUserlogDatesProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily Nutrition Report 📅🥦',
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.start),
                    Text(
                      'Report of food you have consumed on',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      DateFormat('EEEE, dd MMMM y').format(provider.selectedDate),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            LogDateTimePicker(user: user!),
            SizedBox(height: 20),
            CalorieSummaryGrid(),
            SizedBox(height: 20),
            ListTile(
                title: Text('Food Log 🍽',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(
                    'This is the list of foods you have consumed')),
            FoodLogList(),
          ],
        ),
      ),
    );
  }
}