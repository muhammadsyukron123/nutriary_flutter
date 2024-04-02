import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:nutriary_flutter/presentation/provider/consumption_log_provider.dart';
import 'package:nutriary_flutter/presentation/provider/delete_food_log_provider.dart';
import 'package:nutriary_flutter/presentation/screens/add_food_log.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/letter-n.svg',
            height: 50, width: 50),
        centerTitle: true,
      ),
      body: Consumer<ConsumptionLogProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await Provider.of<ConsumptionLogProvider>(context, listen: false)
                  .refreshData();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Text('Food Log 🍲🍅🍗🍽',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('This is the record of food you have consumed today',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        provider.data.length > 0 ? provider.data.length : 1,
                    itemBuilder: (context, index) {
                      if (provider.data.length == 0) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("You haven't consumed any food yet today",
                                  style: TextStyle(fontSize: 20)),
                              Container(
                                height: 300,
                                child: Center(
                                  child:
                                      Lottie.asset('assets/lottie/hungry.json'),
                                ),
                              ),
                              //text button add food log
                              TextButton(
                                onPressed: () {
                                  Get.snackbar(
                                      'Add Food Log', 'Under Development');
                                },
                                child: Text('Add Food Log',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20)),
                              )
                            ]);
                      } else {
                        final consumptionLog = provider.data[index];
                        return Dismissible(
                          key: Key(consumptionLog.logId.toString()), // assuming each log has a unique id
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            // Call the function to delete the log from your data source here
                            // For example: ;
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<DeleteFoodLogProvider>(context, listen: false).deleteFoodLog(consumptionLog.logId); //assign the key to the logId
                              print(consumptionLog.logId);
                              Get.snackbar('Delete Food Log', 'Food Log Deleted', backgroundColor: Colors.red, colorText: Colors.white);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                          ),
                          child: FoodLogCard(consumptionLog: consumptionLog),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddFoodLog());
          },
          child: Icon(Icons.add),
        )
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
