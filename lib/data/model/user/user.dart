

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  final int? userId;

  @HiveField(1)
  final String? username;

  @HiveField(2)
  final String? firstName;

  @HiveField(3)
  final String? lastName;

  @HiveField(4)
  final String? token;

  User({this.userId, this.username, this.firstName, this.lastName, this.token});

  // Add fromJson method
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      token: json['token'],
    );
  }
}