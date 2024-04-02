import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/foodlog/add_consumption_log_model.dart';

import '../../domain/usecases/add_food_log_usecase.dart';

class AddFoodLogProvider extends ChangeNotifier{
  var _addFoodLogUsecase = AddFoodLogUsecase();

  Future<void> addConsumptionLogToday(String foodId, double quantity) async {
    AddConsumptionLog addConsumptionLog = AddConsumptionLog(
        foodId: foodId,
        quantity: quantity,
        logDate: DateTime.now()
    );
    await _addFoodLogUsecase.addConsumptionLog(addConsumptionLog);
    notifyListeners();
  }
}