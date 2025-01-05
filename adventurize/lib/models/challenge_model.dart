import 'dart:convert';

Challenge challengesFromMap(String str) => Challenge.fromMap(json.decode(str));

String challengesToMap(Challenge data) => json.encode(data.toMap());

class Challenge {
  int? challengeID;
  final String title;
  final String desc;
  final String? photoPath;
  final int? points;

  Challenge({
    this.challengeID,
    required this.title,
    required this.desc,
    required this.photoPath,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'challengeID': challengeID,
      'title': title,
      'desc': desc,
      'photoPath': photoPath,
      'points': points,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      challengeID: map['challengeID'],
      title: map['title'],
      desc: map['desc'],
      photoPath: map['photoPath'],
      points: map['points'],
    );
  }

  Challenge copyWith({
    int? challengeID,
    String? title,
    String? desc,
    String? photoPath,
    int? points,
  }) {
    return Challenge(
      challengeID: challengeID ?? this.challengeID,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      photoPath: photoPath ?? this.photoPath,
      points: points ?? this.points,
    );
  }
}
