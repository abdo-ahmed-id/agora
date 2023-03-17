class UserModel {
  String email;
  String password;
  String name;
  String phone;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  factory UserModel.fromMap(Map json) {
    return UserModel(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        phone: json["phone"]);
  }
}
