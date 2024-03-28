import 'package:flutter/material.dart';
import 'package:nutriary_flutter/domain/usecases/get_all_food_nutrition_info.dart';

import 'food_log_screen.dart';
import 'food_nutrition_list_screen.dart';

class HomeScreen extends StatefulWidget {
  var getAllFoodNutritionInfo = GetAllFoodNutritionInfo();

  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutriary'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'FoodNutritionList'),
            Tab(text: 'Food log')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FoodNutritionInfoList(getAllFoodNutritionInfo: widget.getAllFoodNutritionInfo),
          FoodLogScreen()
        ],
      ),
    );
  }
}
