import '../../domain/entities/guide_step.dart';

class JanazaData {
  static List<GuideStep> getAdultSteps(bool isMan, String madhab) {
    bool isHanafi = madhab == 'hanafi';

    return [
      GuideStep(
        stepNumber: "1",
        titleEn: "Intention (Niyyah)",
        titleUr: "نمازِ جنازہ کی نیت",
        contentEn:
            "Simply make the intention in your heart to pray the funeral prayer for the deceased for the sake of Allah. Verbal declaration is not required.",
        contentUr:
            "دل میں صرف یہ ارادہ (نیت) کر لیں کہ میں اللہ کی رضا کے لیے اس میت کی نمازِ جنازہ پڑھ رہا ہوں۔ زبان سے الفاظ کہنا ضروری نہیں ہے۔",
        reference: "Sahih al-Bukhari: 1",
      ),

      GuideStep(
        stepNumber: "2",
        titleEn: "First Takbeer & Surah Al-Fatiha",
        titleUr: "پہلی تکبیر اور سورۃ الفاتحہ",
        contentEn:
            "Raise your hands, say 'Allahu Akbar' and fold them. Then recite Surah Al-Fatihah",
        contentUr:
            "ہاتھ اٹھا کر 'اللہ اکبر' کہیں اور ہاتھ باندھ لیں۔ پھر سورۃ الفاتحہ پڑھیں",
        arabic:
            "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ ۝ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ۝ الرَّحْمَنِ الرَّحِيمِ ۝ مَالِكِ يَوْمِ الدِّينِ ۝ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ۝ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ۝ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ",
        translationEn:
            "In the name of Allah, the Most Gracious, the Most Merciful. All praise is due to Allah, Lord of the worlds. The Most Gracious, the Most Merciful. Master of the Day of Judgment. You alone we worship and You alone we ask for help. Guide us to the straight path. The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.",
        translationUr:
            "اللہ کے نام سے شروع جو بڑا مہربان نہایت رحم والا ہے۔ سب تعریفیں اللہ ہی کے لیے ہیں جو تمام جہانوں کا رب ہے۔ بڑا مہربان نہایت رحم والا ہے۔ سزا و جزا کے دن کا مالک ہے۔ ہم صرف تیری ہی عبادت کرتے ہیں اور تجھ ہی سے مدد مانگتے ہیں۔ ہمیں سیدھے راستے کی ہدایت فرما۔ ان لوگوں کا راستہ جن پر تو نے انعام کیا، نہ کہ ان کا جن پر غضب ہوا اور نہ گمراہوں کا۔",
        reference: "",
      ),
      GuideStep(
        stepNumber: "3",
        titleEn: "Second Takbeer & Durood",
        titleUr: "دوسری تکبیر اور درود شریف",
        contentEn: "Say 'Allahu Akbar' and recite 'Durood-e-Ibrahim'.",
        contentUr: "دوسری بار 'اللہ اکبر' کہیں  اور درودِ ابراہیم پڑھیں۔ ",
        arabic:
            "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ، اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ",
        translationEn:
            "O Allah, let Your Peace come upon Muhammad and the family of Muhammad, as you have brought peace to Ibrahim and his family. Truly, You are Praiseworthy and Glorious. O Allah, bless Muhammad and the family of Muhammad, as you have blessed Ibrahim and his family. Truly, You are Praiseworthy and Glorious.",
        translationUr:
            "اے اللہ! محمد ﷺ اور ان کی آل پر رحمتیں نازل فرما، جس طرح تو نے ابراہیم ؑ اور ان کی آل پر رحمتیں نازل فرمائیں، بے شک تو تعریف کے لائق اور بڑی شان والا ہے۔ اے اللہ! محمد ﷺ اور ان کی آل پر برکتیں نازل فرما، جس طرح تو نے ابراہیم ؑ اور ان کی آل پر برکتیں نازل فرمائیں، بے شک تو تعریف کے لائق اور بڑی شان والا ہے۔",
        reference: "Sahih al-Bukhari: 3370 ",
      ),
      GuideStep(
        stepNumber: "4",
        titleEn: "Third Takbeer & Dua for Deceased",
        titleUr: "تیسری تکبیر اور میت کے لیے دعا",
        contentEn:
            "Say 'Allahu Akbar' and recite the specific supplication for the deceased.",
        contentUr:
            "تیسری بار 'اللہ اکبر' کہیں اور میت کے لیے یہ مخصوص دعا پڑھیں۔",
        arabic:
            "اللَّهُمَّ اغْفِرْ لِحَيِّنَا وَمَيِّتِنَا وَشَاهِدِنَا وَغَائِبِنَا وَصَغِيرِنَا وَكَبِيرِنَا وَذَكَرِنَا وَأُنْثَانَا، اللَّهُمَّ مَنْ أَحْيَيْتَهُ مِنَّا فَأَهْيِهِ عَلَى الْإِسْلَامِ، وَمَنْ تَوَفَّيْتَهُ مِنَّا فَتَوفَّهُ عَلَى الْإِيمَانِ",
        translationEn:
            "O Allah, forgive our living and our dead, those present and those absent, our young and our old, our males and our females. O Allah, whomsoever among us You keep to live, then let him live on Islam, and whomsoever among us You cause to die, then let him die on Iman.",
        translationUr:
            "اے اللہ! ہمارے ہر زندہ اور مردہ، حاضر اور غائب، چھوٹے اور بڑے، اور مرد اور عورت کی مغفرت فرما۔ اے اللہ! ہم میں سے تو جس کو زندہ رکھے اسے اسلام پر زندہ رکھ اور جسے موت دے اسے ایمان پر موت دے۔",
        reference: "Sunan Abu Dawud: 3201, Jami' at-Tirmidhi: 1024 ",
      ),

      GuideStep(
        stepNumber: "5",
        titleEn: "Fourth Takbeer & Salam",
        titleUr: "چوتھی تکبیر اور سلام",
        contentEn:
            "Say 'Allahu Akbar'. pause briefly and then perform Salam, turning the head to the right.",
        contentUr:
            "چوتھی بار 'اللہ اکبر' کہیں۔  تھوڑا سا توقف کریں اور پھر دائیں  طرف سلام پھیر دیں۔",
        reference: "",
      ),
    ];
  }

