import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/model/nutrition/food_nutrition_info_model.dart';
import '../../domain/usecases/get_all_food_nutrition_info.dart';

// class GetAllFoodNutritionProvider extends ChangeNotifier {
//   var _getAllFoodNutritionInfo = GetAllFoodNutritionInfo();
//   List<FoodNutritionInfo> _data = [];
//
//   List<FoodNutritionInfo> get data => _data;
//
//   Future<void> loadData() async {
//     var newData = await _getAllFoodNutritionInfo.execute();
//     if (newData.isNotEmpty) {
//       _data.addAll(newData);
//       notifyListeners();
//     }
//   }
//
//   Future<void> refreshData() async {
//     _data.clear();
//     await loadData();
//   }
// }



class GetAllFoodNutritionProvider extends ChangeNotifier {
  var _getAllFoodNutritionInfo = GetAllFoodNutritionInfo();
  final PagingController<int, FoodNutritionInfo> pagingController = PagingController(firstPageKey: 0);

  GetAllFoodNutritionProvider() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getAllFoodNutritionInfo.execute();
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}