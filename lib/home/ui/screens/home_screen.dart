import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/feature_card.dart';
import '../widgets/guide_card.dart';

import '../widgets/user_profile_widget.dart';
import '../widgets/prayer_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 🔥 STICKY SECTION: Profile ab Column ka direct bacha hai, ye kabhi scroll nahi hoga!
            UserProfileWidget(
              name: "Khadija",
              pUrl: "https://media.gettyimages.com/id/956842252/photo/portrait-of-a-confident-muslim-girl.jpg?s=170667a&w=gi&k=20&c=DonQKYjWv-OgPjWQxPpMK1mljHEfihmiZow2iYnpdGg=",
            ),

            const SizedBox(height: 10),

            // 🔥 SCROLLABLE SECTION: Baqi saara maal is Expanded list ke andar smoothly scroll hoga
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Realtime Prayer Dashboard Section
                    PrayerCard(date: DateTime.now()),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ROW 1: Quran, Hadith, Adhkar
                          Row(
                            children: [
                              Expanded(
                                child: FeatureCard(
                                  title: "Quran",
                                  icon: FlutterIslamicIcons.quran,
                                  onTap: () {},
                                ),
                              ),
                              Expanded(
                                child: FeatureCard(
                                  title: "Hadith",
                                  icon: FlutterIslamicIcons.quran2,
                                  onTap: () {},
                                ),
                              ),
                              Expanded(
                                child: FeatureCard(
                                  title: "Adhkar",
                                  icon: FlutterIslamicIcons.tasbihHand,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // ROW 2: Shifa, Qibla, Duas
                          Row(
                            children: [
                              Expanded(
                                child: FeatureCard(
                                  title: "Shifa",
                                  icon: FlutterIslamicIcons.prayingPerson,
                                  onTap: () {},
                                ),
                              ),
                              Expanded(
                                child: FeatureCard(
                                  title: "Qibla",
                                  icon: FlutterIslamicIcons.qibla2,
                                  onTap: () {},
                                ),
                              ),
                              Expanded(
                                child: FeatureCard(
                                  title: "Duas",
                                  icon: FlutterIslamicIcons.prayer,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Section Title for Guide Cards
                          Text(
                            "Islamic Guides",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.titleLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // HORIZONTAL GUIDE SLIDER (Height optimized for the new compact InfoGuideCard)
                          SizedBox(
                            height: 175,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              children: [
                                InfoGuideCard(
                                  title: "Namaz-e-Janaza ka Tariqa",
                                  subTitle: "Step by step mukammal masail aur azkar ke sath seekhein.",
                                  imageUrl: "https://images.unsplash.com/photo-1542838132-92c53300491e",
                                  onTap: () {},
                                ),
                                InfoGuideCard(
                                  title: "Eidain ki Namaz ka Tariqa",
                                  subTitle: "6 zayd takbeeraat ke sath Eid ki namaz ka mukammal tareeqa.",
                                  imageUrl: "https://images.unsplash.com/photo-1564507592333-c60657eea523",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}