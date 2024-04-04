import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
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
            title: Text('Edit Account'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Call the method to update the user data here
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}