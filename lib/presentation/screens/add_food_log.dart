import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/presentation/screens/food_log_screen.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../data/model/foods/food_name_hive_model.dart';
import '../provider/add_food_log_provider.dart';
import '../provider/consumption_log_provider.dart';

class AddFoodLog extends StatelessWidget {
  final ValueNotifier<FoodNameHiveModel?> selectedFood = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<FoodNameHiveModel>('foodNameBox');
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    GlobalKey<FormFieldState> _foodKey = GlobalKey<FormFieldState>();
    TextEditingController _foodController = TextEditingController();
    TextEditingController _quantityController = TextEditingController();
    List<FoodNameHiveModel> foodNameList = [];
    for (var i = 0; i < box.length; i++) {
      foodNameList.add(box.getAt(i)!);
    }
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/letter-n.svg',
            height: 50, width: 50),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Text('Add Food Log 🍲🍅🍗🍽',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Add your food consumption today',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ValueListenableBuilder<FoodNameHiveModel?>(
              valueListenable: selectedFood,
              builder: (context, value, child) {
                return DropdownSearch<FoodNameHiveModel>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Search Food',
                      ),
                    ),
                  ),
                  items: foodNameList,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: 'Food Name',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                      ),
                    ),
                  ),
                  onChanged: (FoodNameHiveModel? data) {
                    selectedFood.value = data;
                    print(selectedFood.value?.foodId);
                    _foodController.text = selectedFood.value!.foodId!;
                  },
                  selectedItem: selectedFood.value,
                  itemAsString: (FoodNameHiveModel u) => u.foodName!,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select food';
                    }
                    return null;
                  },
                );
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter quantity';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Food: ${_foodController.text}');
                    print('Quantity: ${_quantityController.text}');
                    await Provider.of<AddFoodLogProvider>(context,
                            listen: false)
                        .addConsumptionLogToday(_foodController.text,
                            double.parse(_quantityController.text));
                    await Provider.of<ConsumptionLogProvider>(context,
                            listen: false)
                        .refreshData();
                    Get.offAll(HomeScreen());
                    Get.snackbar('Success', 'Food log added successfully',
                        backgroundColor: Colors.green);
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// class FoodNutritionName extends StatelessWidget {
//   FoodNameHiveModel? selectedFood;
//
//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box<FoodNameHiveModel>('foodNameBox');
//     List<FoodNameHiveModel> foodNameList = [];
//     for (var i = 0; i < box.length; i++) {
//       foodNameList.add(box.getAt(i)!);
//     }
//
//     return Scaffold(
//       body: ListView(
//         children: [
//
//           // DropdownMenu(
//           //   requestFocusOnTap: true,
//           //   enableFilter: true,
//           //   enabled: true,
//           //   enableSearch: true,
//           //   label: Text('Select Food'),
//           //   onSelected: (value) {
//           //     print(value?.foodId);
//           //   },
//           //   dropdownMenuEntries: foodNameList
//           //       .map((FoodNameHiveModel e) =>
//           //           DropdownMenuEntry<FoodNameHiveModel>(
//           //             value: e,
//           //             label: e.foodName!,
//           //           ))
//           //       .toList(),
//           // ),
//
//           // DropdownSearch<FoodNameHiveModel>(
//           //   popupProps: PopupProps.menu(),
//           //   dropdownDecoratorProps: DropDownDecoratorProps(
//           //     dropdownSearchDecoration: InputDecoration(
//           //       border: OutlineInputBorder(),
//           //       contentPadding: EdgeInsets.all(10),
//           //       labelText: 'Select Food',
//           //     ),
//           //   ),
//           //   asyncItems: (String filter) => Future.value(foodNameList),
//           //
//           //   onChanged: (FoodNameHiveModel? data) {
//           //     selectedFood = data;
//           //     print(selectedFood?.foodId);
//           //   },
//           //   itemAsString: (FoodNameHiveModel u) => u.foodName!,
//           //   selectedItem: selectedFood,
//           // ),
//         ],
//       ),
//     );
//   }
// }

// DropdownSearch<FoodNameHiveModel>
// (
// popupProps: PopupProps.menu(),
// dropdownDecoratorProps: DropDownDecoratorProps(
// dropdownSearchDecoration: InputDecoration(
// border: OutlineInputBorder(),
// contentPadding: EdgeInsets.all(10),
// labelText: 'Select Food',
// ),
// ),
// asyncItems: (String filter) => Future.value(foodNameList),
//
// onChanged: (FoodNameHiveModel? data) {
// selectedFood.value = data;
// print(selectedFood.value?.foodId);
// },
// itemAsString: (FoodNameHiveModel u) => u.foodName!,
// selectedItem: selectedFood.value,
// );

// DropdownMenu<FoodNameHiveModel>(
// requestFocusOnTap: true,
// enableFilter: true,
// enabled: true,
// enableSearch: true,
// label: Text('Select Food'),
// onSelected: (value) {
// print(value?.foodName);
// },
// dropdownMenuEntries: foodNameList
//     .map((FoodNameHiveModel e) => DropdownMenuEntry<FoodNameHiveModel>(
// value: e,
// label: e.foodName!,
// ))
// .toList(),
// )),
