import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nutriary_flutter/presentation/provider/consumption_log_provider.dart';
import 'package:nutriary_flutter/presentation/widget/food_log_detail_card.dart';
import 'package:provider/provider.dart';

import '../../data/model/foodlog/consumption_log_model.dart';

class FoodLogScreen extends StatelessWidget {
  const FoodLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConsumptionLogProvider>(context, listen: false).refreshData();
    });
    return Consumer<ConsumptionLogProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await Provider.of<ConsumptionLogProvider>(context, listen: false).refreshData();
          },
          child: ListView.builder(
            itemCount: provider.data.length,
            itemBuilder: (context, index) {
              final consumptionLog = provider.data[index];
              return FoodLogCard(consumptionLog: consumptionLog);
            },
          ),
        );
      },
    );
  }
}

// class FoodLogScreen extends StatelessWidget {
//   const FoodLogScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () => Future.sync(
//             () => Provider.of<ConsumptionLogProvider>(context, listen: false).pagingController.refresh(),
//       ),
//       child: PagedListView<int, ConsumptionLog>(
//         pagingController: Provider.of<ConsumptionLogProvider>(context, listen: false).pagingController,
//         builderDelegate: PagedChildBuilderDelegate<ConsumptionLog>(
//           itemBuilder: (context, consumptionLog, index) => FoodLogCard(consumptionLog: consumptionLog),
//         ),
//       ),
//     );
//   }
// }