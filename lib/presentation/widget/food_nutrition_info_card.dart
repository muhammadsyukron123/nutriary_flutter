import 'package:flutter/material.dart';

import '../../data/model/food_nutrition_info_model.dart';

class FoodNutritionInfoCard extends StatelessWidget {
  final FoodNutritionInfo foodNutritionInfo;

  FoodNutritionInfoCard({required this.foodNutritionInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => FoodNutritionDetailScreen(),
        //   ),
        // );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(foodNutritionInfo.foodName),
                subtitle: Text('Energy: ${foodNutritionInfo.energyKal} kCal')
              )
            ],
          ),
        ),
      ),
    );
  }
}
