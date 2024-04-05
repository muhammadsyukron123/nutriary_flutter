import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/consumption_log_provider.dart';
import 'food_log_detail_card.dart';

class FoodLogList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 500,
      child: Consumer<ConsumptionLogProvider>(
        builder: (context, provider, child) {
          if(provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.data.isEmpty ? 1 : provider.data.length,
            itemBuilder: (context, index) {
              if (provider.data.isEmpty) {
                return Center(child: Text("You haven't consumed any foods", style: TextStyle(fontSize: 20),));
              } else {
                return FoodLogCard(consumptionLog: provider.data[index]);
              }
            },
          );
        },
      ),
    );
  }
}