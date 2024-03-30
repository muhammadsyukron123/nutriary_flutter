class UserRegisterReponse {
  String username;
  String email;
  String firstname;
  String lastname;

  UserRegisterReponse({
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
  });

  factory UserRegisterReponse.fromJson(Map<String, dynamic> json) => UserRegisterReponse(
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
  };
}