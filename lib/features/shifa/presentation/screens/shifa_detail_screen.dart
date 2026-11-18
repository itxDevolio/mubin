import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/shifa_entity.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

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
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final title = isUrdu
        ? widget.dua.titleUr
        : (isPashto
            ? (widget.dua.titlePs.isNotEmpty
                ? widget.dua.titlePs
                : widget.dua.titleUr)
            : widget.dua.titleEn);

    final translation = isUrdu
        ? widget.dua.translationUr
        : (isPashto
            ? (widget.dua.translationPs.isNotEmpty
                ? widget.dua.translationPs
                : widget.dua.translationUr)
            : widget.dua.translationEn);

    final instruction = isUrdu
        ? widget.dua.instructionUr
        : (isPashto
            ? (widget.dua.instructionPs.isNotEmpty
                ? widget.dua.instructionPs
                : widget.dua.instructionUr)
            : widget.dua.instructionEn);

    // Poppins font for English, NotoNastaliq for Urdu/Pashto
    TextStyle bodyStyle = isRtl
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
          title,
          style: TextStyle(
            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
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
                        : Colors.black.withValues(alpha: 0.05),
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
                title: isUrdu
                    ? 'ترجمہ'
                    : (isPashto ? 'ژباړه' : 'Translation'),
                text: translation,
                isRtl: isRtl,
                bodyStyle: bodyStyle,
              ),
              const SizedBox(height: 12),

              // Reference
              Align(
                alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.dua.reference,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Banner Ad center of reference and instruction
              const AdBannerWidget(),
              const SizedBox(height: 20),

              // Instructions
              if (instruction.isNotEmpty)
                _InstructionSection(
                  title: isUrdu
                      ? 'ہدایات'
                      : (isPashto ? 'لارښوونې' : 'Instructions'),
                  text: instruction,
                  isRtl: isRtl,
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
                        color: AppColors.primaryTeal.withValues(alpha: 0.1),
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
      ),
    );
  }
}

class _TranslationSection extends StatelessWidget {
  final String title, text;
  final bool isRtl;
  final TextStyle bodyStyle;

  const _TranslationSection({
    required this.title,
    required this.text,
    required this.isRtl,
    required this.bodyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
            fontWeight: FontWeight.w700,
            color: AppColors.primaryTeal,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          style: bodyStyle,
        ),
      ],
    );
  }
}

class _InstructionSection extends StatelessWidget {
  final String title, text;
  final bool isRtl;

  const _InstructionSection({
    required this.title,
    required this.text,
    required this.isRtl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
            style: isRtl
                ? const TextStyle(
                    fontFamily: 'NotoNastaliqUrdu',
                    fontSize: 12,
                    height: 1.8,
                  )
                : const TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
