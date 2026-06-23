import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/settings_controller.dart';
import '../../domain/entities/shifa_entity.dart';

class ShifaDetailScreen extends ConsumerStatefulWidget {
  final ShifaEntity dua;
  const ShifaDetailScreen({super.key, required this.dua});

  @override
  ConsumerState<ShifaDetailScreen> createState() => _ShifaDetailScreenState();
}

class _ShifaDetailScreenState extends ConsumerState<ShifaDetailScreen> {
  int _count = 0;

  void _increment() {
    if (_count < widget.dua.targetCount) {
      setState(() {
        _count++;
      });
      if (_count == widget.dua.targetCount) {
        final isUrdu = ref.read(settingsControllerProvider).language == 'ur';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isUrdu ? 'مکمل ہو گیا!' : 'Completed!',
              style: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 14) : null,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUrdu ? widget.dua.titleUr : widget.dua.titleEn,
          style: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 16) : null,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
            tooltip: isUrdu ? 'دوبارہ شروع کریں' : 'Reset',
          ),
        ],
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
                widget.dua.arabic,
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

            // Translation (Conditional based on language)
            _TranslationSection(
              title: isUrdu ? 'ترجمہ' : 'Translation',
              text: isUrdu ? widget.dua.translationUr : widget.dua.translationEn,
              isUrdu: isUrdu,
            ),
            const SizedBox(height: 24),

            // Instructions
            if ((isUrdu && widget.dua.instructionUr.isNotEmpty) || (!isUrdu && widget.dua.instructionEn.isNotEmpty))
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isUrdu) const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          isUrdu ? 'ہدایات' : 'Instructions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                            fontFamily: isUrdu ? GoogleFonts.notoNastaliqUrdu().fontFamily : null,
                          ),
                        ),
                        if (isUrdu) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                        ],
                      ],
                    ),
                    const Divider(color: Colors.amber),
                    Text(
                      isUrdu ? widget.dua.instructionUr : widget.dua.instructionEn,
                      textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
                      style: isUrdu 
                        ? GoogleFonts.notoNastaliqUrdu(fontSize: 16, height: 1.8)
                        : const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 40),

            // Counter Section
            Column(
              children: [
                Text(
                  '$_count / ${widget.dua.targetCount}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _increment,
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.touch_app,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isUrdu ? 'گننے کے لیے دبائیں' : 'Tap to Count',
                  style: isUrdu 
                    ? GoogleFonts.notoNastaliqUrdu(color: Colors.grey, fontSize: 14)
                    : const TextStyle(color: Colors.grey),
                ),
              ],
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
