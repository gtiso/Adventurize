import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';

Future<void> insData() async {
  final db = DatabaseHelper();

  await db.insChall(Challenge(
    title: 'Feel the vibe!',
    desc:
        'Show us the energy of Paris after dark. Whether its a vibrant club, a cozy bar, or the sparkling city lights. Snap a photo that captures the magic of the night!',
    points: 700,
    status: 'Not Started',
    photoPath: 'lib/assets/challenges/vibe.jpg',
  ));

  await db.insChall(Challenge(
    title: 'Taste the local!',
    desc:
        'Capture a photo of a delicious local dish that represents the heart of Parisian cuisine. Whether it’s a fresh croissant, or a colorful macaron, let your plate tell a story!  Bon appétit!',
    points: 300,
    status: 'Not Started',
    photoPath: 'lib/assets/challenges/food.jpg',
  ));

  await db.insChall(Challenge(
    title: 'Ready for a new view?',
    desc:
        'Take a photo of the Eiffel Tower! Whether it is a classic shot or something unique, capture its beauty from any angle you like.  Show off your creativity and stand out with your best snap! ',
    points: 800,
    status: 'Not Started',
    photoPath: 'lib/assets/challenges/view.jpg',
  ));

  await db.insChall(Challenge(
    title: 'Every step tells a story!',
    desc:
        'Take a photo of this stunning spot overlooking the Eiffel Tower, framed by the geometric patterns of the Trocadéro plaza. Whether it’s sunrise, sunset, or midday, showcase the beauty of this breathtaking location!',
    points: 900,
    status: 'Not Started',
    photoPath: 'lib/assets/challenges/step.jpg',
  ));
}
