import '../../data/model/summary/consumption_summary_model.dart';
import '../../data/repository/summary_repository.dart';

class ConsumptionSummaryUsecase{
  var _consumptionSummaryRepository = SummaryRepository();

  Future<ConsumptionSummary> getConsumptionSummaryToday(int UserId) async{
    try {
      return _consumptionSummaryRepository.getConsumptionSummaryToday(UserId);
    } catch (e) {
      throw e;
    }
  }

  Future<ConsumptionSummary> getConsumptionSummaryByDate(int UserId, DateTime date) async{
    try {
      return _consumptionSummaryRepository.getConsumptionSummaryByDate(UserId, date);
    } catch (e) {
      throw e;
    }
  }
}