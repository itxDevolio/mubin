import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import '../../domain/entities/verse.dart';
import '../controllers/quran_audio_player_controller.dart';
import '../widgets/verse_bottom_sheet.dart';

class VerseDetailScreen extends ConsumerWidget {
  final String title;
  final List<Verse> verses;

  const VerseDetailScreen({
    super.key,
    required this.title,
    required this.verses,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(quranAudioPlayerControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2E8),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF11221D),
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5DAC2)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: verses.map((verse) {
                  final isAudioPlaying = audioState.playingVerseId == verse.id;

                  return TextSpan(
                    text: '${verse.textArabic} ',
                    style: GoogleFonts.amiriQuran(
                      fontSize: 24,
                      height: 2.3,
                      color: isAudioPlaying
                          ? Colors.teal
                          : const Color(0xFF222222),
                      backgroundColor: isAudioPlaying
                          ? Colors.teal.withAlpha(31)
                          : null,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (context) => VerseBottomSheet(verse: verse),
                        );
                      },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
