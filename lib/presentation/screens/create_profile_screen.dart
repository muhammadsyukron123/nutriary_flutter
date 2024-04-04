import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nutriary_flutter/data/model/profile/create_user_profile_model.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../provider/profile_provider.dart';
import 'dashboard_screen.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    TextEditingController _ageController = TextEditingController();
    TextEditingController _heightController = TextEditingController();
    TextEditingController _weightController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/letter-n.svg',
            height: 50, width: 50),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create your profile here! 🕶',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('You should create your profile first',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    //first name and last name fields
                    SizedBox(height: 20),
                    //Gender male or female dropdownbuttonformfield
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      hint: Text('Select Gender'),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
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
                        if (value == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    //age field
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    //height field
                    TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    //weight field
                    TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    //activity level dropdownbuttonformfield
                    DropdownButtonFormField<Map<String, dynamic>>(
                      value: _selectedActivity,
                      hint: Text('Select Activity Level'),
                      decoration: InputDecoration(
                        labelText: 'Activity Level',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
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
                          return 'Please select your activity level';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    //target goal dropdownbuttonformfield
                    //target goal dropdownbuttonformfield
                    DropdownButtonFormField<Map<String, dynamic>>(
                      value: _selectedGoal,
                      hint: Text('Select Target Goal'),
                      decoration: InputDecoration(
                        labelText: 'Target Goal',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
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
                          return 'Please select your target goal';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    //submit button
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_selectedGender == null || _selectedActivity == null || _selectedGoal == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill all the fields')),
                                );
                                return;
                              }
                              CreateUserProfile createProfile = CreateUserProfile(
                                gender: _selectedGender!,
                                age: int.parse(_ageController.text),
                                height: double.parse(_heightController.text),
                                weight: double.parse(_weightController.text),
                                activityLevelId: _selectedActivity!['id'],
                                targetGoalId: _selectedGoal!['id'],
                              );
                              await Provider.of<ProfileProvider>(context, listen: false).insertUserProfile(createProfile);
                              WidgetsBinding.instance!.addPostFrameCallback((_) {
                                Get.off(() => HomeScreen());
                              });
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please fill the required fields')),
                              );
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                          ),
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
