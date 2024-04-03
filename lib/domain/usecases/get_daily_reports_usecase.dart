import 'package:nutriary_flutter/data/repository/summary_repository.dart';

import '../../data/model/foodlog/daily_nutrition_log_model.dart';

class GetDailyReportsUseCase {
  var _summaryRepository = SummaryRepository();

  Future<List<DailyNutritionLog>> getDailyReports(int userId) async{
    try {
      var result = await _summaryRepository.getDailyReports(userId);
      return result;
    } catch (e) {
      throw e;
    }
  }
}