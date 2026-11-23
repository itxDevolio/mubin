import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/utils/quran_utils.dart';
import 'package:mubin/core/services/settings_controller.dart';
import '../../../../services/quran_db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mushaf_view_screen.dart';

class JuzListScreen extends ConsumerStatefulWidget {
  const JuzListScreen({super.key});

  @override
  ConsumerState<JuzListScreen> createState() => _JuzListScreenState();
}

class _JuzListScreenState extends ConsumerState<JuzListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(settingsControllerProvider).language;
    final isUrdu = lang == 'ur';
    final isPashto = lang == 'ps';
    final isRtl = isUrdu || isPashto;
    final String textFont = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredJuz = List.generate(30, (i) => i + 1).where((j) {
      final name = isRtl
          ? QuranUtils.juzNamesArabic[j - 1]
          : QuranUtils.juzNamesEnglish[j - 1];
      return name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          j.toString() == _searchQuery;
    }).toList();

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isUrdu
              ? 'پاروں کی فہرست'
              : (isPashto ? 'پارې' : 'Juz / Para List'),
          style: TextStyle(
            fontFamily: textFont,
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
              cursorColor: AppColors.primaryTeal,
              style: TextStyle(
                fontFamily: textFont,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: isUrdu
                    ? 'پارہ تلاش کریں'
                    : (isPashto ? 'پاره لټول' : 'Search Juz'),
                hintStyle: TextStyle(
                  fontFamily: textFont,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryTeal,
                  size: 22,
                ),
                filled: true,
                fillColor: isDark
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primaryTeal,
                    width: 1.2,
                  ),
                ),
              ),
            ),
          ),

          // Juz List Section
          Expanded(
            child: filteredJuz.isEmpty && _searchQuery.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          isUrdu
                              ? "'$_searchQuery' کے نام سے کوئی پارہ نہیں ملا"
                              : (isPashto
                                  ? "د '$_searchQuery' په نوم هیڅ پاره ونه موندل شوه"
                                  : 'No Juz found for "$_searchQuery"'),
                          style: TextStyle(
                            fontFamily: textFont,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : filteredJuz.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              color: AppColors.primaryTeal,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isUrdu
                                  ? 'لوڈنگ...'
                                  : (isPashto ? 'باریږي...' : 'Loading...'),
                              style: TextStyle(
                                fontFamily: textFont,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredJuz.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                          height: 1,
                          thickness: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final juzNumber = filteredJuz[index];

                          final juzEnglishName =
                              QuranUtils.juzNamesEnglish[juzNumber - 1];
                          final juzArabicName =
                              QuranUtils.juzNamesArabic[juzNumber - 1];

                          return InkWell(
                            onTap: () {
                              const juzPages = [
                                1, 20, 38, 56, 74, 92, 110, 128, 146, 164,
                                182, 200, 218, 236, 254, 272, 290, 308,
                                326, 344, 362, 380, 398, 416, 434, 452,
                                470, 488, 506, 524
                              ];
                              final calculatedPage = juzPages[juzNumber - 1];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MushafViewScreen(
                                    initialPage: calculatedPage,
                                    shouldUpdateProgress: false,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 4.0,
                              ),
                              child: Row(
                                textDirection: isRtl
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  // Indexed Number Badge
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.primaryTeal.withValues(
                                              alpha: 0.12,
                                            )
                                          : AppColors.primaryTeal.withValues(
                                              alpha: 0.08,
                                            ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColors.primaryTeal.withValues(
                                          alpha: 0.2,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$juzNumber',
                                      style: const TextStyle(
                                        color: AppColors.primaryTeal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Text Content Area
                                  Expanded(
                                    child: Text(
                                      isRtl
                                          ? juzArabicName
                                          : juzEnglishName,
                                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: isRtl
                                            ? 'Amiri'
                                            : 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: isRtl ? 18 : 16,
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.textPrimaryLight,
                                        letterSpacing: isRtl ? 0 : 0.2,
                                      ),
                                    ),
                                  ),

                                  if (!isRtl) ...[
                                    Text(
                                      juzArabicName,
                                      style: TextStyle(
                                        fontFamily: 'Amiri',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? AppColors.accentGold
                                            : AppColors.primaryTeal,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                  ],

                                  Icon(
                                    isRtl
                                        ? Icons.arrow_back_ios_rounded
                                        : Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
