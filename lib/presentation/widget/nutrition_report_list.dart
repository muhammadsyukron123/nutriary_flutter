import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../data/model/nutrition/nutrition_report_model.dart';
import '../provider/food_nutrition_by_date_provider.dart';
import '../provider/summary_provider.dart';
import '../screens/add_food_log.dart';

class NutritionReportList extends StatelessWidget {
  final User user;
  NutritionReportList({required this.user});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<FoodNutritionReportByDateProvider>(context, listen: false)
          .getFoodNutritionReportByDate(user.userId!, DateTime.now());
    });
    return Consumer<FoodNutritionReportByDateProvider>(
      builder: (context, foodNutritionProvider, child) {
        var report = foodNutritionProvider.nutritionReport;
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Protein',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Text('${report?.totalProteinG} g'),
              ),
              ListTile(
                title: Text('Fat',style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${report?.totalFatG} g'),
              ),
              ListTile(
                title: Text('Carbs',style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${report?.totalCarbsG} g'),
              ),
              ListTile(
                title: Text('Fiber',style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${report?.totalFiberG} g'),
              ),
              ListTile(
                title: Text('Calcium',style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${report?.totalCalciumMg} mg'),
              ),
              ListTile(
                title: Text('Iron',style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${report?.totalFeMg} mg'),
              ),
              ListTile(
                title: Text('Natrium',style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text('${report?.totalNatriumMg} mg'),
              ),
            ],
          )
        );
      },
    );
  }
}