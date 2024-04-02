import 'package:flutter/material.dart';
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';

class FoodLogCard extends StatelessWidget {
  final ConsumptionLog consumptionLog;

  FoodLogCard({required this.consumptionLog});

  @override
  Widget build(BuildContext context) {
    // Add null checks before accessing properties of consumptionLog
    final foodName = consumptionLog.foodName ?? 'Unknown';
    final energyKal = consumptionLog.energyKal ?? 0;
    final quantity = consumptionLog.quantity ?? 0;
    final proteinG = consumptionLog.proteinG ?? 0;
    final fatG = consumptionLog.fatG ?? 0;
    final carbsG = consumptionLog.carbsG ?? 0;
    final fiberG = consumptionLog.fiberG ?? 0;
    final feMg = consumptionLog.feMg ?? 0;
    final calciumMg = consumptionLog.calciumMg ?? 0;
    final natriumMg = consumptionLog.natriumMg ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          title: Text(foodName, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('$energyKal kCal'),
          trailing: Text('$quantity gr'),
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Protein: $proteinG g'),
                  Text('Fat: $fatG g'),
                  Text('Carbohydrate: $carbsG g'),
                  Text('Fiber: $fiberG g'),
                  Text('Iron: $feMg mg'),
                  Text('Calcium: $calciumMg mg'),
                  Text('Natrium: $natriumMg mg'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
