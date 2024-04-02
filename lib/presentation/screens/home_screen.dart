import 'package:flutter/material.dart';
import 'package:nutriary_flutter/presentation/provider/load_food_name_list_provider.dart';
import 'package:nutriary_flutter/presentation/screens/add_food_log.dart';
import 'package:provider/provider.dart';

import '../provider/bottom_navbar_provider.dart';
import 'account_screen.dart';
import 'dashboard_screen.dart';
import 'food_log_screen.dart';
import 'food_nutrition_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    FoodLogScreen(),
    FoodNutritionInfoList(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(provider.currentIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'Account',
              ),
            ],
            currentIndex: provider.currentIndex,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(color: Colors.indigoAccent),
            selectedItemColor: Colors.indigoAccent,
            onTap: provider.changeIndex,
          ),
        );
      },
    );
  }
}