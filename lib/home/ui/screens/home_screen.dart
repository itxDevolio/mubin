import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:auraq/features/hadith/presentation/screens/books_screen.dart';
import 'package:auraq/features/quran/presentation/views/quran_home_screen.dart';
import 'package:auraq/features/settings/presentation/settings_screen.dart';
import 'package:auraq/home/controllers/prayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/feature_card.dart';
import '../widgets/guide_card.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/prayer_card.dart';

// FIX: ConsumerWidget ko ConsumerStatefulWidget se replace kiya kyunki isme state (_currentDate) use ho rahi hai
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Minimal Header with Settings button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserProfileWidget(
                    name: "Khadija",
                    pUrl:
                    "https://media.gettyimages.com/id/956842252/photo/portrait-of-a-confident-muslim-girl.jpg?s=170667a&w=gi&k=20&c=DonQKYjWv-OgPjWQxPpMK1mljHEfihmiZow2iYnpdGg=",
                  ),
                  // Settings button
                  IconButton(
                    onPressed: () {
                      hapticFeedBack();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: AppColors.primaryTeal,
                      size: 24,
                    ),
                    tooltip: "Settings",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryTeal,
                onRefresh: () async {
                  setState(() {
                    _currentDate = DateTime.now();
                  });
                  ref.invalidate(locationProvider);
                  await ref.refresh(prayerTimesProvider(_currentDate).future);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrayerCard(date: _currentDate),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FeatureCard(
                                  title: "Quran",
                                  icon: FlutterIslamicIcons.quran,
                                  onTap: () {
                                    hapticFeedBack();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const QuranHomeScreen(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Hadith",
                                  icon: FlutterIslamicIcons.quran2,
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => BooksScreen(),));
                                  },
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Adhkar",
                                  icon: FlutterIslamicIcons.tasbihHand,
                                  onTap: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FeatureCard(
                                  title: "Shifa",
                                  icon: FlutterIslamicIcons.prayingPerson,
                                  onTap: () {},
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Qibla",
                                  icon: FlutterIslamicIcons.qibla2,
                                  onTap: () {},
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Duas",
                                  icon: FlutterIslamicIcons.prayer,
                                  onTap: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "Islamic Guides",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 175,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                children: [
                                  InfoGuideCard(
                                    title: "Namaz-e-Janaza ka Tariqa",
                                    subTitle:
                                    "Step by step mukammal masail aur azkar ke sath seekhein.",
                                    imageUrl:
                                    "https://images.unsplash.com/photo-1542838132-92c53300491e",
                                    onTap: () {},
                                  ),
                                  InfoGuideCard(
                                    title: "Eidain ki Namaz ka Tariqa",
                                    subTitle:
                                    "6 zayd takbeeraat ke sath Eid ki namaz ka mukammal tareeqa.",
                                    imageUrl:
                                    "https://images.unsplash.com/photo-1564507592333-c60657eea523",
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
            ),
          ],
        ),
      ),
    );
  }
}
