import 'dart:convert';

Challenge challengesFromMap(String str) => Challenge.fromMap(json.decode(str));

String challengesToMap(Challenge data) => json.encode(data.toMap());

class Challenge {
  int? challengeID;
  final String title;
  final String desc;
  final String? photoPath;
  final String status;
  final int shared;
  final int? points;

  Challenge({
    this.challengeID,
    required this.title,
    required this.desc,
    this.photoPath,
    required this.status,
    this.shared = 0,
    this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'challengeID': challengeID,
      'title': title,
      'desc': desc,
      'photoPath': photoPath,
      'status': status,
      'shared': shared,
      'points': points,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      challengeID: map['challengeID'],
      title: map['title'],
      desc: map['desc'],
      photoPath: map['photoPath'],
      status: map['status'],
      shared: map['shared'],
      points: map['points'],
    );
  }

  Challenge copyWith({
    int? challengeID,
    String? title,
    String? desc,
    String? photoPath,
    String? status,
    int? shared,
    int? points,
  }) {
    return Challenge(
      challengeID: challengeID ?? this.challengeID,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      photoPath: photoPath ?? this.photoPath,
      status: status ?? this.status,
      shared: shared ?? this.shared,
      points: points ?? this.points,
    );
  }
}
