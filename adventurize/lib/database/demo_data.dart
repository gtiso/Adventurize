import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:adventurize/models/memory_model.dart';

Future<void> insData() async {
  await insDummyChallenges();
  await insDummyUsers();
  await insDummyMemories();
  await insDummyFriends();
}

Future<void> insDummyChallenges() async {
  final List<Challenge> challenges = [
    Challenge(
      title: 'Feel the vibe!',
      desc:
          'Show us the energy of Paris after dark. Whether it’s a vibrant club, '
          'a cozy bar, or the sparkling city lights. Snap a photo that captures the magic of the night!',
      points: 730,
      photoPath: 'lib/assets/challenges/vibe.jpg',
    ),
    Challenge(
      title: 'Timeless Wonders!',
      desc:
          'Capture the essence of ancient Athens at the Acropolis. Whether it’s the Parthenon glowing at sunset, '
          'the breathtaking ruins, or the panoramic city view. Share a photo that showcases the spirit of history and beauty!',
      points: 850,
      photoPath: 'lib/assets/challenges/acropolis.jpg',
    ),
    Challenge(
      title: 'Taste the local!',
      desc:
          'Capture a photo of a delicious local dish that represents the heart of Parisian cuisine. '
          'Whether it’s a fresh croissant, or a colorful macaron, let your plate tell a story! Bon appétit!',
      points: 330,
      photoPath: 'lib/assets/challenges/food.jpg',
    ),
    Challenge(
      title: 'Ready for a new view?',
      desc:
          'Take a photo of the Eiffel Tower! Whether it is a classic shot or something unique, '
          'capture its beauty from any angle you like. Show off your creativity and stand out with your best snap!',
      points: 870,
      photoPath: 'lib/assets/challenges/view.jpg',
    ),
    Challenge(
      title: 'Every step tells a story!',
      desc:
          'Take a photo of this stunning spot overlooking the Eiffel Tower, framed by the geometric patterns '
          'of the Trocadéro plaza. Whether it’s sunrise, sunset, or midday, showcase the beauty of this breathtaking location!',
      points: 420,
      photoPath: 'lib/assets/challenges/step.jpg',
    ),
  ];

  final db = DatabaseHelper();
  for (final challenge in challenges) {
    await db.insChall(challenge);
  }
}

Future<void> insDummyUsers() async {
  final List<User> users = [
    User(
      fullname: 'John Doe',
      username: 'john_doe',
      email: 'john.doe@example.com',
      birthdate: '1990-01-01',
      password: 'password123',
      points: 1150,
      avatarPath: 'lib/assets/avatars/avatar1.png',
    ),
    User(
      fullname: 'Robert Johnson',
      username: 'robert_j',
      email: 'robert.j@example.com',
      birthdate: '1988-03-22',
      password: 'mypassword123',
      points: 550,
      avatarPath: 'lib/assets/avatars/avatar2.png',
    ),
    User(
      fullname: 'Michael Lee',
      username: 'michael_lee',
      email: 'michael.lee@example.com',
      birthdate: '1993-06-25',
      password: 'supersecure',
      points: 830,
      avatarPath: 'lib/assets/avatars/avatar3.png',
    ),
    User(
      fullname: 'Jane Smith',
      username: 'jane_smith',
      email: 'jane.smith@example.com',
      birthdate: '1992-05-15',
      password: 'securepassword',
      points: 950,
      avatarPath: 'lib/assets/avatars/avatar4.png',
    ),
    User(
      fullname: 'Alice Brown',
      username: 'alice_brown',
      email: 'alice.b@example.com',
      birthdate: '1995-10-10',
      password: 'mypassword',
      points: 775,
      avatarPath: 'lib/assets/avatars/avatar5.png',
    ),
    User(
      fullname: 'Emily Davis',
      username: 'emily_davis',
      email: 'emily.davis@example.com',
      birthdate: '1998-02-14',
      password: 'password456',
      points: 540,
      avatarPath: 'lib/assets/avatars/avatar6.png',
    ),
    User(
      fullname: 'Maria Gonzalez',
      username: 'maria_g',
      email: 'maria.g@example.com',
      birthdate: '1998-07-23',
      password: 'password789',
      points: 840,
      avatarPath: 'lib/assets/avatars/avatar4.png',
    ),
    User(
      fullname: 'Konstantina Papadopoulos',
      username: 'konstantina_p',
      email: 'konstantina.p@example.com',
      birthdate: '1997-09-14',
      password: 'strongpassword',
      points: 940,
      avatarPath: 'lib/assets/avatars/avatar5.png',
    ),
  ];

  final db = DatabaseHelper();
  for (final user in users) {
    await db.insUser(user);
  }
}

