import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/dhikr_entity.dart';
import '../controller/adhkar_provider.dart';

class AdhkarListScreen extends ConsumerStatefulWidget {
  final List<DhikrEntity> dhikrList;
  final String title;

  const AdhkarListScreen({super.key, required this.dhikrList, required this.title});

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

    return PageView.builder(
      controller: _pageController,
      itemCount: widget.dhikrList.length,
      onPageChanged: (index) => setState(() => _currentIndex = index),
      itemBuilder: (context, index) {
        final dhikr = widget.dhikrList[index];
        final currentCount = ref.watch(adhkarCountProvider(dhikr.id));
        final remaining = (dhikr.targetCount - currentCount).clamp(0, dhikr.targetCount);
        final isCompleted = remaining == 0;

        return Scaffold(
          // یہاں سے کلر چینج لاجک ہٹا دی ہے، اب ہمیشہ بیک گراؤنڈ تھیم کے مطابق رہے گا
          backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          appBar: AppBar(
            title: Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text("${_currentIndex + 1}/${widget.dhikrList.length}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryTeal)),
                ),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              if (remaining > 0) {
                hapticFeedBack();
                ref.read(adhkarCountProvider(dhikr.id).notifier).increment();
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if ((isUrdu ? dhikr.fazilatUrdu : dhikr.fazilatEnglish) != null)
                    _buildTag(isUrdu ? dhikr.fazilatUrdu! : dhikr.fazilatEnglish!, isUrdu),

                  const SizedBox(height: 40),
                  Text(dhikr.arabic, style: GoogleFonts.amiriQuran(fontSize: 28, color: AppColors.primaryTeal), textAlign: TextAlign.center, textDirection: TextDirection.rtl),

                  const SizedBox(height: 30),
                  Text(
                    isUrdu ? dhikr.urdu : dhikr.english,
                    style: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 15, color: isDark ? Colors.white70 : Colors.grey[700], height: 2.0) : TextStyle(fontSize: 14, color: isDark ? Colors.white60 : Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),
                  isCompleted
                      ? const Icon(Icons.check, size: 56, color: AppColors.primaryTeal)
                      : Text(
                    "$remaining",
                    style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w300, color: AppColors.primaryTeal),
                  ),

                  const SizedBox(height: 50),
                  if (dhikr.reference != null)
                    Text(dhikr.reference!, style: TextStyle(fontSize: 10, color: Colors.grey.withValues(alpha: 0.5), letterSpacing: 1.2)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTag(String text, bool isUrdu) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: AppColors.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 11, color: AppColors.primaryTeal) : TextStyle(fontSize: 11, color: AppColors.primaryTeal, fontStyle: FontStyle.italic)),
    );
  }
}