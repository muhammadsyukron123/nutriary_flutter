import 'package:nutriary_flutter/data/repository/consumption_log_repository.dart';

class DeleteFoodLogUseCase {
  var _foodLogRepository = ConsumptionLogRepository();

  Future<void> execute(int foodLogId) async {
    return _foodLogRepository.deleteConsumptionLog(foodLogId);
  }
}