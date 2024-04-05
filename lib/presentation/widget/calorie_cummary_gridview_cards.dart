import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/summary_provider.dart';

class CalorieSummaryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<SummaryProvider>(context, listen: false).refreshCalorieSummary();
    });
    return Consumer<SummaryProvider>(
      builder: (context, summaryProvider, child) {
        var calorieSummary = summaryProvider.calorieSummary;
        if (summaryProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: calorieSummary!.consumedCalories < calorieSummary.bmr
                  ? Colors.green
                  : Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: calorieSummary.consumedCalories < calorieSummary.bmr
                      ? Text(
                          '😄',
                          style: TextStyle(fontSize: 50),
                        )
                      : Text(
                          '😱',
                          style: TextStyle(fontSize: 50),
                        ),
                  title: calorieSummary.consumedCalories < calorieSummary.bmr
                      ? Text(
                          'Good job! You are still under the daily calorie limit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'You are surpassing the daily calorie limit !',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Card(
                  color: Colors.indigo,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total\nCalorie 🍽',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text('${calorieSummary?.consumedCalories} kcal',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
                Card(
                  color: Colors.indigo,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Remaining\nCalorie 🔥',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                      Text('${calorieSummary?.remainingCalories} kcal',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
                Card(
                  color: Colors.indigo,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Calorie\nLimit 🏋️‍♂️',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                      Text('${calorieSummary?.bmr} kcal',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
                // ... other cards
              ],
            ),
          ],
        );
      },
    );
  }
}
