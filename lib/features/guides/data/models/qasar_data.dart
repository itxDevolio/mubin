import '../../domain/entities/guide_step.dart';

class QasarData {
  static List<GuideStep> getSteps() {
    return [
      // --- Method First (Tariqa) ---
      GuideStep(
        stepNumber: "1",
        titleEn: "Method of Qasar Salah",
        titleUr: "قصر نماز کا طریقہ",
        contentEn:
        "The method is identical to a regular 2-rak'ah Fard prayer (like Fajr). Make the Niyyah (intention) in your heart for '2 rak'ahs Qasar for Zuhr/Asr/Isha'. Perform the two rak'ahs with Ruku and Sujud, and finish with Tashahhud and Salam after the second rak'ah. No extra rak'ahs are added.",
        contentUr:
        "طریقہ بالکل عام 2 رکعتی فرض نماز (جیسے فجر) کی طرح ہے۔ دل میں نیت کریں کہ 'میں فلاں نماز (ظہر/عصر/عشاء) کی 2 رکعت قصر پڑھ رہا ہوں'۔ دو رکعتیں مکمل کریں اور دوسری رکعت کے قعدہ (تشہد) کے بعد سلام پھیر دیں، مزید رکعتیں شامل نہ کریں۔",
        reference: "Sahih al-Bukhari: 1090,Surah An-Nisa: 101",
      ),
      GuideStep(
        stepNumber: "2",
        titleEn: "Which Prayers are Shortened?",
        titleUr: "کون سی نمازوں میں قصر ہے؟",
        contentEn:
        "Only the 4-rak'ah Fard (obligatory) prayers are shortened to 2 rak'ahs. These are:\n• Zuhr (4 → 2)\n• Asr (4 → 2)\n• Isha (4 → 2)\n\nNote: Fajr (2 rak'ahs) and Maghrib (3 rak'ahs) remain exactly as they are, since their number was never four. Witr is also prayed as usual, and it is not dropped while traveling.",
        contentUr:
        "صرف چار رکعت والی فرض نمازوں میں قصر کیا جاتا ہے:\n• ظہر (4 کی جگہ 2)\n• عصر (4 کی جگہ 2)\n• عشاء (4 کی جگہ 2)\n\nنوٹ: فجر (2 رکعت) اور مغرب (3 رکعت) میں کوئی تبدیلی نہیں ہوگی، کیونکہ یہ کبھی چار رکعت تھیں ہی نہیں۔ وتر بھی سفر میں معاف نہیں، بلکہ معمول کے مطابق  پڑھے جائیں گے۔",
        reference: "Surah An-Nisa: 101, Sahih al-Bukhari: 1090, Sahih Muslim: 685",
      ),

      // --- Rulings (Ahkam) ---
      GuideStep(
        stepNumber: "3",
        titleEn: "Definition and Virtue of Qasar Salah",
        titleUr: "نمازِ قصر کی تعریف اور فضیلت",
        contentEn:
        "Qasar means 'to shorten'. When a Muslim undertakes a qualifying journey, Allah has granted a concession (Rukhsa) to shorten the four-rak'ah prayers to two. When a companion once asked why this concession applies even when there is no fear of an enemy, the Prophet ﷺ replied that it is a charity Allah has bestowed upon His servants, so they should accept His charity.",
        contentUr:
        "قصر کا لغوی معنی 'کم کرنا' ہے۔ جب ایک مسلمان سفر کی مقررہ شرط پوری کرتا ہے تو اللہ تعالیٰ نے چار رکعت والی نمازوں کو دو رکعت کرنے کی رخصت دی ہے۔ ایک صحابی نے جب پوچھا کہ خوف نہ ہونے کے باوجود قصر کیوں جائز ہے تو نبی کریم ﷺ نے فرمایا کہ یہ اللہ کا اپنے بندوں پر صدقہ ہے، لہٰذا اس کا صدقہ قبول کرو۔",
        reference: "Sahih Muslim: 686",
      ),
      GuideStep(
        stepNumber: "4",
        titleEn: "The Minimum Travel Distance",
        titleUr: "سفر کی کم از کم مسافت",
        contentEn:
        "The distance that qualifies a person as a 'Musafir' (traveler) is calculated from the practice of the Companions. Scholars set the minimum at 48 miles (approx. 78–90 km), which corresponds to 4 Burud (an ancient unit of distance). Qasr begins once you cross the inhabited boundaries of your own city or town with a firm intention to travel this distance.",
        contentUr:
        "مسافر بننے کے لیے مسافت کی حد صحابہ کرام کے عمل سے ماخوذ ہے۔ فقہاء نے اس کا تعین 48 میل (تقریباً 78 سے 90 کلومیٹر) کیا ہے، جو قدیم پیمائش کے مطابق 4 بُرُد بنتا ہے۔ قصر کے احکام اپنے شہر یا آبادی کی حدود سے باہر نکل کر، اسی مسافت کے پختہ ارادے کے ساتھ شروع ہو جاتے ہیں۔",
        reference: "Sahih al-Bukhari: Book of Shortening Prayers (Chapter 4), Sunan al-Bayhaqi: 3/146",
      ),

      GuideStep(
        stepNumber: "5",
        titleEn: "Duration of Stay",
        titleUr: "قیام کی مدت کا حکم",
        contentEn:
        "If you intend to stay at your destination for a period considered short by scholarly determination, you remain a Musafir and continue to pray Qasar. A commonly followed view — again reached through juristic reasoning rather than a direct hadith text — sets this limit at 15 days: if you intend to stay 15 days or more, you become a 'Muqeem' (resident) and must pray full prayers from the moment you arrive. This reasoning is built on reports that the Prophet ﷺ shortened his prayer during a nineteen-day stay in Makkah and during a twenty-day stay at Tabuk, without ever stating a fixed cut-off himself — which is why different scholars have arrived at different numbers.",
        contentUr:
        "اگر کسی جگہ قیام کی نیت مختصر مدت کی ہو، تو آدمی مسافر ہی رہتا ہے اور قصر جاری رکھتا ہے۔ ایک معروف اور رائج ضابطہ — جو براہِ راست حدیث کے بجائے فقہی اجتہاد سے طے کیا گیا ہے — یہ ہے کہ 15 دن یا اس سے زیادہ قیام کی نیت ہو تو انسان 'مقیم' شمار ہوتا ہے اور پہنچتے ہی پوری نماز پڑھنی ہوگی۔ یہ اجتہاد ان روایات پر مبنی ہے جن میں نبی کریم ﷺ نے مکہ میں انیس دن اور تبوک میں بیس دن قیام کے دوران قصر جاری رکھا، مگر خود کوئی مقررہ حد بیان نہیں فرمائی — یہی وجہ ہے کہ مختلف علماء نے مختلف اعداد پر اجتہاد کیا ہے۔",
        reference:
        "Sahih al-Bukhari: 1080 (stay in Makkah), Sunan Abu Dawud: 1235 (stay in Tabuk) — base evidences; the 15-day figure itself is a juristic (fiqhi) determination, e.g. Al-Hidayah",
      ),
      GuideStep(
        stepNumber: "6",
        titleEn: "Praying Behind an Imam",
        titleUr: "جماعت اور امامت کے مسائل",
        contentEn:
        "• If a traveler (Musafir) prays behind a resident (Muqeem) Imam, he must complete the full 4 rak'ahs, following the Imam to the end — he may not shorten on his own.\n• If a resident (Muqeem) prays behind a traveler (Musafir) Imam, the Imam will finish at 2 rak'ahs and say Salam, and the resident follower will then stand up alone to complete his remaining 2 rak'ahs.",
        contentUr:
        "• اگر مسافر کسی مقیم امام کے پیچھے نماز پڑھے، تو اسے امام کے ساتھ پوری 4 رکعتیں مکمل کرنی ہوں گی، خود سے قصر نہیں کر سکتا۔\n• اگر مقیم لوگ مسافر امام کے پیچھے نماز پڑھیں، تو امام 2 رکعت پر سلام پھیر دے گا، اور مقیم مقتدی خود کھڑے ہو کر اپنی باقی 2 رکعتیں مکمل کریں گے۔",
        reference: "Sahih Muslim: 688 (Ibn 'Abbas: 'That is the Sunnah')",
      ),
      GuideStep(
        stepNumber: "7",
        titleEn: "Status of Sunnah and Nafl",
        titleUr: "سنت اور نفل نمازوں کا مسئلہ",
        contentEn:
        "It is authentically reported that the Prophet ﷺ would not offer the regular (Rawatib) Sunnah prayers while traveling, with two exceptions: the Sunnah of Fajr and the Witr prayer, both of which he ﷺ maintained consistently, even performing them while riding. Other Nafl prayers remain a source of extra reward if offered, but are not required during travel.",
        contentUr:
        "صحیح روایات سے ثابت ہے کہ نبی کریم ﷺ سفر میں عام سنتِ مؤکدہ ادا نہیں فرماتے تھے، سوائے فجر کی سنت اور وتر کے، جن کا خاص اہتمام فرماتے تھے، حتیٰ کہ سواری پر بھی ادا فرما لیتے۔ باقی نوافل پڑھنا باعثِ اجر ہے مگر سفر میں لازم نہیں۔",
        reference: "Sahih al-Bukhari: 1000, Sahih Muslim: 700",
      ),
    ];
  }
}