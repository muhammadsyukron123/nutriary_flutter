

import 'package:nutriary_flutter/data/repository/consumption_log_repository.dart';

import '../../data/model/foodlog/consumption_log_model.dart';

class ConsumptionLogUseCase{
  var foodLogRepository = ConsumptionLogRepository();

  Future<List<ConsumptionLog>> getConsumptionLogsByID(int id, DateTime logDate) async {
    return foodLogRepository.getConsumptionLogsByID(id, logDate);
  }
}