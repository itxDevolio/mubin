import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../../../core/services/ad_helper.dart';
import '../../../../core/widgets/ad_banner_widget.dart';
import 'janaza_detail_screen.dart';

class JanazaGuideScreen extends ConsumerStatefulWidget {
  const JanazaGuideScreen({super.key});

  @override
  ConsumerState<JanazaGuideScreen> createState() => _JanazaGuideScreenState();
}

class _JanazaGuideScreenState extends ConsumerState<JanazaGuideScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdHelper.maybeShowGuideAd(
        context,
        onContinue: () {},
        onSkip: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu
              ? "نمازِ جنازہ"
              : (isPashto ? "د جنازې لمونځ" : "Funeral Prayer (Janaza)"),
          style: TextStyle(
            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
          ),
        ),
      ),
      body: Directionality(
        textDirection: textDirection,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              _SelectionCard(
                title: isUrdu
                    ? "بالغ افراد کے لیے"
                    : (isPashto ? "د لویانو لپاره" : "For Adults"),
                subtitle: isUrdu
                    ? "مرد اور عورت کی نمازِ جنازہ کا طریقہ"
                    : (isPashto
                          ? "د نارینه وو او ښځو د جنازې لمانځه طريقه"
                          : "Janaza prayer for men and women"),
                isRtl: isRtl,
                icons: const [
                  FlutterIslamicIcons.muslim,
                  FlutterIslamicIcons.muslimah,
                ],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const JanazaDetailScreen(isAdult: true),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SelectionCard(
                title: isUrdu
                    ? "نابالغ بچوں کے لیے"
                    : (isPashto ? "د ماشومانو لپاره" : "For Children"),
                subtitle: isUrdu
                    ? "لڑکے اور لڑکی کی نمازِ جنازہ کا طریقہ"
                    : (isPashto
                          ? "د هلکانو او نجونو د جنازې لمانځه طريقه"
                          : "Janaza prayer for boys and girls"),
                isRtl: isRtl,
                icons: const [
                  FlutterIslamicIcons.muslim2,
                  FlutterIslamicIcons.muslimah2,
                ],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const JanazaDetailScreen(isAdult: false),
                  ),
                ),
              ),
              const Spacer(),
              const AdBannerWidget(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isRtl;
  final List<IconData> icons;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.subtitle,
    required this.isRtl,
    required this.icons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.black45 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              textDirection: textDirection,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: textDirection,
                    children: [
                      Icon(icons[0], color: AppColors.primaryTeal, size: 22),
                      const SizedBox(width: 4),
                      Icon(icons[1], color: AppColors.primaryTeal, size: 22),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: isRtl ? 15 : 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                          fontSize: isRtl ? 11 : 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                   Icons.chevron_right,
                  color: AppColors.primaryTeal.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
