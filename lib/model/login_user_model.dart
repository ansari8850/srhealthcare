import 'dart:convert';

class LoginModelClass {
  bool? error;
  String? message;
  String? accessToken;
  int? status;
  bool? verify;
  UserModel? result;

  LoginModelClass({
    this.error,
    this.message,
    this.accessToken,
    this.status,
    this.verify,
    this.result,
  });

  LoginModelClass copyWith({
    bool? error,
    String? message,
    String? accessToken,
    int? status,
    bool? verify,
    UserModel? result,
  }) =>
      LoginModelClass(
        error: error ?? this.error,
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        status: status ?? this.status,
        verify: verify ?? this.verify,
        result: result ?? this.result,
      );

  factory LoginModelClass.fromRawJson(String str) =>
      LoginModelClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModelClass.fromJson(Map<String, dynamic> json) =>
      LoginModelClass(
        error: json["error"],
        message: json["message"],
        accessToken: json["access_token"],
        status: json["status"],
        verify: json["verify"],
        result:
            json["result"] == null ? null : UserModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "access_token": accessToken,
        "status": status,
        "verify": verify,
        "result": result?.toJson(),
      };
}
class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String mobileNo;
  final String email;
  final String displayName;
  final String bio;
  final String photo;
  final String education;
  final String address;
  final String status;
  final String accessToken;
  
  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.mobileNo,
    required this.email,
    required this.displayName,
    required this.bio,
    required this.photo,
    required this.education,
    required this.address,
    required this.status,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['result']['id'] ?? 0,
      name: json['result']['name'] ?? '',
      lastName: json['result']['last_name'] ?? '',
      mobileNo: json['result']['mobile_no'] ?? '',
      email: json['result']['email'] ?? '',
      displayName: json['result']['display_name'] ?? '',
      bio: json['result']['bio'] ?? '',
      photo: json['result']['photo'] ?? '',
      education: json['result']['education'] ?? '',
      address: json['result']['address'] ?? '',
      status: json['status'] ?? '',
      accessToken: json['access_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'mobile_no': mobileNo,
      'email': email,
      'display_name': displayName,
      'bio': bio,
      'photo': photo,
      'education': education,
      'address': address,
      'status': status,
      'access_token': accessToken,
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? lastName,
    String? mobileNo,
    String? email,
    String? displayName,
    String? bio,
    String? photo,
    String? education,
    String? address,
    String? status,
    String? accessToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      photo: photo ?? this.photo,
      education: education ?? this.education,
      address: address ?? this.address,
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
