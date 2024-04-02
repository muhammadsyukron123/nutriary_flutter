import 'package:flutter/material.dart';
import 'package:nutriary_flutter/domain/usecases/update_food_log_quantity_usecase.dart';

class UpdateFoodLogProvider extends ChangeNotifier {
  var _foodLogUseCase = UpdateFoodLogQuantityUseCase();

  void updateFoodLog(int logId, double quantity) async {
    await _foodLogUseCase.execute(logId, quantity);
    notifyListeners();
  }
}