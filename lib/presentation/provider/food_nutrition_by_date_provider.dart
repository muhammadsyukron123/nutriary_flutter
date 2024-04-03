import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutriary_flutter/data/model/nutrition/nutrition_report_model.dart';
import 'package:nutriary_flutter/domain/usecases/get_food_nutrition_report_by_date_usecase.dart';

class FoodNutritionReportByDateProvider extends ChangeNotifier {
  var _getFoodNutritionUseCase = getFoodNutritionReportByDateUsecase();

  NutritionReport? _nutritionReport;
  NutritionReport? get nutritionReport => _nutritionReport;


  Future<NutritionReport> getFoodNutritionReportByDate(int userId, DateTime date) async {
    try {
      _nutritionReport = await _getFoodNutritionUseCase.getFoodNutritionReportByDate(userId, date);
      notifyListeners();
      return _nutritionReport!;
    } catch (e) {
      throw e;
    }
  }

  void refreshNutritionReport() {
    notifyListeners();
  }

  void clearNutritionReport() {
    _nutritionReport = null;
    notifyListeners();
  }
}