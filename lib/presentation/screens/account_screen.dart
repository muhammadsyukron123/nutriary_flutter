import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/presentation/provider/consumption_log_provider.dart';
import 'package:nutriary_flutter/presentation/screens/edit_account_screen.dart';
import 'package:nutriary_flutter/presentation/screens/edit_body_information_page.dart';
import 'package:provider/provider.dart';

import '../../data/model/summary/summary_today_hive_model.dart';
import '../../data/model/user/user.dart';
import '../../data/model/user/user_with_profile_model.dart';
import '../provider/bottom_navbar_provider.dart';
import '../provider/food_nutrition_by_date_provider.dart';
import '../provider/get_user_profile_provider.dart';
import '../provider/summary_provider.dart';
import '../utils/loading_shimmer.dart';
import '../widget/user_profile_card.dart';
import 'create_profile_screen.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('userBox');
    final summaryBox = Hive.box<SummaryHiveModel>('summaryBox');
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<GetUserProfileProvider>(context, listen: false)
          .getUserProfile();
    });
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/letter-n.svg',
            height: 50, width: 50),
        centerTitle: true,
      ),
      body: Consumer<GetUserProfileProvider>(
        builder: (context, provider, child) {
          UserWithProfile? user = provider.userWithProfile;
          if (provider.isLoading) {
            // Show shimmer effect while loading
            return LoadingShimmer();
          }
          if (user == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You have not set your profile yet, set it now!',
                        style: TextStyle(fontSize: 20)),
                    TextButton(
                      onPressed: () {
                        Get.off(CreateProfileScreen());
                      },
                      child: Text('Profile',
                          style: TextStyle(color: Colors.blue, fontSize: 20)),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Logout'),
                                content:
                                    Text('Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                        );
                                        await userBox.clear();
                                        await summaryBox.clear();
                                        Provider.of<BottomNavigationProvider>(
                                                context,
                                                listen: false)
                                            .resetIndex();
                                        Provider.of<ConsumptionLogProvider>(
                                                context,
                                                listen: false)
                                            .clearData();
                                        Provider.of<FoodNutritionReportByDateProvider>(
                                                context,
                                                listen: false)
                                            .refreshNutritionReport();
                                        Get.offAll(LoginScreen());
                                        Get.deleteAll();
                                      });
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: Text('Logout',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                // Wrap Column with SingleChildScrollView
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account and Body Information',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(
                        'This your account and body information. You can update your information here.',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    ListTile(
                        title: Text('Account Information ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            'This is your account information'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.to(EditAccountScreen());
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Username'),
                            subtitle: Text(user!.username),
                          ),
                          ListTile(
                            title: Text('Email'),
                            subtitle: Text(user.email),
                          ),
                          ListTile(
                            title: Text('First Name'),
                            subtitle: Text(user.firstname),
                          ),
                          ListTile(
                            title: Text('Last Name'),
                            subtitle: Text(user.lastname),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      title: Text('Body Information ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Body information is used to calculate your daily calorie limit and nutrition report.'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.to(EditBodyInfoScreen());
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Gender'),
                            subtitle: Text(user.gender),
                          ),
                          ListTile(
                            title: Text('Age'),
                            subtitle: Text(user.age.toString()),
                          ),
                          ListTile(
                            title: Text('Height'),
                            subtitle: Text(user.height.toString()),
                          ),
                          ListTile(
                            title: Text('Weight'),
                            subtitle: Text(user.weight.toString()),
                          ),
                          ListTile(
                            title: Text('Activity Name'),
                            subtitle: Text(user.activityName),
                          ),
                          ListTile(
                            title: Text('Target Goal'),
                            subtitle: Text(user.targetGoal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Logout'),
                                content:
                                    Text('Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                        );
                                        await userBox.clear();
                                        await summaryBox.clear();
                                        Provider.of<BottomNavigationProvider>(
                                                context,
                                                listen: false)
                                            .resetIndex();
                                        Provider.of<ConsumptionLogProvider>(
                                                context,
                                                listen: false)
                                            .clearData();
                                        Provider.of<FoodNutritionReportByDateProvider>(
                                                context,
                                                listen: false)
                                            .refreshNutritionReport();
                                        Get.offAll(LoginScreen());
                                        Get.deleteAll();
                                      });
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: Text('Logout',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
