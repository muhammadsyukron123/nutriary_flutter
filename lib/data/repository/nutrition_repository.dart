import 'package:nutriary_flutter/data/datasource/remote/nutrition_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/nutrition/nutrition_report_model.dart';

import '../model/nutrition/food_nutrition_info_model.dart';

class NutritionRepository {
  var remoteDataSource = NutritionRemoteDataSource();

  Future<List<FoodNutritionInfo>> getAllFoodNutrition() async {
    try {
      final List<FoodNutritionInfo> foodNutritionList =
          await remoteDataSource.getAllFoodNutrition();
      return foodNutritionList;
    } catch (e) {
      throw e;
    }
  }

  Future<NutritionReport> getFoodNutritionReportByDate(int userId, DateTime date) async {
    try {
      final NutritionReport nutritionReport =
          await remoteDataSource.getFoodNutritionReportByDate(userId, date);
      return nutritionReport;
    } catch (e) {
      throw e;
    }
  }
}
