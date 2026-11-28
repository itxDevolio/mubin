import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/dua_entity.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class DuaDetailScreen extends ConsumerWidget {
  final List<DuaEntity> duas;
  final int initialIndex;

  const DuaDetailScreen({
    super.key,
    required this.duas,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu ? 'دعائیں' : (isPashto ? 'دعاګانې' : 'All Duas'),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
          ),
        ),
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: PageView.builder(
          controller: PageController(initialPage: initialIndex),
          itemCount: duas.length,
          itemBuilder: (context, index) {
            return _DuaPageContent(dua: duas[index]);
          },
        ),
      ),
    );
  }
}

class _DuaPageContent extends ConsumerWidget {
  final DuaEntity dua;

  const _DuaPageContent({required this.dua});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final title = isUrdu
        ? dua.titleUr
        : (isPashto
            ? (dua.titlePs.isNotEmpty
                ? dua.titlePs
                : dua.titleUr)
            : dua.titleEn);

    final translation = isUrdu
        ? dua.translationUr
        : (isPashto
            ? (dua.translationPs.isNotEmpty
                ? dua.translationPs
                : dua.translationUr)
            : dua.translationEn);

    TextStyle bodyStyle = isRtl
        ? TextStyle(
            fontFamily: fontFamily,
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
                fontFamily: fontFamily,
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
              dua.arabic,
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
          const AdBannerWidget(),

          // Reference at the bottom like Adhkar & Shifa
          if (dua.reference.isNotEmpty) ...[
            const SizedBox(height: 30),
            Text(
              dua.reference,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.withValues(alpha: 0.5),
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
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
