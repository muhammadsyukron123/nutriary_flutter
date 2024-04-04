import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nutriary_flutter/data/model/user/update_user_account_model.dart';
import 'package:nutriary_flutter/presentation/provider/update_user_account_provider.dart';
import 'package:nutriary_flutter/presentation/screens/account_screen.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../data/datasource/remote/profile_remote_datasource.dart';
import '../provider/get_user_profile_provider.dart';

class EditAccountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProfileProvider>(
      builder: (context, provider, child) {
        var user = provider.userWithProfile;
        _usernameController.text = user?.username ?? '';
        _emailController.text = user?.email ?? '';
        _firstNameController.text = user?.firstname ?? '';
        _lastNameController.text = user?.lastname ?? '';

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
                Text('Update account',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text('You can change these account information',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                //first name and last name fields
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the first name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the last name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<UpdateUserAccountProvider>(context, listen: false)
                            .updateUserAccount(
                            UpdateUser(
                                username: _usernameController.text,
                                email: _emailController.text,
                                firstname: _firstNameController.text,
                                lastname: _lastNameController.text)
                        );
                        Get.offAll(HomeScreen());
                        Get.snackbar('Success', 'Account updated successfully',backgroundColor: Colors.green, colorText: Colors.white);
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}