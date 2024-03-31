class UserWithProfile {
  int userId;
  String username;
  String email;
  String firstname;
  String lastname;
  String gender;
  int age;
  int height;
  int weight;
  String activityName;
  String targetGoal;
  double bmr;

  UserWithProfile({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityName,
    required this.targetGoal,
    required this.bmr,
  });

  factory UserWithProfile.fromJson(Map<String, dynamic> json) => UserWithProfile(
    userId: json["userId"],
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    gender: json["gender"],
    age: json["age"],
    height: json["height"],
    weight: json["weight"],
    activityName: json["activityName"],
    targetGoal: json["targetGoal"],
    bmr: json["bmr"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "gender": gender,
    "age": age,
    "height": height,
    "weight": weight,
    "activityName": activityName,
    "targetGoal": targetGoal,
    "bmr": bmr,
  };
}
