import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/ad_helper.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/dhikr_entity.dart';
import '../controller/adhkar_provider.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class AdhkarListScreen extends ConsumerStatefulWidget {
  final List<DhikrEntity> dhikrList;
  final String title;

  const AdhkarListScreen({
    super.key,
    required this.dhikrList,
    required this.title,
  });

  @override
  ConsumerState<AdhkarListScreen> createState() => _AdhkarListScreenState();
}

class _AdhkarListScreenState extends ConsumerState<AdhkarListScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';
    final bool isPashto = settings.language == 'ps';
    final bool isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.dhikrList.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          final dhikr = widget.dhikrList[index];
          final currentCount = ref.watch(adhkarCountProvider(dhikr.id));
          final remaining = (dhikr.targetCount - currentCount).clamp(
            0,
            dhikr.targetCount,
          );
          final isCompleted = remaining == 0;
          final translationText = isUrdu
              ? dhikr.urdu
              : (isPashto ? (dhikr.pashto ?? dhikr.english) : dhikr.english);
          final bool showTranslation = translationText.isNotEmpty;

          final bool isMorningEvening =
              widget.title.contains('Morning') ||
              widget.title.contains('Evening') ||
              widget.title.contains('صبح') ||
              widget.title.contains('شام') ||
              widget.title.contains('سهار') ||
              widget.title.contains('ماښام');
          final bool isSleeping =
              widget.title.contains('Sleeping') ||
              widget.title.contains('سونے') ||
              widget.title.contains('خوب');

          // 1-based positions: 5, 10, 15, 17 for Morning/Evening; 5, 10 for Sleeping
          final bool shouldShowAd =
              (isMorningEvening && [5, 10, 15, 17].contains(index + 1)) ||
              (isSleeping && [5, 10].contains(index + 1));

          final fazilatText = isUrdu
              ? dhikr.fazilatUrdu
              : (isPashto ? (dhikr.fazilatPashto ?? dhikr.fazilatEnglish) : dhikr.fazilatEnglish);

          return Scaffold(
            backgroundColor: isDark
                ? AppColors.backgroundDark
                : AppColors.backgroundLight,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppBar(
                  title: Text(
                    widget.title,
                    textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      fontSize: isRtl ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: fontFamily,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          "${_currentIndex + 1}/${widget.dhikrList.length}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTeal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                if (remaining > 0) {
                  hapticFeedBack();
                  ref.read(adhkarCountProvider(dhikr.id).notifier).increment();
                  if (remaining == 1) {
                    if (_currentIndex == widget.dhikrList.length - 1) {
                      AdHelper.showInterstitialWithLoading(context, onContinue: () {}, onSkip: () {});
                    } else if (_currentIndex < widget.dhikrList.length - 1) {
                      Future.delayed(const Duration(milliseconds: 350), () {
                        if (mounted) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      });
                    }
                  }
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (shouldShowAd) ...[
                        const AdBannerWidget(),
                        const SizedBox(height: 20),
                      ],
                      if (fazilatText != null)
                        _buildTag(fazilatText, isRtl, fontFamily),

                      const SizedBox(height: 40),

                      // Arabic Text
                      Text(
                        dhikr.arabic,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 22,
                          height: 2,
                          color: AppColors.primaryTeal,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),

                      if (showTranslation) ...[
                        const SizedBox(height: 30),

                        // Translation Text
                        Text(
                          translationText,
                          style: isRtl
                              ? TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 13.5,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF555555),
                                  height: 2.2,
                                )
                              : TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.white60
                                      : const Color(0xFF757575),
                                ),
                          textAlign: isRtl ? TextAlign.right : TextAlign.center,
                          textDirection: isRtl
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                        ),
                      ],

                      const SizedBox(height: 50),

                      // Centered Circle for Count/Tick
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? AppColors.primaryTeal.withValues(alpha: 0.1)
                              : Colors.transparent,
                          border: Border.all(
                            color: AppColors.primaryTeal.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                size: 40,
                                color: AppColors.primaryTeal,
                              )
                            : Text(
                                "$remaining",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.primaryTeal,
                                ),
                              ),
                      ),

                      const SizedBox(height: 50),

                      if (dhikr.reference != null)
                        Text(
                          dhikr.reference!,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.withValues(alpha: 0.5),
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTag(String text, bool isRtl, String fontFamily) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        textAlign: isRtl ? TextAlign.right : TextAlign.center,
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        style: isRtl
            ? TextStyle(
                fontFamily: fontFamily,
                fontSize: 11,
                color: AppColors.primaryTeal,
                height: 1.6,
              )
            : const TextStyle(
                fontSize: 11,
                color: AppColors.primaryTeal,
                fontStyle: FontStyle.italic,
              ),
      ),
    );
  }
}
