import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/summary/consumption_summary_model.dart';
import 'package:nutriary_flutter/domain/usecases/consumption_summary.dart';

class SummaryProvider extends ChangeNotifier {
  var _summaryUsecase = ConsumptionSummaryUsecase();

  Future<ConsumptionSummary> getConsumptionSummaryToday(int UserId) async {
    try {
      var result = await _summaryUsecase.getConsumptionSummaryToday(UserId);
      notifyListeners();
      return result;
    } catch (e) {
      notifyListeners();
      throw e;
    }
  }

  Future<ConsumptionSummary> getConsumptionSummaryByDate(int UserId, DateTime date) async {
    try {
      var result = await _summaryUsecase.getConsumptionSummaryByDate(UserId, date);
      notifyListeners();
      return result;
    } catch (e) {
      notifyListeners();
      throw e;
    }
  }
}