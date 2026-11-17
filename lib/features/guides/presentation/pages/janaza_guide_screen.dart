import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import 'janaza_detail_screen.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

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
          isUrdu ? "نمازِ جنازہ" : "Funeral Prayer (Janaza)",
          style: isUrdu
              ? const TextStyle(
                  fontFamily: 'NotoNastaliqUrdu',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )
              : const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          crossAxisAlignment:
              isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isUrdu ? "زمرہ منتخب کریں" : "Select Category",
              textAlign: isUrdu ? TextAlign.right : TextAlign.left,
              style: isUrdu
                  ? const TextStyle(
                      fontFamily: 'NotoNastaliqUrdu',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )
                  : const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isUrdu
                  ? "بالغ افراد اور نابالغ بچوں کے لیے نمازِ جنازہ کی دعائیں مختلف ہوتی ہیں۔"
                  : "Supplications differ slightly for adults and children.",
              textAlign: isUrdu ? TextAlign.right : TextAlign.left,
              style: isUrdu
                  ? TextStyle(
                      fontFamily: 'NotoNastaliqUrdu',
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.8,
                    )
                  : TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            _SelectionCard(
              title: isUrdu ? "بالغ افراد کے لیے" : "For Adults",
              subtitle: isUrdu
                  ? "مرد اور عورت کی نمازِ جنازہ کا طریقہ"
                  : "Janaza prayer for men and women",
              isUrdu: isUrdu,
              icons: const [
                FlutterIslamicIcons.muslim,
                FlutterIslamicIcons.muslimah
              ],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JanazaDetailScreen(isAdult: true),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _SelectionCard(
              title: isUrdu ? "نابالغ بچوں کے لیے" : "For Children",
              subtitle: isUrdu
                  ? "لڑکے اور لڑکی کی نمازِ جنازہ کا طریقہ"
                  : "Janaza prayer for boys and girls",
              isUrdu: isUrdu,
              icons: const [
                FlutterIslamicIcons.muslim2,
                FlutterIslamicIcons.muslimah2
              ],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JanazaDetailScreen(isAdult: false),
                ),
              ),
            ),
            const Spacer(),
            const AdBannerWidget(),
            const SizedBox(height: 10),
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
  final bool isUrdu;

  const _SelectionCard({
    required this.title,
    required this.subtitle,
    required this.icons,
    required this.onTap,
    this.isUrdu = false,
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
        child: isUrdu
            ? Row(
                children: [
                  Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.primaryTeal.withOpacity(0.4),
                  ),
                  const SizedBox(width: 8),
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
                        left: -10,
                        bottom: -5,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey.shade900 : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Icon(icons[1], color: AppColors.primaryTeal, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'NotoNastaliqUrdu',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'NotoNastaliqUrdu',
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
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
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Icon(icons[1], color: AppColors.primaryTeal, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
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
