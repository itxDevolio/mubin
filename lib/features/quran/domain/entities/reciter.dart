class Reciter {
  final String name;
  final String urlPrefix;
  final String? arabicName; // Optional Arabic name for better display

  const Reciter({
    required this.name,
    required this.urlPrefix,
    this.arabicName,
  });
}

const List<Reciter> availableReciters = [
  // Original 3 reciters
  Reciter(
    name: "Mishary Rashid Alafasy",
    urlPrefix: "https://download.quranicaudio.com/quran/mishary_rashid_alafasy/",
    arabicName: "مشاري بن راشد العفاسي",
  ),
  Reciter(
    name: "AbdulBaset AbdulSamad",
    urlPrefix: "https://download.quranicaudio.com/quran/abdulbaset_abdulsamad/murattal/",
    arabicName: "عبدالباسط عبدالصمد",
  ),
  Reciter(
    name: "Abdur-Rahman as-Sudais",
    urlPrefix: "https://download.quranicaudio.com/quran/abdurrahman_as-sudais/",
    arabicName: "عبدالرحمن السديس",
  ),
  
  // Additional popular reciters
  Reciter(
    name: "Saad Al-Ghamdi",
    urlPrefix: "https://download.quranicaudio.com/quran/saad_al-ghamdi/",
    arabicName: "سعد الغامدي",
  ),
  Reciter(
    name: "Abu Bakr Al-Shatri",
    urlPrefix: "https://download.quranicaudio.com/quran/abu_bakr_ash-shaatree/",
    arabicName: "أبو بكر الشاطري",
  ),
  Reciter(
    name: "Mahmoud Khalil Al-Hussary",
    urlPrefix: "https://download.quranicaudio.com/quran/mahmoud_khalil_al-hussary/",
    arabicName: "محمود خليل الحصري",
  ),
  Reciter(
    name: "Ahmed ibn Ali al-Ajamy",
    urlPrefix: "https://download.quranicaudio.com/quran/ahmed_ibn_ali_al-ajamy/",
    arabicName: "أحمد بن علي العجمي",
  ),
  Reciter(
    name: "Muhammad Ayyub",
    urlPrefix: "https://download.quranicaudio.com/quran/muhammad_ayyoub/",
    arabicName: "محمد أيوب",
  ),
  Reciter(
    name: "Ali Jaber",
    urlPrefix: "https://download.quranicaudio.com/quran/ali_jaber/",
    arabicName: "علي جابر",
  ),
  Reciter(
    name: "Yasser Al-Dosari",
    urlPrefix: "https://download.quranicaudio.com/quran/yasser_ad-dussary/",
    arabicName: "ياسر الدوسري",
  ),
  Reciter(
    name: "Hani ar-Rifai",
    urlPrefix: "https://download.quranicaudio.com/quran/hani_ar-rifai/",
    arabicName: "هاني الرفاعي",
  ),
  Reciter(
    name: "Husary (Mujawwad)",
    urlPrefix: "https://download.quranicaudio.com/quran/mahmoud_khalil_al-hussary/mujawwad/",
    arabicName: "محمود خليل الحصري (مجود)",
  ),
];

// Helper function to get reciter by name
Reciter getReciterByName(String name) {
  try {
    return availableReciters.firstWhere((r) => r.name == name);
  } catch (_) {
    return availableReciters.first; // Default to first reciter
  }
}

// Helper function to get reciter display name
String getReciterDisplayName(Reciter reciter) {
  if (reciter.arabicName != null && reciter.arabicName!.isNotEmpty) {
    return "${reciter.name}\n${reciter.arabicName}";
  }
  return reciter.name;
}