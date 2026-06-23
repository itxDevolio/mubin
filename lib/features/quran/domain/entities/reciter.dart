class Reciter {
  final String name;
  final String urlPrefix;
  final String? arabicName;

  const Reciter({
    required this.name,
    required this.urlPrefix,
    this.arabicName,
  });
}

const List<Reciter> availableReciters = [
  Reciter(
    name: "Mishary Rashid Alafasy",
    urlPrefix: "https://download.quranicaudio.com/quran/mishary_rashid_alafasy/",
    arabicName: "مشاري بن راشد العفاسي",
  ),
];
