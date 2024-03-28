import 'package:flutter/material.dart';

import '../../domain/usecases/get_all_food_nutrition_info.dart';
import '../widget/food_nutrition_info_card.dart';

// ignore: must_be_immutable
class FoodNutritionInfoList extends StatelessWidget {
  var getAllFoodNutritionInfo = GetAllFoodNutritionInfo();

  FoodNutritionInfoList({super.key, required this.getAllFoodNutritionInfo});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await getAllFoodNutritionInfo.execute();
        },
        child: FutureBuilder(
          future: getAllFoodNutritionInfo.execute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                    'Error: ${snapshot.error} connectionState: ${snapshot.connectionState}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final foodNutritionInfo = snapshot.data![index];
                  return FoodNutritionInfoCard(
                      foodNutritionInfo: foodNutritionInfo);
                },
              );
            }
          },
        ));
  }
}
