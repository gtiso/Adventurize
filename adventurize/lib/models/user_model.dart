import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  int? userId;
  final String? fullname;
  final String? username;
  final String email;
  final String? birthdate;
  final String password;
  final int points;

  Users({
    this.userId,
    this.fullname,
    this.username,
    required this.password,
    required this.email,
    this.birthdate,
    this.points = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullname': fullname,
      'username': username,
      'email': email,
      'birthdate': birthdate,
      'password': password,
      'points': points,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      userId: map['userId'],
      fullname: map['fullname'],
      username: map['username'],
      email: map['email'],
      birthdate: map['birthdate'],
      password: map['password'],
      points: map['points'],
    );
  }

  Users copyWith({
    int? userId,
    String? fullname,
    String? username,
    String? email,
    String? birthdate,
    String? password,
    int? points,
  }) {
    return Users(
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
      password: password ?? this.password,
      points: points ?? this.points,
    );
  }
}