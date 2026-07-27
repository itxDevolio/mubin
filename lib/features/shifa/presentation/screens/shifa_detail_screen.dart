import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/shifa_entity.dart';

class ShifaDetailScreen extends ConsumerStatefulWidget {
  final ShifaEntity dua;

  const ShifaDetailScreen({super.key, required this.dua});

  @override
  ConsumerState<ShifaDetailScreen> createState() => _ShifaDetailScreenState();
}

class _ShifaDetailScreenState extends ConsumerState<ShifaDetailScreen>
    with SingleTickerProviderStateMixin {
  late int _count;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _count = widget.dua.targetCount;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _decrement() {
    if (_count > 0) {
      _animationController.forward().then(
        (_) => _animationController.reverse(),
      );
      HapticFeedback.mediumImpact();
      setState(() {
        _count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Poppins font for English, NotoNastaliq for Urdu
    TextStyle bodyStyle = isUrdu
        ? TextStyle(
            fontFamily: 'NotoNastaliqUrdu',
            fontSize: 14,
            height: 2.0,
            color: isDark ? Colors.white70 : Colors.black87,
          )
        : TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            height: 1.6,
            color: isDark ? Colors.white70 : Colors.black87,
          );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu ? widget.dua.titleUr : widget.dua.titleEn,
          style: isUrdu
              ? const TextStyle(fontFamily: 'NotoNastaliqUrdu', fontWeight: FontWeight.bold)
              : const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Arabic Text
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? Colors.black45 : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? Colors.white10
                      : Colors.black.withOpacity(0.05),
                ),
              ),
              child: Text(
                widget.dua.arabic,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 22,
                  height: 2.2,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Translation
            _TranslationSection(
              title:  'Translation',
              text: isUrdu
                  ? widget.dua.translationUr
                  : widget.dua.translationEn,
              isUrdu: isUrdu,
              bodyStyle: bodyStyle,
            ),
            const SizedBox(height: 12),

            // Reference (Always Left)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Ref: ${widget.dua.reference}',
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Instructions
            if ((isUrdu && widget.dua.instructionUr.isNotEmpty) ||
                (!isUrdu && widget.dua.instructionEn.isNotEmpty))
              _InstructionSection(
                text: isUrdu
                    ? widget.dua.instructionUr
                    : widget.dua.instructionEn,
                isUrdu: isUrdu,
              ),

            const SizedBox(height: 40),

            // Counter
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: _decrement,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryTeal.withOpacity(0.1),
                      border: Border.all(
                        color: AppColors.primaryTeal,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: _count == 0
                          ? const Icon(
                              Icons.check_circle_rounded,
                              size: 50,
                              color: Colors.green,
                            )
                          : Text(
                              '$_count',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryTeal,
                              ),
                            ),
                    ),
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

class _TranslationSection extends StatelessWidget {
  final String title, text;
  final bool isUrdu;
  final TextStyle bodyStyle;

  const _TranslationSection({
    required this.title,
    required this.text,
    required this.isUrdu,
    required this.bodyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: AppColors.primaryTeal,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
          style: bodyStyle,
        ),
      ],
    );
  }
}

class _InstructionSection extends StatelessWidget {
  final String text;
  final bool isUrdu;

  const _InstructionSection({required this.text, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Text(
            'Instructions',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: isUrdu
                ? const TextStyle(fontFamily: 'NotoNastaliqUrdu', fontSize: 12)
                : const TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
