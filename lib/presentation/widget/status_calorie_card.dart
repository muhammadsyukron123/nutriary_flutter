import 'package:flutter/material.dart';

import '../../data/model/summary/summary_today_hive_model.dart';

class StatusCalorieCard extends StatelessWidget {
  final SummaryHiveModel summary;

  StatusCalorieCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: summary.consumedCalories < summary.bmr
          ? Colors.green
          : Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: summary.consumedCalories < summary.bmr
              ? Text(
            '😄',
            style: TextStyle(fontSize: 45),
          )
              : Text(
            '😱',
            style: TextStyle(fontSize: 45),
          ),
          title: summary.consumedCalories < summary.bmr
              ? Text(
            'Good job! You are still under the daily calorie limit',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
              : Text(
            'You are surpassing the daily calorie limit !',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            summary.consumedCalories < summary.bmr
                ? 'You still have enough space to eat, keep it up!'
                : 'You need to stop eating now!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
