import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/user/user_with_profile_model.dart';
import '../provider/get_user_profile_provider.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<GetUserProfileProvider>(context, listen: false).getUserProfile();
    });
    return Consumer<GetUserProfileProvider>(
      builder: (context, provider, child) {
        UserWithProfile? user = provider.userWithProfile;
        return SingleChildScrollView( // Wrap Column with SingleChildScrollView
          child: Column(
            children: [
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
            ],
          ),
        );
      },
    );
  }
}