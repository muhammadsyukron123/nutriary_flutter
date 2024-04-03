import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/summary/consumption_summary_model.dart';
import 'package:nutriary_flutter/domain/usecases/calorie_summary.dart';

class SummaryProvider extends ChangeNotifier {
  var _summaryUsecase = CalorieSummaryUsecase();

  CalorieSummary? _calorieSummary;
  CalorieSummary? get calorieSummary => _calorieSummary;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

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

  Future<void> getConsumptionSummaryByDate(int UserId, DateTime date) async {
    try {
      var result = await _summaryUsecase.getCalorieSummaryByDate(UserId, date);
      _calorieSummary = result;
      notifyListeners();
    } catch (e) {
      notifyListeners();
      throw e;
    }
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void refreshCalorieSummary() {
    notifyListeners();
  }

  void clearCalorieSummary() {
    _calorieSummary = null;
    notifyListeners();
  }

  void clearAll() {
    clearCalorieSummary();
  }


}