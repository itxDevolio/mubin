import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/dua_entity.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class DuaDetailScreen extends ConsumerStatefulWidget {
  final List<DuaEntity> duas;
  final int initialIndex;

  const DuaDetailScreen({
    super.key,
    required this.duas,
    required this.initialIndex,
  });

  @override
  ConsumerState<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends ConsumerState<DuaDetailScreen> {
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
          isUrdu ? 'دعائیں' : (isPashto ? 'دعاګانې' : 'All Duas'),
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
            return _DuaPageContent(dua: widget.duas[index]);
          },
        ),
      ),
    );
  }
}

class _DuaPageContent extends StatefulWidget {
  final DuaEntity dua;

  const _DuaPageContent({required this.dua});

  @override
  State<_DuaPageContent> createState() => _DuaPageContentState();
}

class _DuaPageContentState extends State<_DuaPageContent>
    with SingleTickerProviderStateMixin {
  int _count = 3;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
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

              // Arabic Text Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black45 : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: SelectableText(
                  widget.dua.arabic,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 20,
                    height: 2.2,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Translation Section (Borderless, Center aligned, no header)
              _TranslationSection(
                text: translation,
                isRtl: isRtl,
                bodyStyle: bodyStyle,
              ),
              const SizedBox(height: 20),

              // Reference
              if (widget.dua.reference.isNotEmpty)
                Align(
                  alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            widget.dua.reference,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),
              const AdBannerWidget(),
              const SizedBox(height: 30),

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
              const SizedBox(height: 40),
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
