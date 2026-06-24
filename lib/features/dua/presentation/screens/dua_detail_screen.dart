import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/dua_entity.dart';

class DuaDetailScreen extends ConsumerWidget {
  final DuaEntity dua;
  const DuaDetailScreen({super.key, required this.dua});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUrdu ? dua.titleUr : dua.titleEn,
          style: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 16) : null,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Arabic Text
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
              ),
              child: Text(
                dua.arabic,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.amiri(
                  fontSize: 28,
                  height: 2.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Translation
            _TranslationSection(
              title: isUrdu ? 'ترجمہ' : 'Translation',
              text: isUrdu ? dua.translationUr : dua.translationEn,
              isUrdu: isUrdu,
            ),
            const SizedBox(height: 24),

            // Reference
            if (dua.reference.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bookmark_border, size: 16, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      '${isUrdu ? "حوالہ: " : "Ref: "}${dua.reference}',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _TranslationSection extends StatelessWidget {
  final String title;
  final String text;
  final bool isUrdu;

  const _TranslationSection({
    required this.title,
    required this.text,
    required this.isUrdu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
          style: isUrdu 
            ? GoogleFonts.notoNastaliqUrdu(fontSize: 18, height: 1.8)
            : GoogleFonts.lora(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }
}
