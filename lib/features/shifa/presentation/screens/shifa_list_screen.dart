import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/settings_controller.dart';
import '../controller/shifa_notifier.dart';
import '../../data/models/shifa_constants.dart';
import '../../domain/entities/shifa_entity.dart';
import 'shifa_detail_screen.dart';

class ShifaListScreen extends ConsumerWidget {
  const ShifaListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shifaProvider);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUrdu ? 'شفا اور علاج' : 'Shifa & Healing',
          style: isUrdu ? GoogleFonts.notoNastaliqUrdu() : null,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              textAlign: isUrdu ? TextAlign.right : TextAlign.left,
              decoration: InputDecoration(
                hintText: isUrdu ? 'دعائیں تلاش کریں...' : 'Search Duas...',
                hintStyle: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 14) : null,
                prefixIcon: isUrdu ? null : const Icon(Icons.search),
                suffixIcon: isUrdu ? const Icon(Icons.search) : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onChanged: (value) {
                ref.read(shifaProvider.notifier).searchDuas(value);
              },
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
        child: switch (state) {
          ShifaInitial() || ShifaLoading() => const Center(child: CircularProgressIndicator()),
          ShifaLoaded loaded => loaded.searchQuery.isEmpty
              ? _CategoryList(categories: loaded.categories, isUrdu: isUrdu)
              : _SearchResults(duas: loaded.searchedDuas, isUrdu: isUrdu),
        },
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<ShifaCategory> categories;
  final bool isUrdu;
  const _CategoryList({required this.categories, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Text(
              isUrdu ? category.titleUr : category.titleEn,
              style: isUrdu 
                ? GoogleFonts.notoNastaliqUrdu(fontWeight: FontWeight.bold, fontSize: 16)
                : const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              isUrdu ? Icons.arrow_back_ios : Icons.arrow_forward_ios, 
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShifaDuaSubListScreen(category: category, isUrdu: isUrdu),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<ShifaEntity> duas;
  final bool isUrdu;
  const _SearchResults({required this.duas, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    if (duas.isEmpty) {
      return Center(
        child: Text(
          isUrdu ? 'کوئی نتیجہ نہیں ملا' : 'No results found.',
          style: isUrdu ? GoogleFonts.notoNastaliqUrdu() : null,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: duas.length,
      itemBuilder: (context, index) {
        final dua = duas[index];
        return DuaTile(dua: dua, isUrdu: isUrdu);
      },
    );
  }
}

class ShifaDuaSubListScreen extends StatelessWidget {
  final ShifaCategory category;
  final bool isUrdu;
  const ShifaDuaSubListScreen({super.key, required this.category, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUrdu ? category.titleUr : category.titleEn,
          style: isUrdu ? GoogleFonts.notoNastaliqUrdu(fontSize: 18) : null,
        ),
      ),
      body: Directionality(
        textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: category.duas.length,
          itemBuilder: (context, index) {
            return DuaTile(dua: category.duas[index], isUrdu: isUrdu);
          },
        ),
      ),
    );
  }
}

class DuaTile extends StatelessWidget {
  final ShifaEntity dua;
  final bool isUrdu;
  const DuaTile({super.key, required this.dua, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          isUrdu ? dua.titleUr : dua.titleEn,
          style: isUrdu 
            ? GoogleFonts.notoNastaliqUrdu(fontWeight: FontWeight.w600, fontSize: 16)
            : const TextStyle(fontWeight: FontWeight.w600),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShifaDetailScreen(dua: dua),
            ),
          );
        },
      ),
    );
  }
}
