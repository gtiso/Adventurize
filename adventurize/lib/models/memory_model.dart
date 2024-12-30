import 'dart:convert';

Memory memoryFromMap(String str) => Memory.fromMap(json.decode(str));

String memoryToMap(Memory data) => json.encode(data.toMap());

class Memory {
  int? memoryID;
  final String title;
  final String description;
  final String? imagePath;
  final String date;
  final bool isFavorite;
  final double latitude;
  final double longitude;

  Memory({
    this.memoryID,
    required this.title,
    required this.description,
    this.imagePath,
    required this.date,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'memoryID': memoryID,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'isFavorite': isFavorite,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      memoryID: map['memoryID'],
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'],
      date: map['date'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  Memory copyWith({
    int? memoryID,
    String? title,
    String? description,
    String? imagePath,
    String? date,
    bool? isFavorite,
    double? latitude,
    double? longitude,
  }) {
    return Memory(
      memoryID: memoryID ?? this.memoryID,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
