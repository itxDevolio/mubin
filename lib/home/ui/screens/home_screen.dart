import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/notification_service.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:mubin/features/adhkar/presentation/screens/adhkar_home_screen.dart';
import 'package:mubin/features/hadith/presentation/screens/books_screen.dart';
import 'package:mubin/features/shifa/presentation/screens/shifa_list_screen.dart';
import 'package:mubin/features/dua/presentation/screens/dua_list_screen.dart';
import 'package:mubin/features/quran/presentation/views/quran_home_screen.dart';
import 'package:mubin/features/settings/presentation/settings_screen.dart';
import 'package:mubin/home/controllers/prayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/qibla/presentation/pages/qibla_page.dart';
import '../../../features/guides/presentation/pages/istikhara_guide_screen.dart';
import '../../../features/guides/presentation/pages/janaza_guide_screen.dart';
import '../../../features/guides/presentation/pages/qasar_guide_screen.dart';
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

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh current time and reschedule notifications when app is resumed
      setState(() {
        _currentDate = DateTime.now();
      });
      NotificationService().scheduleAllNotifications();
    }
  }

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
                  const UserProfileWidget(),
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
                  
                  // Reschedule notifications on refresh
                  await NotificationService().scheduleAllNotifications();
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BooksScreen(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Adhkar",
                                  icon: FlutterIslamicIcons.tasbihHand,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdhkarHomeScreen(),
                                      ),
                                    );
                                  },
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
                                  onTap: () {
                                    hapticFeedBack();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ShifaListScreen(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Qibla",
                                  icon: FlutterIslamicIcons.qibla2,
                                  onTap: () {// Example navigation
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  QiblaPage()));},
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: "Duas",
                                  icon: FlutterIslamicIcons.prayer,
                                  onTap: () {
                                    hapticFeedBack();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DuaListScreen(),
                                      ),
                                    );
                                  },
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
                                    title: "Funeral Prayer Guide",
                                    subTitle:
                                        "Step-by-step authentic method and supplications.",
                                    imageUrl:
                                        "assets/app_logos/funeral.png",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const JanazaGuideScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  InfoGuideCard(
                                    title: "Istikhara Prayer Guide",
                                    subTitle:
                                        "Seek Allah's counsel for your important decisions.",
                                    imageUrl:
                                        "assets/app_logos/istikhara.png",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const IstikharaGuideScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  InfoGuideCard(
                                    title: "Traveler's Prayer ",
                                    subTitle:
                                        "Guidelines and method for shortening prayers during travel.",
                                    imageUrl:
                                        "assets/app_logos/qasar.png",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QasarGuideScreen(),
                                        ),
                                      );
                                    },
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
