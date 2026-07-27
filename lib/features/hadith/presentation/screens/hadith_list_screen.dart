import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/hadith_notifier.dart';
import 'hadith_detail_screen.dart';

class HadithListScreen extends ConsumerStatefulWidget {
  final String bookSlug;
  final String chapterNumber;
  final String chapterName;

  const HadithListScreen({
    super.key,
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
  });

  @override
  ConsumerState<HadithListScreen> createState() => _HadithListScreenState();
}

class _HadithListScreenState extends ConsumerState<HadithListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(hadithProvider.notifier)
          .fetchHadiths(widget.bookSlug, widget.chapterNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hadithProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.chapterName,
          style: TextStyle(
            fontSize: 16,
            fontFamily: isUrdu ? 'NotoNastaliqUrdu' : null,
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
      ),
      body: state is HadithLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryTeal),
            )
          : state is HadithError
          ? Center(child: Text("Error: ${state.message}"))
          : state is HadithLoaded
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: state.hadiths.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final hadith = state.hadiths[index];
                final String displayContent = isUrdu
                    ? hadith.urduText
                    : hadith.englishText;

                return InkWell(
                  onTap: () {
                    hapticFeedBack();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HadithDetailScreen(hadith: hadith),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 30 : 10),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: isUrdu
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (!isUrdu) ...[
                              _buildHadithBadge(hadith.hadithNumber),
                              const Spacer(),
                            ],

                            if (hadith.status.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white10
                                      : Colors.black.withAlpha(5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  hadith.status,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black54,
                                  ),
                                ),
                              ),

                            if (isUrdu) ...[
                              const Spacer(),
                              _buildHadithBadge(hadith.hadithNumber),
                            ] else ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColors.primaryTeal,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          hadith.arabicText,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 20,
                            height: 1.8,
                            color: isDark
                                ? Colors.white
                                : AppColors.textPrimaryLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          displayContent,
                          style: isUrdu
                              ? TextStyle(
                                  fontFamily: 'NotoNastaliqUrdu',
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.white70
                                      : AppColors.textSecondaryLight,
                                  height: 1.5,
                                )
                              : TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.white70
                                      : AppColors.textSecondaryLight,
                                  height: 1.4,
                                ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const SizedBox(),
    );
  }

  Widget _buildHadithBadge(String number) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryTeal.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryTeal.withAlpha(50)),
      ),
      child: Text(
        "$number",
        style: const TextStyle(
          color: AppColors.primaryTeal,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
