class UserModel {
  final String? id;
  final String email;
  final String role;
  final String? password;
  final String? fullName;
  final String? phoneNumber;
  UserModel({
    this.id,
    required this.email,
    required this.role,
    this.password,
    this.fullName,
    this.phoneNumber,
  });
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json['email'],
      role: json['role'],
      password: json['password'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
  };
}
