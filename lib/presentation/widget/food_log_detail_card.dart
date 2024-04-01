import 'package:flutter/material.dart';
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';

class FoodLogCard extends StatelessWidget {
  final ConsumptionLog consumptionLog;

  FoodLogCard({required this.consumptionLog});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          title: Text(consumptionLog.foodName, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${consumptionLog.energyKal} kCal'),
          trailing: Text('${consumptionLog.quantity} gr'),
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Protein: ${consumptionLog.proteinG} g'),
                  Text('Fat: ${consumptionLog.fatG} g'),
                  Text('Carbohydrate: ${consumptionLog.carbsG} g'),
                  Text('Fiber: ${consumptionLog.fiberG} g'),
                  Text('Iron: ${consumptionLog.feMg} mg'),
                  Text('Calcium: ${consumptionLog.calciumMg} mg'),
                  Text('Natrium: ${consumptionLog.natriumMg} mg'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
