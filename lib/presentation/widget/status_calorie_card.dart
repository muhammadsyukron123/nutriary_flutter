import 'package:flutter/material.dart';

import '../../data/model/summary/summary_today_hive_model.dart';


class StatusCalorieCard extends StatelessWidget {
  final SummaryHiveModel summary;

  StatusCalorieCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: summary.consumedCalories < summary.bmr ? Colors.green : Colors.red,
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            summary.consumedCalories < summary.bmr
                ? 'You still have enough space to eat'
                : 'You are surpassing the daily calorie limit, be careful',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}