  static List<GuideStep> getChildSteps(bool isBoy, String madhab) {
    bool isHanafi = madhab == 'hanafi';

    return [
      GuideStep(
        stepNumber: "1",
        titleEn: "Intention (Niyyah)",
        titleUr: "نابالغ کے جنازے کی نیت",
        contentEn:
            "Make the intention in your heart: 'I intend to pray Janaza for this child for the sake of Allah.'",
        contentUr:
            "دل میں نیت کریں کہ میں اس نابالغ بچے/بچی کی نمازِ جنازہ اللہ کی رضا کے لیے پڑھتا ہوں۔",
        reference: "",
      ),
      GuideStep(
        stepNumber: "2",
        titleEn: "First Takbeer & Fatiha",
        titleUr: "پہلی تکبیر اور سورۃ الفاتحہ",
        contentEn:
            "Say 'Allahu Akbar' and fold your hands. Recite Surah Al-Fatihah:",
        contentUr:
            "ہاتھ اٹھا کر 'اللہ اکبر' کہیں اور ہاتھ باندھ کر سورۃ الفاتحہ پڑھیں",
        arabic:
            "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ ۝ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ۝ الرَّحْمَنِ الرَّحِيمِ ۝ مَالِكِ يَوْمِ الدِّينِ ۝ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ۝ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ۝ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ",
        reference: "Sahih al-Bukhari: 1335",
      ),
      GuideStep(
        stepNumber: "3",
        titleEn: "Second Takbeer",
        titleUr: "دوسری تکبیر",
        contentEn: "Say 'Allahu Akbar' and recite 'Durood-e-Ibrahim'.",
        contentUr: "دوسری بار 'اللہ اکبر' کہیں اور درودِ ابراہیم پڑھیں۔",
        arabic:
            "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ، اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ",
        reference: "Sahih al-Bukhari: 3370",
      ),
      GuideStep(
        stepNumber: "4",
        titleEn: "Third Takbeer & Child Dua",
        titleUr: "تیسری تکبیر اور مخصوص دعا",
        contentEn:
            "Say 'Allahu Akbar' and recite the specific dua for a child:",
        contentUr: "تیسری بار 'اللہ اکبر' کہیں اور نابالغ کے لیے یہ دعا پڑھیں:",
        arabic: isBoy
            ? "اللَّهُمَّ اجْعَلْهُ لَنَا فَرَطًا، وَاجْعَلْهُ لَنَا أَجْرًا وَذُخْرًا، وَاجْعَلْهُ لَنَا شَافِعًا وَمُشَفَّعًا"
            : "اللَّهُمَّ اجْعَلْهَا لَنَا فَرَطًا، وَاجْعَلْهَا لَنَا أَجْرًا وَذُخْرًا، وَاجْعَلْهَا لَنَا شَافِعَةً وَمُشَفَّعَةً",
        translationEn: isBoy
            ? "O Allah, make him for us a precursor, and make him for us a reward and a treasure, and make him for us an intercessor whose intercession is accepted."
            : "O Allah, make her for us a precursor, and make her for us a reward and a treasure, and make her for us an intercessor whose intercession is accepted.",
        translationUr: isBoy
            ? "اے اللہ! اس بچے کو ہمارے لیے آگے پہنچ کر سامانِ راحت بننے والا بنا، اور اس کو ہمارے لیے اجر اور ذخیرہ بنا، اور اس کو ہمارے لیے شفاعت کرنے والا بنا جس کی شفاعت قبول کی جائے۔"
            : "اے اللہ! اس بچی کو ہمارے لیے آگے پہنچ کر سامانِ راحت بننے والی بنا، اور اس کو ہمارے لیے اجر اور ذخیرہ بنا، اور اس کو ہمارے لیے شفاعت کرنے والی بنا جس کی شفاعت قبول کی جائے۔",
        reference: "Sunan Abu Dawood 3180",
      ),
      GuideStep(
        stepNumber: "5",
        titleEn: "Fourth Takbeer & Salam",
        titleUr: "چوتھی تکبیر اور سلام",
        contentEn:
            "Say 'Allahu Akbar'. No additional dua is recited in the Hanafi school; pause briefly and perform Salam to the right and then to the left.",
        contentUr:
            "چوتھی بار 'اللہ اکبر' کہیں۔ حنفی مسلک میں کوئی اضافی دعا نہیں پڑھی جاتی؛ تھوڑا توقف کریں اور دائیں بائیں سلام پھیر دیں۔",
        reference: "",
      ),
    ];
  }
}
