import 'dart:convert';

User usersFromMap(String str) => User.fromMap(json.decode(str));

String usersToMap(User data) => json.encode(data.toMap());

class User {
  int? userID;
  final String? fullname;
  final String? username;
  final String email;
  final String? birthdate;
  final String password;
  final int points;
  final String? avatarPath;

  User({
    this.userID,
    this.fullname,
    this.username,
    required this.password,
    required this.email,
    this.birthdate,
    this.points = 0,
    this.avatarPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'fullname': fullname,
      'username': username,
      'email': email,
      'birthdate': birthdate,
      'password': password,
      'points': points,
      'avatarPath': avatarPath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'],
      fullname: map['fullname'],
      username: map['username'],
      email: map['email'],
      birthdate: map['birthdate'],
      password: map['password'],
      points: map['points'],
      avatarPath: map['avatarPath'],
    );
  }

  User copyWith({
    int? userID,
    String? fullname,
    String? username,
    String? email,
    String? birthdate,
    String? password,
    int? points,
    String? avatarPath,
  }) {
    return User(
      userID: userID ?? this.userID,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
      password: password ?? this.password,
      points: points ?? this.points,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
