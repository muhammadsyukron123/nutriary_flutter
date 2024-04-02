import 'package:nutriary_flutter/data/repository/consumption_log_repository.dart';

class UpdateFoodLogQuantityUseCase {
  var _foodLogRepository = ConsumptionLogRepository();

  Future<void> execute(int logId, double quantity) async {
    return _foodLogRepository.updateConsumptionLog(logId, quantity);
  }
}