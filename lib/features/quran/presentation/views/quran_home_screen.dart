import 'package:auraq/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../controllers/quran_progress_controller.dart';
import '../widgets/khatam_progress_card.dart';
import 'mushaf_view_screen.dart';
import 'surah_list_screen.dart';
import 'juz_list_screen.dart';
import 'bookmark_list_screen.dart';
import 'quran_audio_player_screen.dart';

class QuranHomeScreen extends ConsumerWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(quranProgressControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Al-Quran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
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
      body: RefreshIndicator(
        color: AppColors.primaryTeal,
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        onRefresh: () async {
          await ref
              .read(quranProgressControllerProvider.notifier)
              .loadProgress();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Khatam Progress Section
              progressState.when(
                data: (progress) => KhatamProgressCard(
                  lastReadPage: progress.lastReadPage,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MushafViewScreen(
                          initialPage: progress.lastReadPage,
                        ),
                      ),
                    );
                  },
                ),
                loading: () => const _LoadingPlaceholder(),
                error: (err, stack) => _ErrorPlaceholder(
                  error: err.toString(),
                  onRetry: () => ref
                      .read(quranProgressControllerProvider.notifier)
                      .loadProgress(),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Explore Quran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 16),

              // Minimal Grid Menu (All colors synced perfectly with AppColors)
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: constraints.maxWidth > 600 ? 1.0 : 1.35,
                    children: [
                      _buildMinimalMenu(
                        context,
                        title: 'Surah',
                        icon: FlutterIslamicIcons.solidQuran,
                        baseColor: AppColors.lightTeal,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SurahListScreen(),
                          ),
                        ),
                      ),
                      _buildMinimalMenu(
                        context,
                        title: 'Juz',
                        icon: FlutterIslamicIcons.solidQuran2,
                        baseColor: AppColors.lightTeal,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JuzListScreen(),
                          ),
                        ),
                      ),
                      _buildMinimalMenu(
                        context,
                        title: 'Bookmarks',
                        icon: Icons.bookmark_rounded,
                        baseColor: AppColors.lightTeal,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookmarkListScreen(),
                          ),
                        ),
                      ),
                      _buildMinimalMenu(
                        context,
                        title: 'Audio',
                        icon: Icons.audiotrack_rounded,
                        baseColor: AppColors.lightTeal,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuranAudioPlayerScreen(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalMenu(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color baseColor,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          // Dark mode me opacity kam rakhi hai taaki screen chubhni na lage, light mode me soft backdrop bnaya hai
          color: isDark
              ? baseColor.withOpacity(0.12)
              : baseColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? baseColor.withOpacity(0.3)
                : baseColor.withOpacity(0.2),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDark ? baseColor.withOpacity(0.9) : baseColor,
              size: 32,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.3,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primaryTeal),
      ),
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  
  const _ErrorPlaceholder({
    required this.error,
    this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.error.withOpacity(0.8),
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            'Failed to load progress',
            style: TextStyle(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          if (onRetry != null)
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Retry'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryTeal,
              ),
            ),
        ],
      ),
    );
  }
}
