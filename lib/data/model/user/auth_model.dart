class AuthModel {
  int userId;
  String username;
  String firstName;
  String lastName;
  String token;

  AuthModel({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    userId: json["userId"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "token": token,
  };
}
