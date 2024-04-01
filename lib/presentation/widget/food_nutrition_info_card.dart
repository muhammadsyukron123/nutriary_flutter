import 'package:flutter/material.dart';

import '../../data/model/nutrition/food_nutrition_info_model.dart';

class FoodNutritionInfoCard extends StatelessWidget {
  final FoodNutritionInfo foodNutritionInfo;

  FoodNutritionInfoCard({required this.foodNutritionInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(foodNutritionInfo.foodName, style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('Energy: ${foodNutritionInfo.energyKal} kCal'),
              expandedAlignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Protein: ${foodNutritionInfo.proteinG} g'),
                      Text('Fat: ${foodNutritionInfo.fatG} g'),
                      Text('Carbohydrate: ${foodNutritionInfo.carbsG} g'),
                      Text('Fiber: ${foodNutritionInfo.fiberG} g'),
                      Text('Iron: ${foodNutritionInfo.feMg} mg'),
                      Text('Calcium: ${foodNutritionInfo.calciumMg} mg'),
                      Text('Natrium: ${foodNutritionInfo.natriumMg} mg'),
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
