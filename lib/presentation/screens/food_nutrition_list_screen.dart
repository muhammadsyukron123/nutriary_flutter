import 'package:flutter/material.dart';

import '../../data/model/nutrition/food_nutrition_info_model.dart';
import '../../domain/usecases/get_all_food_nutrition_info.dart';
import '../widget/food_nutrition_info_card.dart';

// ignore: must_be_immutable
// class FoodNutritionInfoList extends StatelessWidget {
//   var getAllFoodNutritionInfo = GetAllFoodNutritionInfo();
//
//   FoodNutritionInfoList({super.key, required this.getAllFoodNutritionInfo});
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//         onRefresh: () async {
//           await getAllFoodNutritionInfo.execute();
//         },
//         child: FutureBuilder(
//           future: getAllFoodNutritionInfo.execute(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                     'Error: ${snapshot.error} connectionState: ${snapshot.connectionState}'),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data?.length,
//                 itemBuilder: (context, index) {
//                   final foodNutritionInfo = snapshot.data![index];
//                   return FoodNutritionInfoCard(
//                       foodNutritionInfo: foodNutritionInfo);
//                 },
//               );
//             }
//           },
//         ));
//   }
// }





class FoodNutritionInfoList extends StatefulWidget {
  var getAllFoodNutritionInfo = GetAllFoodNutritionInfo();

  FoodNutritionInfoList({super.key, required this.getAllFoodNutritionInfo});

  @override
  _FoodNutritionInfoListState createState() => _FoodNutritionInfoListState();
}

class _FoodNutritionInfoListState extends State<FoodNutritionInfoList> {
  var _controller = ScrollController();
  var _lastItem;
  var _data = <FoodNutritionInfo>[];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    var newData = await widget.getAllFoodNutritionInfo.execute(lastItem: _lastItem);
    if (newData.isNotEmpty) {
      setState(() {
        _data.addAll(newData);
        _lastItem = _data.last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _lastItem = null;
        _data.clear();
        await _loadData();
      },
      child: ListView.builder(
        controller: _controller,
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final foodNutritionInfo = _data[index];
          return FoodNutritionInfoCard(foodNutritionInfo: foodNutritionInfo);
        },
      ),
    );
  }
}