import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/memory_model.dart';

Future<void> insData() async {
  await insDummyChallenges();
  // await insDummyUsers();
  // await insDummyMemories();
}

Future<void> insDummyChallenges() async {
  final List<Challenge> challenges = [
    Challenge(
      title: 'Feel the vibe!',
      desc:
          'Show us the energy of Paris after dark. Whether it’s a vibrant club, '
          'a cozy bar, or the sparkling city lights. Snap a photo that captures the magic of the night!',
      points: 700,
      photoPath: 'lib/assets/challenges/vibe.jpg',
    ),
    Challenge(
      title: 'Taste the local!',
      desc:
          'Capture a photo of a delicious local dish that represents the heart of Parisian cuisine. '
          'Whether it’s a fresh croissant, or a colorful macaron, let your plate tell a story! Bon appétit!',
      points: 300,
      photoPath: 'lib/assets/challenges/food.jpg',
    ),
    Challenge(
      title: 'Ready for a new view?',
      desc:
          'Take a photo of the Eiffel Tower! Whether it is a classic shot or something unique, '
          'capture its beauty from any angle you like. Show off your creativity and stand out with your best snap!',
      points: 800,
      photoPath: 'lib/assets/challenges/view.jpg',
    ),
    Challenge(
      title: 'Every step tells a story!',
      desc:
          'Take a photo of this stunning spot overlooking the Eiffel Tower, framed by the geometric patterns '
          'of the Trocadéro plaza. Whether it’s sunrise, sunset, or midday, showcase the beauty of this breathtaking location!',
      points: 900,
      photoPath: 'lib/assets/challenges/step.jpg',
    ),
  ];

  final db = DatabaseHelper();
  for (final challenge in challenges) {
    await db.insChall(challenge);
  }
}

// Future<void> insDummyUsers() async {
//   final List<User> users = [
//     User(
//       userId: 1,
//       fullname: 'John Doe',
//       username: 'john_doe',
//       email: 'john.doe@example.com',
//       birthdate: '1990-01-01',
//       password: 'password123',
//       points: 1150,
//       avatarPath: 'lib/assets/avatars/avatar1.png',
//     ),
//     User(
//       userId: 2,
//       fullname: 'Robert Johnson',
//       username: 'robert_j',
//       email: 'robert.j@example.com',
//       birthdate: '1988-03-22',
//       password: 'mypassword123',
//       points: 550,
//       avatarPath: 'lib/assets/avatars/avatar2.png',
//     ),
//     User(
//       userId: 3,
//       fullname: 'Michael Lee',
//       username: 'michael_lee',
//       email: 'michael.lee@example.com',
//       birthdate: '1993-06-25',
//       password: 'supersecure',
//       points: 830,
//       avatarPath: 'lib/assets/avatars/avatar3.png',
//     ),
//     User(
//       userId: 4,
//       fullname: 'Jane Smith',
//       username: 'jane_smith',
//       email: 'jane.smith@example.com',
//       birthdate: '1992-05-15',
//       password: 'securepassword',
//       points: 950,
//       avatarPath: 'lib/assets/avatars/avatar4.png',
//     ),
//     User(
//       userId: 5,
//       fullname: 'Alice Brown',
//       username: 'alice_brown',
//       email: 'alice.b@example.com',
//       birthdate: '1995-10-10',
//       password: 'mypassword',
//       points: 775,
//       avatarPath: 'lib/assets/avatars/avatar5.png',
//     ),
//     User(
//       userId: 6,
//       fullname: 'Emily Davis',
//       username: 'emily_davis',
//       email: 'emily.davis@example.com',
//       birthdate: '1998-02-14',
//       password: 'password456',
//       points: 540,
//       avatarPath: 'lib/assets/avatars/avatar6.png',
//     ),
//     User(
//       userId: 7,
//       fullname: 'Maria Gonzalez',
//       username: 'maria_g',
//       email: 'maria.g@example.com',
//       birthdate: '1998-07-23',
//       password: 'password789',
//       points: 840,
//       avatarPath: 'lib/assets/avatars/avatar4.png',
//     ),
//     User(
//       userId: 8,
//       fullname: 'Konstantina Papadopoulos',
//       username: 'konstantina_p',
//       email: 'konstantina.p@example.com',
//       birthdate: '1997-09-14',
//       password: 'strongpassword',
//       points: 940,
//       avatarPath: 'lib/assets/avatars/avatar5.png',
//     ),
//   ];

//   final db = DatabaseHelper();
//   for (final user in users) {
//     await db.insUser(user);
//   }
// }

// Future<void> insDummyMemories() async {
//   final List<Memory> memories = [
//     Memory(
//       title: "Tour Eiffel, Paris",
//       description: "Visited the iconic Eiffel Tower and enjoyed the view.",
//       imagePath: "lib/assets/challenges/food.jpg",
//       date: "July 12, 2023",
//       latitude: 36.1627,
//       longitude: -86.7816,
//     ),
//     Memory(
//       title: "Louvre Museum, Paris",
//       description: "Explored the world-famous art museum.",
//       imagePath: "lib/assets/challenges/view.jpg",
//       date: "July 13, 2023",
//       latitude: 36.1627,
//       longitude: -86.7500,
//     ),
//     Memory(
//       title: "Arc De Triomphe, Paris",
//       description: "Experienced the historic Arc de Triomphe.",
//       imagePath: "lib/assets/challenges/step.jpg",
//       date: "July 14, 2023",
//       latitude: 36.1400,
//       longitude: -86.7816,
//     ),
//   ];

//   final db = DatabaseHelper();
//   for (final memory in memories) {
//     await db.insMemory(memory);
//   }
// }
