import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nutriary_flutter/data/model/profile/create_user_profile_model.dart';
import 'package:nutriary_flutter/domain/entities/user_register_entity.dart';
import 'package:nutriary_flutter/presentation/provider/profile_provider.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../provider/get_user_profile_provider.dart';
import '../provider/user_register_provider.dart';
import '../utils/loading_shimmer.dart';

class EditBodyInfoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  final List<String> _genders = ['Male', 'Female'];
  String? _selectedGender;

  final List<Map<String, dynamic>> _activities = [
    {'id': 1, 'name': 'Sedentary'},
    {'id': 2, 'name': 'Slightly active'},
    {'id': 3, 'name': 'Moderately active'},
    {'id': 4, 'name': 'Very active'},
    {'id': 5, 'name': 'Extremely active'},
  ];
  Map<String, dynamic>? _selectedActivity;

  final List<Map<String, dynamic>> _goals = [
    {'id': 1, 'name': 'Weight Gain'},
    {'id': 2, 'name': 'Maintain Weight'},
    {'id': 3, 'name': 'Weight Loss'},
  ];
  Map<String, dynamic>? _selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProfileProvider>(
      builder: (context, provider, child) {
        var user = provider.userWithProfile;
        _selectedGender = user?.gender;
        _ageController.text = user?.age.toString() ?? '';
        _heightController.text = user?.height.toString() ?? '';
        _weightController.text = user?.weight.toString() ?? '';
        _selectedActivity = _activities.firstWhere((activity) => activity['name'] == user?.activityName, orElse: () => _activities[0]);
        _selectedGoal = _goals.firstWhere((goal) => goal['name'] == user?.targetGoal, orElse: () => _goals[0]);
        if (provider.isLoading) {
          // Show shimmer effect while loading
          return LoadingShimmer();
        }

        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset('assets/images/letter-n.svg',
                height: 50, width: 50),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Text('Update Body Information',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text('You can change these body information',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                //first name and last name fields
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: Text('Select Gender'),
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: _genders.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedGender = newValue;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _heightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the height';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Height',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the weight';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<Map<String, dynamic>>(
                  value: _selectedActivity,
                  hint: Text('Select Activity Level'),
                  decoration: InputDecoration(
                    labelText: 'Activity Level',
                    border: OutlineInputBorder(),
                  ),
                  items: _activities.map((Map<String, dynamic> activity) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: activity,
                      child: Text(activity['name']),
                    );
                  }).toList(),
                  onChanged: (Map<String, dynamic>? newActivity) {
                    _selectedActivity = newActivity;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select the activity level';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<Map<String, dynamic>>(
                  value: _selectedGoal,
                  hint: Text('Select Target Goal'),
                  decoration: InputDecoration(
                    labelText: 'Target Goal',
                    border: OutlineInputBorder(),
                  ),
                  items: _goals.map((Map<String, dynamic> goal) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: goal,
                      child: Text(goal['name']),
                    );
                  }).toList(),
                  onChanged: (Map<String, dynamic>? newGoal) {
                    _selectedGoal = newGoal;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select the target goal';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<ProfileProvider>(context, listen: false).insertUserProfile(CreateUserProfile(
                        gender: _selectedGender!,
                        age: int.parse(_ageController.text),
                        height: double.parse(_heightController.text),
                        weight: double.parse(_weightController.text),
                        activityLevelId: _selectedActivity!['id'],
                        targetGoalId: _selectedGoal!['id'],)
                      );
                      Get.offAll(HomeScreen());
                      Get.snackbar('Success','Body profile updated successfully', backgroundColor: Colors.green, colorText: Colors.white);
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.indigo),
                  ),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}