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
import '../widgets/feature_card.dart';
import '../widgets/guide_card.dart';
import '../widgets/user_profile_widget.dart';
import '../widgets/prayer_card.dart';
import '../../../core/widgets/ad_banner_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
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
      setState(() {
        _currentDate = DateTime.now();
      });
      NotificationService().scheduleAllNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final bool isUrdu = settings.language == 'ur';
    final bool isPashto = settings.language == 'ps';
    final bool isRtl = isUrdu || isPashto;

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
                    tooltip: isRtl ? "ترتیبات" : "Settings",
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
                          crossAxisAlignment: isRtl
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection: isRtl
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                FeatureCard(
                                  title: isUrdu
                                      ? "قرآن"
                                      : (isPashto ? "قرآن کریم" : "Quran"),
                                  icon: FlutterIslamicIcons.quran,
                                  isRtl: isRtl,
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
                                  title: isUrdu
                                      ? "حدیث"
                                      : (isPashto ? "حدیث" : "Hadith"),
                                  icon: FlutterIslamicIcons.quran2,
                                  isRtl: isRtl,
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
                                  title: isUrdu
                                      ? "اذکار"
                                      : (isPashto ? "اذکار" : "Adhkar"),
                                  icon: FlutterIslamicIcons.tasbihHand,
                                  isRtl: isRtl,
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
                              textDirection: isRtl
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                FeatureCard(
                                  title: isUrdu
                                      ? "شفاء"
                                      : (isPashto ? "شفا" : "Shifa"),
                                  icon: FlutterIslamicIcons.prayingPerson,
                                  isRtl: isRtl,
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
                                  title: isUrdu
                                      ? "قبلہ"
                                      : (isPashto ? "قبله" : "Qibla"),
                                  icon: FlutterIslamicIcons.qibla2,
                                  isRtl: isRtl,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QiblaPage(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                FeatureCard(
                                  title: isUrdu
                                      ? "دعائیں"
                                      : (isPashto ? "دعاء ګانې" : "Duas"),
                                  icon: FlutterIslamicIcons.prayer,
                                  isRtl: isRtl,
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

                            const SizedBox(height: 12),
                            Directionality(
                              textDirection: isRtl
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: SizedBox(
                                height: 175,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: [
                                    InfoGuideCard(
                                      title: isUrdu
                                          ? "نمازِ جنازہ کا طریقہ"
                                          : (isPashto
                                                ? "د جنازې لمانځه طریقہ"
                                                : "Funeral Prayer Guide"),
                                      subTitle: isUrdu
                                          ? "نمازِ جنازہ کا مسنون اور مستند طریقہ"
                                          : (isPashto
                                                ? "•  د جنازې د لمانځه مسنونه طریقه"
                                                : "Step-by-step authentic method and supplications."),
                                      imageUrl: "assets/app_logos/funeral.png",
                                      isRtl: isRtl,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const JanazaGuideScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    InfoGuideCard(
                                      title: isUrdu
                                          ? "استخارہ کا طریقہ"
                                          : (isPashto
                                                ? "د استخارې لمانځه طریقہ"
                                                : "Istikhara Prayer Guide"),
                                      subTitle: isUrdu
                                          ? "اہم فیصلوں میں اللہ سے رہنمائی حاصل کریں"
                                          : (isPashto
                                                ? "په مهمو پریکړو کې له الله څخه لارښوونه وغواړئ"
                                                : "Seek Allah's counsel for your important decisions."),
                                      imageUrl:
                                          "assets/app_logos/istikhara.png",
                                      isRtl: isRtl,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const IstikharaGuideScreen(),
                                          ),
                                        );
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const AdBannerWidget(),
                            const SizedBox(height: 10),
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
