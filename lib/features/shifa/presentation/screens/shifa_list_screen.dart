import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../controller/shifa_notifier.dart';
import '../../domain/entities/shifa_entity.dart';
import 'shifa_detail_screen.dart';

class ShifaListScreen extends ConsumerWidget {
  const ShifaListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shifaProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu
              ? 'شفا اور علاج'
              : (isPashto ? 'شفا او درملنه' : 'Shifa & Healing'),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
              decoration: InputDecoration(
                hintText: isUrdu
                    ? 'شفا تلاش کریں'
                    : (isPashto ? 'شفا لټول' : 'Search Shifa'),
                hintStyle: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primaryTeal.withValues(alpha: 0.7),
                ),
                filled: true,
                fillColor: isDark ? Colors.black26 : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primaryTeal,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
              ),
              onChanged: (value) {
                ref.read(shifaProvider.notifier).searchDuas(value);
              },
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: switch (state) {
          ShifaInitial() || ShifaLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryTeal),
          ),
          ShifaLoaded loaded => _ShifaListView(
            duas: loaded.searchQuery.isEmpty
                ? loaded.allDuas
                : loaded.searchedDuas,
            isRtl: isRtl,
            isUrdu: isUrdu,
            isPashto: isPashto,
            fontFamily: fontFamily,
          ),
        },
      ),
    );
  }
}

class _ShifaListView extends StatelessWidget {
  final List<ShifaEntity> duas;
  final bool isRtl;
  final bool isUrdu;
  final bool isPashto;
  final String fontFamily;

  const _ShifaListView({
    required this.duas,
    required this.isRtl,
    required this.isUrdu,
    required this.isPashto,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    if (duas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              isUrdu
                  ? 'کوئی نتیجہ نہیں ملا۔'
                  : (isPashto
                      ? 'هیڅ پایله ونه موندل شوه.'
                      : 'No results found.'),
              style: TextStyle(
                fontFamily: fontFamily,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: duas.length,
      itemBuilder: (context, index) {
        final dua = duas[index];
        return ShifaTile(
          dua: dua,
          duas: duas,
          index: index,
          isRtl: isRtl,
          isUrdu: isUrdu,
          isPashto: isPashto,
          fontFamily: fontFamily,
        );
      },
    );
  }
}

class ShifaTile extends StatelessWidget {
  final ShifaEntity dua;
  final List<ShifaEntity> duas;
  final int index;
  final bool isRtl;
  final bool isUrdu;
  final bool isPashto;
  final String fontFamily;

  const ShifaTile({
    super.key,
    required this.dua,
    required this.duas,
    required this.index,
    required this.isRtl,
    required this.isUrdu,
    required this.isPashto,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = isUrdu
        ? dua.titleUr
        : (isPashto
            ? (dua.titlePs.isNotEmpty ? dua.titlePs : dua.titleUr)
            : dua.titleEn);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.black45 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        title: Text(
          title,
          style: isRtl
              ? TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.8,
                )
              : const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShifaDetailScreen(
                duas: duas,
                initialIndex: index,
              ),
            ),
          );
        },
      ),
    );
  }
}
