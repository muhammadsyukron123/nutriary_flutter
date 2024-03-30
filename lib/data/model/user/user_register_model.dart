class UserRegister{
  String username;
  String email;
  String password;
  String confirmPassword;
  String firstname;
  String lastname;

  UserRegister({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstname,
    required this.lastname,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
    username: json["username"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "firstname": firstname,
    "lastname": lastname,
  };
}