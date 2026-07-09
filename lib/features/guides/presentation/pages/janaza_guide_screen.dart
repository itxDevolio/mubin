import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import 'janaza_detail_screen.dart';

class JanazaGuideScreen extends ConsumerWidget {
  const JanazaGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
"Funeral Prayer (Janaza)",

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             "Select Category",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Supplications differ slightly for adults and children.",

            ),
            const SizedBox(height: 40),
            _SelectionCard(
              title:  "For Adults",
              subtitle: "Janaza prayer for men and women",
              icons: const [FlutterIslamicIcons.muslim, FlutterIslamicIcons.muslimah],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JanazaDetailScreen(isAdult: true),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _SelectionCard(
              title:  "For Children",
              subtitle: "Janaza prayer for boys and girls",
              icons: const [FlutterIslamicIcons.muslim2, FlutterIslamicIcons.muslimah2],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JanazaDetailScreen(isAdult: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<IconData> icons;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.subtitle,
    required this.icons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.black45 : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          textDirection:TextDirection.ltr,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icons[0], color: AppColors.primaryTeal, size: 26),
                ),
                Positioned(
                  right: -10,
                  bottom: -5,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade900 : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                      ],
                    ),
                    child: Icon(icons[1], color: AppColors.primaryTeal, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style:TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
          Icons.chevron_right_rounded,
              color: AppColors.primaryTeal.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
