import 'package:nutriary_flutter/data/model/nutrition/nutrition_report_model.dart';

import '../../data/model/nutrition/food_nutrition_info_model.dart';
import '../../data/repository/nutrition_repository.dart';

class getFoodNutritionReportByDateUsecase {
  var _nutritionRepository = NutritionRepository();
  
  Future<NutritionReport> getFoodNutritionReportByDate(int userId, DateTime date) async {
    try {
      final NutritionReport nutritionReport =
          await _nutritionRepository.getFoodNutritionReportByDate(userId, date);
      return nutritionReport;
    } catch (e) {
      throw e;
    }
  }
}