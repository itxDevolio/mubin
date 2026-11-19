import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/shifa_entity.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class ShifaDetailScreen extends ConsumerStatefulWidget {
  final List<ShifaEntity> duas;
  final int initialIndex;

  const ShifaDetailScreen({
    super.key,
    required this.duas,
    required this.initialIndex,
  });

  @override
  ConsumerState<ShifaDetailScreen> createState() => _ShifaDetailScreenState();
}

class _ShifaDetailScreenState extends ConsumerState<ShifaDetailScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu
              ? 'شفا اور علاج'
              : (isPashto ? 'شفا او درملنه' : 'Shifa & Healing'),
          style: TextStyle(
            fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
          ),
        ),
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.duas.length,
          itemBuilder: (context, index) {
            return _ShifaPageContent(dua: widget.duas[index]);
          },
        ),
      ),
    );
  }
}

class _ShifaPageContent extends StatefulWidget {
  final ShifaEntity dua;

  const _ShifaPageContent({required this.dua});

  @override
  State<_ShifaPageContent> createState() => _ShifaPageContentState();
}

class _ShifaPageContentState extends State<_ShifaPageContent>
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
    return Consumer(
      builder: (context, ref, _) {
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

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title banner
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primaryTeal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

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
                child: SelectableText(
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

              // Translation (Borderless, Center aligned, no header)
              _TranslationSection(
                text: translation,
                isRtl: isRtl,
                bodyStyle: bodyStyle,
              ),
              const SizedBox(height: 16),

              // Instructions (Golden text color, center aligned, no header)
              if (instruction.isNotEmpty) ...[
                _InstructionSection(
                  text: instruction,
                  isRtl: isRtl,
                ),
                const SizedBox(height: 30),
              ],

              // Banner Ad above the counter
              const AdBannerWidget(),
              const SizedBox(height: 30),

              // Counter (styled like Adhkar)
              Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: GestureDetector(
                    onTap: _decrement,
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _count == 0
                            ? AppColors.primaryTeal.withValues(alpha: 0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: AppColors.primaryTeal.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: _count == 0
                          ? const Icon(
                              Icons.check,
                              size: 40,
                              color: AppColors.primaryTeal,
                            )
                          : Text(
                              '$_count',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                color: AppColors.primaryTeal,
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              // Reference at the bottom like Adhkar
              if (widget.dua.reference.isNotEmpty) ...[
                const SizedBox(height: 30),
                Text(
                  widget.dua.reference,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.withValues(alpha: 0.5),
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

class _TranslationSection extends StatelessWidget {
  final String text;
  final bool isRtl;
  final TextStyle bodyStyle;

  const _TranslationSection({
    required this.text,
    required this.isRtl,
    required this.bodyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      textAlign: TextAlign.center,
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      style: bodyStyle,
    );
  }
}

class _InstructionSection extends StatelessWidget {
  final String text;
  final bool isRtl;

  const _InstructionSection({
    required this.text,
    required this.isRtl,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      textAlign: TextAlign.center,
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      style: isRtl
          ? const TextStyle(
              fontFamily: 'NotoNastaliqUrdu',
              fontSize: 13,
              height: 1.9,
              color: AppColors.accentGold,
              fontWeight: FontWeight.w600,
            )
          : const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              height: 1.6,
              color: AppColors.accentGold,
              fontWeight: FontWeight.w600,
            ),
    );
  }
}
