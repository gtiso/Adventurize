import 'dart:convert';

Memory memoryFromMap(String str) => Memory.fromMap(json.decode(str));

String memoryToMap(Memory data) => json.encode(data.toMap());

class Memory {
  int? memoryID;
  final int userID;
  final String userAvatarPath;
  final String userName;
  final String title;
  final String description;
  final String imagePath;
  final String date;
  final double latitude;
  final double longitude;

  Memory({
    this.memoryID,
    required this.userID,
    required this.userAvatarPath,
    required this.userName,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'memoryID': memoryID,
      'userID': userID,
      'userAvatarPath': userAvatarPath,
      'userName': userName,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      memoryID: map['memoryID'],
      userID: map['userID'],
      userAvatarPath: map['userAvatarPath'],
      userName: map['userName'],
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'],
      date: map['date'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Memory copyWith({
    int? memoryID,
    int? userID,
    String? userAvatarPath,
    String? userName,
    String? title,
    String? description,
    String? imagePath,
    String? date,
    double? latitude,
    double? longitude,
  }) {
    return Memory(
      memoryID: memoryID ?? this.memoryID,
      userID: userID ?? this.userID,
      userAvatarPath: userAvatarPath ?? this.userAvatarPath,
      userName: userName ?? this.userName,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
