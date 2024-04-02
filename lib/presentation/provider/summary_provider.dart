import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/summary/consumption_summary_model.dart';
import 'package:nutriary_flutter/domain/usecases/calorie_summary.dart';

class SummaryProvider extends ChangeNotifier {
  var _summaryUsecase = CalorieSummaryUsecase();

  Future<CalorieSummary> getConsumptionSummaryToday(int UserId) async {
    try {
      var result = await _summaryUsecase.getCalorieSummaryToday(UserId);
      notifyListeners();
      return result;
    } catch (e) {
      notifyListeners();
      throw e;
    }
  }

  Future<CalorieSummary> getConsumptionSummaryByDate(int UserId, DateTime date) async {
    try {
      var result = await _summaryUsecase.getCalorieSummaryByDate(UserId, date);
      notifyListeners();
      return result;
    } catch (e) {
      notifyListeners();
      throw e;
    }
  }
}