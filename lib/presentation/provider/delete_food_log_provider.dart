import 'package:flutter/foundation.dart';

import '../../domain/usecases/delete_food_log_usecase.dart';

class DeleteFoodLogProvider extends ChangeNotifier {
  var _deleteFoodLogUseCase = DeleteFoodLogUseCase();

  void deleteFoodLog(int foodLogId) async {
    await _deleteFoodLogUseCase.execute(foodLogId);
    notifyListeners();
  }
}