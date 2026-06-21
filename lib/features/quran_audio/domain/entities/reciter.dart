/// Entity representing a Quran reciter with only 3 selected reciters
/// All data is sourced from the quran package
class Reciter {
  final String id;
  final String name;
  final String arabicName;
  final String audioUrlPrefix;

  const Reciter({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.audioUrlPrefix,
  });

  /// Get display name with both English and Arabic
  String get displayName {
    return '$name\n$arabicName';
  }
}

/// The 3 selected reciters for this application
/// Using data from quran package sources
class Reciters {
  // Mishary Rashid Alafasy
  static const Reciter misharyRashidAlafasy = Reciter(
    id: 'mishary_rashid_alafasy',
    name: 'Mishary Rashid Alafasy',
    arabicName: 'مشاري بن راشد العفاسي',
    audioUrlPrefix: 'https://download.quranicaudio.com/quran/mishary_rashid_alafasy/',
  );

  // AbdulBaset AbdulSamad (Murattal)
  static const Reciter abdulBasetAbdulSamad = Reciter(
    id: 'abdulbaset_abdulsamad',
    name: 'AbdulBaset AbdulSamad',
    arabicName: 'عبدالباسط عبدالصمد',
    audioUrlPrefix: 'https://download.quranicaudio.com/quran/abdulbaset_abdulsamad/murattal/',
  );

  // Abdur-Rahman as-Sudais
  static const Reciter abdurRahmanAsSudais = Reciter(
    id: 'abdurrahman_as_sudais',
    name: 'Abdur-Rahman as-Sudais',
    arabicName: 'عبدالرحمن السديس',
    audioUrlPrefix: 'https://download.quranicaudio.com/quran/abdurrahman_as-sudais/',
  );

  /// List of all available reciters (only 3)
  static const List<Reciter> all = [
    misharyRashidAlafasy,
    abdulBasetAbdulSamad,
    abdurRahmanAsSudais,
  ];

  /// Get reciter by ID
  static Reciter? getById(String id) {
    try {
      return all.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get reciter by name (case-insensitive)
  static Reciter? getByName(String name) {
    try {
      return all.firstWhere(
        (r) => r.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Get default reciter (first one)
  static Reciter get defaultReciter => misharyRashidAlafasy;
}