import 'dart:convert';

Challenge challengesFromMap(String str) => Challenge.fromMap(json.decode(str));

String challengesToMap(Challenge data) => json.encode(data.toMap());

class Challenge {
  int? id;
  final String title;
  final String info;
  final String? photoPath;
  final String? dateCompleted;
  final int shared;

  Challenge({
    this.id,
    required this.title,
    required this.info,
    this.photoPath,
    this.dateCompleted,
    this.shared = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'info': info,
      'photoPath': photoPath,
      'dateCompleted': dateCompleted,
      'shared': shared,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      id: map['id'],
      title: map['title'],
      info: map['info'],
      photoPath: map['photoPath'],
      dateCompleted: map['dateCompleted'],
      shared: map['shared'],
    );
  }

  Challenge copyWith({
    int? id,
    String? title,
    String? info,
    String? photoPath,
    String? dateCompleted,
    int? shared,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      info: info ?? this.info,
      photoPath: photoPath ?? this.photoPath,
      dateCompleted: dateCompleted ?? this.dateCompleted,
      shared: shared ?? this.shared,
    );
  }
}
