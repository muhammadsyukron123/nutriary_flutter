

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/model/foodlog/consumption_log_model.dart';
import '../../data/model/user/user.dart';
import '../../domain/usecases/consumption_log_usecase.dart';

class ConsumptionLogProvider extends ChangeNotifier {
  var _consumptionLogUseCase = ConsumptionLogUseCase();

  var _selectedDate = DateTime.now();
  List<ConsumptionLog> _data = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ConsumptionLog> get data => _data;
  DateTime get logDate => _selectedDate;

  Future<void> loadData() async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    _data.clear();
    _isLoading = true;
    var newData = await _consumptionLogUseCase.getConsumptionLogsByID(user!.userId!, DateTime.now() );
    if (newData.isNotEmpty) {
      _data.addAll(newData);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDataByDate(DateTime date) async {
    _data.clear();
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    _isLoading = true;
    var newData = await _consumptionLogUseCase.getConsumptionLogsByID(user!.userId!, date);
    print('newData: $newData');
    _isLoading = false;
    _data.addAll(newData);
    notifyListeners();
  }

  Future<void> refreshData() async {
    _data.clear();
    _isLoading = true;
    await loadData();
    _isLoading = false;
  }

  Future<void> refreshDataByDate(DateTime date) async {
    _data.clear();
    _isLoading = true;
    await loadDataByDate(date);
    _isLoading = false;
  }

  Future<void> clearData() async {
    _data.clear();
    notifyListeners();
  }

}

// class ConsumptionLogProvider extends ChangeNotifier{
//   var _consumptionLogUseCase = ConsumptionLogUseCase();
//   final PagingController<int, ConsumptionLog> pagingController = PagingController(firstPageKey: 0);
//
//   ConsumptionLogProvider(){
//     pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });
//   }
//
//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       var box = Hive.box<User>('userBox');
//       var user = box.get('user');
//       final newItems = await _consumptionLogUseCase.getConsumptionLogsByID(user!.userId!, DateTime.now());
//       final isLastPage = newItems.length < 10;
//       if (isLastPage) {
//         pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + newItems.length;
//         pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error) {
//       pagingController.error = error;
//     }
//   }
// }