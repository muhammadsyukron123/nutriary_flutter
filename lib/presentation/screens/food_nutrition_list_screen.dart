import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/model/nutrition/food_nutrition_info_model.dart';
import '../provider/food_nutrition_provider.dart';
import '../widget/food_nutrition_info_card.dart';

import 'package:provider/provider.dart';


import 'package:flutter/material.dart';
import '../provider/food_nutrition_provider.dart';
import '../widget/food_nutrition_info_card.dart';

import 'package:provider/provider.dart';

class FoodNutritionInfoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllFoodNutritionProvider>(context, listen: false).loadData();
    });

    return Consumer<GetAllFoodNutritionProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await Provider.of<GetAllFoodNutritionProvider>(context, listen: false).refreshData();
          },
          child: ListView.builder(
            itemCount: provider.data.length,
            itemBuilder: (context, index) {
              final foodNutritionInfo = provider.data[index];
              return FoodNutritionInfoCard(foodNutritionInfo: foodNutritionInfo);
            },
          ),
        );
      },
    );
  }
}





// class FoodNutritionInfoList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () => Future.sync(
//             () => Provider.of<GetAllFoodNutritionProvider>(context, listen: false).pagingController.refresh(),
//       ),
//       child: PagedListView<int, FoodNutritionInfo>(
//         pagingController: Provider.of<GetAllFoodNutritionProvider>(context, listen: false).pagingController,
//         builderDelegate: PagedChildBuilderDelegate<FoodNutritionInfo>(
//           itemBuilder: (context, foodNutritionInfo, index) => FoodNutritionInfoCard(foodNutritionInfo: foodNutritionInfo),
//         ),
//       ),
//     );
//   }
// }