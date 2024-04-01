import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/datasource/remote/consumption_summary_remote_datasource.dart';

import '../model/summary/consumption_summary_model.dart';
import '../model/summary/summary_today_hive_model.dart';

class SummaryRepository{
  var _summaryRemoteDataSource = ConsumptionSummaryRemoteDataSource();

  Future<ConsumptionSummary> getConsumptionSummaryToday(int UserId) async{
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
      return _summaryRemoteDataSource.getConsumptionSummaryToday(UserId);
    } catch (e) {
      throw e;
    }
  }

  Future<ConsumptionSummary> getConsumptionSummaryByDate(int UserId, DateTime date) async{
    try {
      return _summaryRemoteDataSource.getConsumptionSummaryByDate(UserId, date);
    } catch (e) {
      throw e;
    }
  }
}