Future<void> insDummyMemories() async {
  final List<Memory> memories = [
    Memory(
      title: "Tour Eiffel, Paris",
      userID: 1,
      userAvatarPath: 'lib/assets/avatars/avatar1.png',
      userName: 'john_doe',
      description: "Visited the iconic Eiffel Tower and enjoyed the view.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "July 12, 2023",
      latitude: 48.858455794286066,
      longitude: 2.294481966376659,
    ),
    Memory(
      title: "Acropolis of Athens, Greece",
      userID: 2,
      userAvatarPath: 'lib/assets/avatars/avatar2.png',
      userName: 'robert_j',
      description:
          "Explored the historic Acropolis and its breathtaking ruins.",
      imagePath: "lib/assets/challenges/acropolis.jpg",
      date: "August 15, 2023",
      latitude: 37.971532,
      longitude: 23.725749,
    ),
    Memory(
      title: "Louvre Museum, Paris",
      userID: 2,
      userAvatarPath: 'lib/assets/avatars/avatar2.png',
      userName: 'robert_j',
      description: "Explored the world-famous art museum.",
      imagePath: "lib/assets/challenges/view.jpg",
      date: "July 13, 2023",
      latitude: 48.860730990555076,
      longitude: 2.3376010624458345,
    ),
    Memory(
      title: "Arc De Triomphe, Paris",
      userID: 3,
      userAvatarPath: 'lib/assets/avatars/avatar3.png',
      userName: 'michael_lee',
      description: "Experienced the historic Arc de Triomphe.",
      imagePath: "lib/assets/challenges/step.jpg",
      date: "July 14, 2023",
      latitude: 48.87392745909576,
      longitude: 2.2949083081595547,
    ),
    Memory(
      title: "Big Ben, London",
      userID: 1,
      userAvatarPath: 'lib/assets/avatars/avatar1.png',
      userName: 'john_doe',
      description: "Admired the clock tower and its historic architecture.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "August 1, 2023",
      latitude: 51.500729,
      longitude: -0.124625,
    ),
    Memory(
      title: "Colosseum, Rome",
      userID: 2,
      userAvatarPath: 'lib/assets/avatars/avatar2.png',
      userName: 'robert_j',
      description: "Visited the ancient Colosseum and learned its history.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "August 10, 2023",
      latitude: 41.890210,
      longitude: 12.492231,
    ),
    Memory(
      title: "Taj Mahal, India",
      userID: 3,
      userAvatarPath: 'lib/assets/avatars/avatar3.png',
      userName: 'michael_lee',
      description: "Witnessed the beauty of the Taj Mahal during sunrise.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "September 15, 2023",
      latitude: 27.175144,
      longitude: 78.042142,
    ),
    Memory(
      title: "Sydney Opera House, Sydney",
      userID: 3,
      userAvatarPath: 'lib/assets/avatars/avatar3.png',
      userName: 'michael_lee',
      description: "Enjoyed a performance at the iconic Opera House.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "October 20, 2023",
      latitude: -33.8567844,
      longitude: 151.2152967,
    ),
    Memory(
      title: "Statue of Liberty, New York",
      userID: 2,
      userAvatarPath: 'lib/assets/avatars/avatar2.png',
      userName: 'robert_j',
      description: "Took a ferry to Liberty Island and admired the statue.",
      imagePath: "lib/assets/challenges/food.jpg",
      date: "November 5, 2023",
      latitude: 40.689247,
      longitude: -74.044502,
    ),
  ];

  final db = DatabaseHelper();
  for (final memory in memories) {
    await db.insMemory(memory);
  }
}

Future<void> insDummyFriends() async {
  final db = DatabaseHelper();
  await db.insFriend(1, 2);
  await db.insFriend(1, 3);
  await db.insFriend(1, 5);
}
