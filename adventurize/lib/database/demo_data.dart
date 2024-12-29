import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/challenge_model.dart';

Future<void> insData() async {
  final db = DatabaseHelper();
  await db.insChall(Challenge(
    title: 'Feel the vibe!',
    desc: 'Show us the energy of Paris after dark. Whether its a vibrant club, a cozy bar, or the sparkling city lights. Snap a photo that captures the magic of the night! Upload your picture to the app and earn 700XP.',
    points: 700,
    status: 'Not Started',
    photoPath: 'lib/assets/challenges/challenge1.png',
  ));
}