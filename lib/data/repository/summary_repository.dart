import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/datasource/remote/consumption_summary_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/summary/user_log_date_model.dart';

import '../model/foodlog/daily_nutrition_log_model.dart';
import '../model/summary/consumption_summary_model.dart';
import '../model/summary/summary_today_hive_model.dart';

class SummaryRepository{
  var _summaryRemoteDataSource = ConsumptionSummaryRemoteDataSource();

  Future<CalorieSummary> getCalorieSummaryToday(int UserId) async{
    try {
      var result = await _summaryRemoteDataSource.getConsumptionSummaryToday(UserId);
      SummaryHiveModel summaryHiveModel = SummaryHiveModel(
        userId: result.userId,
        logDate: result.logDate,
        bmr: result.bmr,
        consumedCalories: result.consumedCalories,
        remainingCalories: result.remainingCalories,
      );
      var summaryBox = Hive.box<SummaryHiveModel>('summaryBox');
      summaryBox.put('summary', summaryHiveModel);
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<CalorieSummary> getCalorieSummaryByDate(int UserId, DateTime date) async{
    try {
      var result = await _summaryRemoteDataSource.getCalorieSummaryByDate(UserId, date);
      SummaryHiveModel summaryHiveModel = SummaryHiveModel(
        userId: result.userId,
        logDate: result.logDate,
        bmr: result.bmr,
        consumedCalories: result.consumedCalories,
        remainingCalories: result.remainingCalories,
      );
      var summaryBox = Hive.box<SummaryHiveModel>('summaryBox');
      summaryBox.put('summary', summaryHiveModel);
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DailyNutritionLog>> getDailyReports(int userId) async{
    try {
      var result = await _summaryRemoteDataSource.getDailyReports(userId);
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<UserLogDate>> getUserLogDates(int userId) async {
    try {
      var result = await _summaryRemoteDataSource.getUserLogDates(userId);
      return result;
    } catch (e) {
      throw e;
    }
  }
}