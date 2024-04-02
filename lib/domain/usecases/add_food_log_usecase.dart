import '../../data/model/foodlog/add_consumption_log_model.dart';
import '../../data/repository/consumption_log_repository.dart';

class AddFoodLogUsecase{
  var _consumptionLogRepository = ConsumptionLogRepository();

  Future<AddConsumptionLog> addConsumptionLog(AddConsumptionLog consumptionLog) async {
    return _consumptionLogRepository.addConsumptionLog(consumptionLog);
  }
}