import 'verse.dart';

class Juz {
  final int number; // Juz number (1-30)
  final List<Verse> verses; // Is Juz ke andar aane wali tamam verses

  const Juz({required this.number, this.verses = const []});
}
