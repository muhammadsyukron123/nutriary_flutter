class CreateUserProfile {
  String gender;
  int age;
  double height;
  double weight;
  int activityLevelId;
  int targetGoalId;

  CreateUserProfile({
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevelId,
    required this.targetGoalId,
  });

  factory CreateUserProfile.fromJson(Map<String, dynamic> json) => CreateUserProfile(
    gender: json["gender"],
    age: json["age"],
    height: json["height"],
    weight: json["weight"],
    activityLevelId: json["activityLevelId"],
    targetGoalId: json["targetGoalId"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "age": age,
    "height": height,
    "weight": weight,
    "activityLevelId": activityLevelId,
    "targetGoalId": targetGoalId,
  };
}
