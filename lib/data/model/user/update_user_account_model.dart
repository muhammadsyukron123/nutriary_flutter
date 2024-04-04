class UpdateUser {
  int? userId;
  String username;
  String email;
  String firstname;
  String lastname;

  UpdateUser({
    this.userId,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
  });

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
    userId: json["userId"],
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
  };
}