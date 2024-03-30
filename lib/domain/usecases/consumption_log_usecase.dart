import 'dart:ffi';

import 'package:nutriary_flutter/data/repository/consumption_log_repository.dart';
import 'package:nutriary_flutter/domain/entities/consumption_log_entity.dart';

import '../../data/model/foodlog/consumption_log_model.dart';

class ConsumptionLogUsecase{
  var repository = ConsumptionLogRepository();

  Future<List<ConsumptionLog>> getConsumptionLogsByID(Int id, DateTime logDate) async {
    try {
      final List<ConsumptionLog> consumptionLogList = await repository.getConsumptionLogsByID(id, logDate);
      return consumptionLogList;
    } catch (e) {
      throw e;
    }
  }

  ConsumptionLogEntity mapToEntity(ConsumptionLog consumptionLog){
    return ConsumptionLogEntity(
      logId: consumptionLog.logId,
      logDate: consumptionLog.logDate,
      quantity: consumptionLog.quantity,
      foodId: consumptionLog.foodId,
      foodName: consumptionLog.foodName,
      energyKal: consumptionLog.energyKal,
      proteinG: consumptionLog.proteinG,
      fatG: consumptionLog.fatG,
      carbsG: consumptionLog.carbsG,
      fiberG: consumptionLog.fiberG,
      calciumMg: consumptionLog.calciumMg,
      feMg: consumptionLog.feMg,
      natriumMg: consumptionLog.natriumMg
    );
  }
}